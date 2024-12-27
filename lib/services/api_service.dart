import 'package:dio/dio.dart';
import 'package:todo_demo/utils/api_util.dart';
import '../models/device_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<DeviceModel>> fetchData() async {
    try {
      final response = await _dio.get(ApiUtil.baseUrl+ApiUtil.objects);
      print('Response data: ${response.data}'); // Log the response
      return (response.data as List).map((item) => DeviceModel.fromJson(item)).toList();
    } catch (error) {
      print('Error occurred: $error'); // Log error for debugging
      throw Exception('Failed to load data');
    }
  }
}
