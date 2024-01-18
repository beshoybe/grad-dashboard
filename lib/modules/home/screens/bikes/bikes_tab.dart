import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/screens/bikes/provider/bikes_provider.dart';
import 'package:grad_dashboard/modules/home/screens/bikes/provider/bikes_states.dart';
import 'package:grad_dashboard/shared/extensions.dart';
import 'package:grad_dashboard/shared/models/bike_model.dart';

class BikesTab extends ConsumerStatefulWidget {
  const BikesTab({super.key});

  @override
  ConsumerState<BikesTab> createState() => _BikesTabState();
}

class _BikesTabState extends ConsumerState<BikesTab> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bikesProvider);
    final provider = ref.watch(bikesProvider.notifier);
    final bikesList = provider.bikesList;
    return Center(
      child: state is BikesLoadingState
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: bikesList.length,
              itemBuilder: (context, index) {
                return LockButton(
                    index: index, bike: provider.bikesList[index]);
              }),
    );
  }
}

class LockButton extends ConsumerStatefulWidget {
  final int index;
  final BikeModel bike;
  const LockButton({super.key, required this.index, required this.bike});

  @override
  ConsumerState<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends ConsumerState<LockButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bikesProvider.notifier);
    return Card(
      child: ListTile(
          leading: CircleAvatar(
            child: Text(widget.index.toString()),
          ),
          title: Text('Bike ID: ${widget.bike.id}'),
          subtitle: Text(
              'Bike Status: ${widget.bike.locked ? 'Locked' : 'Unlocked'}'),
          trailing: SizedBox(
            width: context.widthPercent(10),
            height: context.heightPercent(4),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.bike.locked ? Colors.green : Colors.red,
              ),
              onPressed: () async {
                if (loading) return;
                setState(() {
                  loading = true;
                });
                await provider.toogleLock(widget.bike.id);
                setState(() {
                  loading = false;
                });
              },
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.bike.locked ? 'Unlock' : 'Lock',
                      style: const TextStyle(color: Colors.white),
                    ),
            ),
          )),
    );
  }
}
