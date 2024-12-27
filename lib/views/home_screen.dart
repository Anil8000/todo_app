import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/controllers/home/home_bloc.dart';
import 'package:todo_demo/views/device_details_screen.dart';
import 'package:todo_demo/views/todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, int>(
          builder: (context, currentIndex) {
            switch (currentIndex) {
              case 0:
                return const DeviceDetailsScreen();
              case 1:
                return const TodoScreen();
              default:
                return const DeviceDetailsScreen();
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == 0) {
                  context.read<HomeBloc>().add(HomeEvent.deviceDetails);
                } else {
                  context.read<HomeBloc>().add(HomeEvent.toDo);
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'To do'),
              ],
            );
          },
        ),
      ),
    );
  }
}
