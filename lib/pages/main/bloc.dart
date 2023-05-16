import 'package:aes/pages/main/service.dart';
import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(InitState()) {
    on<GetKeysEvent>(_onGetKeysEvent);
    on<EmptyAmountEvent>(_onEmptyAmountEvent);
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitEvent) {
      yield InitState();
    }
  }

  _onGetKeysEvent(
    event,
    emit,
  ) async {
    try {
      emit(ResultState(GenerateKeys(event.amount)));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onEmptyAmountEvent(
    event,
    emit,
  ) async {
    emit(EmptyAmountState());
  }
}

class ElemBloc extends Bloc<ElemEvent, ElemState> {
  ElemBloc() : super(InitElemState()) {
    on<CopyElemEvent>(_copyElemEvent);
    on<InitElemEvent>(_initElemEvent);
  }

  _copyElemEvent(
    event,
    emit,
  ) async {
    emit(CopyElemState());
  }

  _initElemEvent(
    event,
    emit,
  ) async {
    emit(InitElemState());
  }

  @override
  Stream<ElemState> mapEventToState(ElemEvent event) async* {
    if (event is InitElemEvent) {
      yield InitElemState();
    }
  }
}
