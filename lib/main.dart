import 'package:bank_app/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'logic/app/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(authenticationRepository: authenticationRepository));
}
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => AppNavigationCubits(),
//           ),
//           BlocProvider(
//             create: (context) => BottomNavigationCubit(),
//           ),
//         ],
//         child: const AppNavigationCubitLogics(),
//       ),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }
