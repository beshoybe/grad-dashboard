import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/trips_history/provider/trips_history_states.dart';
import 'package:grad_dashboard/shared/models/trip_model.dart';

final tripsHistoryProvider = StateNotifierProvider.family<TripsHistoryProvider,
    TripsHistoryStates, String>(
  (ref, id) => TripsHistoryProvider(uid: id),
);

class TripsHistoryProvider extends StateNotifier<TripsHistoryStates> {
  final String uid;
  TripsHistoryProvider({required this.uid})
      : super(TripsHistoryInitialState()) {
    getTripsHistory();
  }
  final tripsList = <TripModel>[];
  Future<void> getTripsHistory() async {
    state = TripsHistoryLoadingState();
    final trips = await FirebaseFirestore.instance
        .collection('trips')
        .where('userId', isEqualTo: uid)
        .get();
    final list = trips.docs.map((e) {
      final data = e.data();
      final model = TripModel.fromJson(data);
      model.id = e.id;
      return model;
    }).toList();
    tripsList.clear();
    tripsList.addAll(list);
    state = TripsHistoryLoadedState();
  }
}
