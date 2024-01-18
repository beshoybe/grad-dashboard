import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/screens/bikes/provider/bikes_states.dart';
import 'package:grad_dashboard/shared/models/bike_model.dart';

final bikesProvider =
    StateNotifierProvider.autoDispose<BikesProvider, BikesStates>(
        (ref) => BikesProvider());

class BikesProvider extends StateNotifier<BikesStates> {
  BikesProvider() : super(BikesInitialState()) {
    getBikes();
  }
  final bikesList = <BikeModel>[];
  Future<void> getBikes() async {
    state = BikesLoadingState();
    final bikes = await FirebaseFirestore.instance.collection('Bikes').get();
    final list = bikes.docs.map((e) {
      final data = e.data();
      return BikeModel(
        id: e.id,
        bikeId: data['BikeID'],
        location: data['location'],
        geofenceCenter: data['geofenceCenter'],
        geofenceRadius: data['geofenceRadius'],
        locked: data['locked'],
      );
    }).toList();
    bikesList.clear();
    bikesList.addAll(list);
    state = BikesLoadedState();
  }

  Future<void> toogleLock(String bikeId) async {
    if (state is BikeLockLoading) return;
    state = BikeLockLoading();
    final bike = bikesList.firstWhere((element) => element.id == bikeId);
    bike.locked = !bike.locked;
    await FirebaseFirestore.instance
        .collection('Bikes')
        .doc(bikeId)
        .update({'locked': bike.locked});
    state = BikesLoadedState();
  }
}
