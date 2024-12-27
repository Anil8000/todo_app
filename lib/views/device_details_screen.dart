import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/controllers/device_details/device_details_state.dart';
import 'package:todo_demo/utils/app_strings.dart';
import 'package:todo_demo/views/widgets/device_details_tile.dart';
import 'package:todo_demo/views/widgets/no_data.dart';
import '../controllers/device_details/device_details_bloc.dart';

class DeviceDetailsScreen extends StatelessWidget {
  const DeviceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.deviceDetails),
      ),
      body: BlocBuilder<DeviceDetailsBloc, DeviceDetailsState>(
        builder: (context, state) {
          if (state is ApiLoading) return const Center(child: CircularProgressIndicator());
          if (state is ApiError) {
            return NoDataWidget(text: AppStrings.failedToLoad);
          }
          if (state is ApiLoaded) {
            if (state.items.isEmpty) {
              return NoDataWidget(text: AppStrings.noDataAvailable);
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return DeviceDetailsTile(
                  name: item.name,
                  details: item.data ?? AppStrings.noDetailsAvailable,
                );
              },
            );
          }
          return NoDataWidget(text: AppStrings.noDataAvailable);
        },
      ),
    );
  }
}
