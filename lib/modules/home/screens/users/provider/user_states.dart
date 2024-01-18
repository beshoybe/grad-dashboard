abstract class UsersStates {}

class UsersInitialState extends UsersStates {}

class UsersLoadingState extends UsersStates {}

class UsersLoadedState extends UsersStates {}

class UsersErrorState extends UsersStates {
  final String message;
  UsersErrorState(this.message);
}
