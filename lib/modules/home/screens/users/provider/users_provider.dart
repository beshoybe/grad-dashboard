import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grad_dashboard/modules/home/screens/users/provider/user_states.dart';
import 'package:grad_dashboard/shared/models/user_model.dart';

final usersProvider =
    StateNotifierProvider.autoDispose<UsersProvider, UsersStates>(
        (ref) => UsersProvider());

class UsersProvider extends StateNotifier<UsersStates> {
  UsersProvider() : super(UsersInitialState()) {
    getUsers();
  }
  final usersList = <UserModel>[];
  Future<void> getUsers() async {
    try {
      state = UsersLoadingState();
      final users = await FirebaseFirestore.instance.collection('users').get();

      usersList.clear();
      final list = users.docs.map((e) {
        final data = e.data();
        return UserModel(
          uid: e.id,
          name: data['name'],
          email: data['email'],
          phone: data['phone'],
          image: data['image'],
          balance: data['balance'],
        );
      }).toList();
      usersList.addAll(list);
      state = UsersLoadedState();
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      state = UsersErrorState(e.toString());
    }
  }
}
