import 'package:todo_demo/models/device_model.dart';

abstract class DeviceDetailsState {}

class ApiInitial extends DeviceDetailsState {}

class ApiLoading extends DeviceDetailsState {}

class ApiLoaded extends DeviceDetailsState {
  final List<DeviceModel> items;
  ApiLoaded(this.items);
}

class ApiError extends DeviceDetailsState {}