import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeEvent { deviceDetails, toDo }

class HomeBloc extends Bloc<HomeEvent, int> {
  HomeBloc() : super(0) {
    on<HomeEvent>((event, emit) {
      switch (event) {
        case HomeEvent.deviceDetails:
          emit(0);
          break;
        case HomeEvent.toDo:
          emit(1);
          break;
      }
    });
  }
}
