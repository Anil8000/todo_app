import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/controllers/device_details/device_details_event.dart';
import 'package:todo_demo/controllers/device_details/device_details_state.dart';
import 'package:todo_demo/models/device_model.dart';
import 'package:todo_demo/services/api_service.dart';
import 'package:todo_demo/services/db_helper.dart';

class DeviceDetailsBloc extends Bloc<DeviceDetailsEvent, DeviceDetailsState> {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _localDatabase = DatabaseHelper();

  DeviceDetailsBloc() : super(ApiInitial()) {
    on<FetchApiEvent>((event, emit) async {
      emit(ApiLoading());
      await _localDatabase.initDatabase();
      try {
        final data = await _apiService.fetchData();
        await _localDatabase.cacheData(data);
        emit(ApiLoaded(data));
      } catch (_) {
        final cachedData = await _localDatabase.getCachedData();
        if (cachedData.isNotEmpty) {
          emit(ApiLoaded(cachedData));
        } else {
          emit(ApiError());
        }
      }
    });
  }
}
