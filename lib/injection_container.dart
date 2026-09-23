import 'package:get_it/get_it.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance; // sl = Service Locator

void init() {
  // 1. تسجيل الـ Bloc
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  // 2. تسجيل الـ Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}
