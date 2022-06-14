import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:brain_saver_flutter/views/screens/home_nav/cubit/home_nav_cubit.dart';
import 'package:brain_saver_flutter/views/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeNavScreen());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeNavCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BRAIN SAVER'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AppBloc>().add(AppLogoutRequested());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder<HomeNavCubit, HomeNavState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.index,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Schedule',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Todo',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note),
                  label: 'Notes',
                ),
              ],
              onTap: (index) {
                context.read<HomeNavCubit>().setNavBarItemSelected(index);
              },
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<HomeNavCubit, HomeNavState>(
            builder: (context, state) {
              switch (state.index) {
                case 0:
                  return ScheduleScreen();
                case 1:
                  return const TodoScreen();
                case 2:
                  return const NoteScreen();
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
