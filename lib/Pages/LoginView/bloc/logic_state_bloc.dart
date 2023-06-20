 import 'package:bloc/bloc.dart';
import "package:meta/meta.dart";


part 'logic_state_event.dart';
part 'logic_state_state.dart';

class LogicStateBloc extends Bloc<LogicStateEvent, LogicStateState> {
  LogicStateBloc() : super(LogicStateInitial()) {
    on<LogicStateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
