import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Ride
  
  // Bloc
  // sl.registerFactory(() => RideBloc(sl()));

  // Use cases
  // sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  // Repository
  // sl.registerLazySingleton<RideRepository>(() => RideRepositoryImpl(sl()));

  // Core
  
  // External (SharedPreferences, Dio, etc.)
}
