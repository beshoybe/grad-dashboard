abstract class TripsHistoryStates {}

class TripsHistoryInitialState extends TripsHistoryStates {}

class TripsHistoryLoadingState extends TripsHistoryStates {}

class TripsHistoryLoadedState extends TripsHistoryStates {}

class TripsHistoryErrorState extends TripsHistoryStates {
  final String message;
  TripsHistoryErrorState(this.message);
}
