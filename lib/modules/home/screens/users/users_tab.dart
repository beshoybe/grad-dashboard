import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/screens/users/provider/user_states.dart';
import 'package:grad_dashboard/modules/home/screens/users/provider/users_provider.dart';
import 'package:grad_dashboard/modules/trips_history/trips_history_screen.dart';
import 'package:grad_dashboard/shared/models/user_model.dart';

class UsersTab extends ConsumerWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(usersProvider);
    final provider = ref.watch(usersProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text('Users', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: state is UsersLoadingState
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.usersList.length,
                    itemBuilder: (context, index) =>
                        userCardBuilder(provider.usersList[index], context)),
          ),
        ],
      ),
    );
  }

  Widget userCardBuilder(UserModel model, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(model.name?[0] ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      userCardField('Name', model.name ?? 'Unknown'),
                      userCardField('Email', model.email ?? 'Unknown'),
                    ],
                  ),
                  Row(
                    children: [
                      userCardField('Phone', model.phone ?? 'Unknown'),
                      userCardField('Balance', '${model.balance ?? 0} EGP'),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripsHistoryScreen(
                                userID: model.uid,
                              )));
                },
                icon: const Icon(Icons.history))
          ],
        ),
      ),
    );
  }

  Widget userCardField(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
