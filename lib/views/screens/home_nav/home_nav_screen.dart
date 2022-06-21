import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:brain_saver_flutter/views/screens/home_nav/cubit/home_nav_cubit.dart';
import 'package:brain_saver_flutter/views/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Principal Page of App to Manage Bottom Navigation Bar with Cubit
class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeNavScreen());

  @override
  Widget build(BuildContext context) {
    // Initialisation of Cubit HomeNav
    return BlocProvider(
      create: (_) => HomeNavCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BRAIN SAVER'),
          actions: [
            // Generation of Logout BUtton
            IconButton(
              onPressed: () {
                // Call Lougout to App Bloc
                context.read<AppBloc>().add(AppLogoutRequested());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        // Call Cubit Home Nav to listen and call change tab functions
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
                // Call Function to change Tab content
                context.read<HomeNavCubit>().setNavBarItemSelected(index);
              },
            );
          },
        ),
        // Definition of Contionnal Content linked to state of Home Nav Cubit
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<HomeNavCubit, HomeNavState>(
            builder: (context, state) {
              // The index of state represent the selected tab of bottom navigation
              // 0 : Schedule || 1 : Todo (Default) || 2 : Note
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
