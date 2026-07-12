import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_service.dart';
import '../services/storage_service.dart';
import '../services/firebase_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => http.Client());

  // Core
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => StorageService(sharedPreferences));
  sl.registerLazySingleton(() => FirebaseService());

  // Auth Feature
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseService: sl<FirebaseService>(),
      storageService: sl<StorageService>(),
    ),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => IsLoggedInUseCase(sl<AuthRepository>()));

  // Other features will be registered here
}
