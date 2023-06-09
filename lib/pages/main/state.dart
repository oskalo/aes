abstract class MainState {}

class InitState extends MainState {}
class ResultState extends MainState {
  List<String> keys;
  ResultState(this.keys);
}

class EmptyAmountState extends MainState {
  final String message;
  EmptyAmountState(this.message);
}

class ErrorState extends MainState {
  final String message;
  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class ElemState {}

class InitElemState extends ElemState {}

class CopyElemState extends ElemState {}
