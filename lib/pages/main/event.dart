abstract class MainEvent {}

class InitEvent extends MainEvent {}

class GetKeysEvent extends MainEvent {
  int amount;
  GetKeysEvent(this.amount);
}

class EmptyAmountEvent extends MainEvent {
  String message;
  EmptyAmountEvent(this.message);
}


abstract class ElemEvent {}

class InitElemEvent extends ElemEvent {}

class CopyElemEvent extends ElemEvent {
}
