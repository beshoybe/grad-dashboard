abstract class BikesStates {}

class BikesInitialState extends BikesStates {}

class BikesLoadingState extends BikesStates {}

class BikesLoadedState extends BikesStates {}

class BikesErrorState extends BikesStates {
  final String message;
  BikesErrorState(this.message);
}

class BikeLockLoading extends BikesStates {}

class BikeLockLoaded extends BikesStates {}
