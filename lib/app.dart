import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/app/bloc/app_bloc.dart';
import 'logic/app/bloc/app_states.dart';
import 'logic/app/routes.dart';
import 'logic/bottom_navigation/bottom_navigation_cubit.dart';
import 'logic/edit/edit_cubit.dart';
import 'repository/authentication_repository.dart';
import 'repository/firestore_repository.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required FirestoreRepository firestoreRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _firestoreRepository = firestoreRepository;

  final AuthenticationRepository _authenticationRepository;
  final FirestoreRepository _firestoreRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _firestoreRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => BottomNavigationCubit(),
          ),
          BlocProvider(
            create: (_) => EditCubit(
              _firestoreRepository,
              _authenticationRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
