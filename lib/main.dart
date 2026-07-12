import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'core/dependency_injection/injection.dart' as di;
import 'core/routing/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth_state.dart';
import 'features/auth/domain/usecases/login_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const bool skipLogin = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase: di.sl<LoginUseCase>(),
        registerUseCase: di.sl<RegisterUseCase>(),
        logoutUseCase: di.sl<LogoutUseCase>(),
        isLoggedInUseCase: di.sl<IsLoggedInUseCase>(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.login,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
