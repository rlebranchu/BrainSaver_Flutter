import 'package:brain_saver_flutter/bloc_observer.dart';
import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/config/routes.dart';
import 'package:brain_saver_flutter/firebase_options.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:brain_saver_flutter/views/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Get Firestore Configuration and start connection
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Create unique AutheRepository instance
      final AuthRepository authRepository = AuthRepository();
      runApp(App(authRepository: authRepository));
    },
    blocObserver: AppBlocObserver(),
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  const App({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      // Create Global Bloc : AppBLoc
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initalization of Material App Root
    return MaterialApp(
      theme: AppTheme().Theme,
      title: 'Brain Saver',
      home: FlowBuilder(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPage,
      ),
    );
  }
}
