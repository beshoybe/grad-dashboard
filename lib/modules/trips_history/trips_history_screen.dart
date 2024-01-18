import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/trips_history/provider/trips_history_provider.dart';
import 'package:grad_dashboard/modules/trips_history/provider/trips_history_states.dart';
import 'package:grad_dashboard/shared/extensions.dart';

class TripsHistoryScreen extends ConsumerWidget {
  final String userID;
  const TripsHistoryScreen({super.key, required this.userID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tripsHistoryProvider(userID).notifier);
    final state = ref.watch(tripsHistoryProvider(userID));
    final tripsList = provider.tripsList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips History'),
      ),
      body: Center(
          child: state is TripsHistoryLoadingState
              ? const CircularProgressIndicator()
              : tripsList.isEmpty
                  ? const Text('No Trips')
                  : ListView.builder(
                      itemCount: tripsList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: context.heightPercent(20),
                          width: double.infinity,
                          child: Card(
                              margin: const EdgeInsets.all(15.0),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          tripCardField('Trip ID',
                                              tripsList[index].id.toString()),
                                          tripCardField(
                                              'Bike ID',
                                              tripsList[index]
                                                  .bikeId
                                                  .toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          tripCardField(
                                              'Start Time',
                                              tripsList[index]
                                                  .startDateTime
                                                  .toString()),
                                          tripCardField(
                                              'End Time',
                                              tripsList[index]
                                                  .endDateTime
                                                  .toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          tripCardField('Price',
                                              '${tripsList[index].price ?? 0} EGP'),
                                          tripCardField('', ''),
                                        ],
                                      ),
                                    ),
                                    if (tripsList[index].image != null)
                                      Expanded(
                                          child: Image.network(
                                              tripsList[index].image ?? ''))
                                    else
                                      const Spacer()
                                  ],
                                ),
                              )),
                        );
                      },
                    )),
    );
  }

  Widget tripCardField(String label, String value) {
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
