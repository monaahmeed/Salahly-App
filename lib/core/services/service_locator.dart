import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salahly/features/client/booking/data/datasources/bookings_remot_data_source.dart';
import 'package:salahly/features/client/booking/presentation/manger/booking_cubit/bookings_cubit.dart';
import '../../features/client/booking/data/datasources/bookings_local_data_source.dart';
import '../../features/client/booking/data/repos/bookings_repo_impl.dart';
import '../../features/client/booking/domain/repos/bookings_repo.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  
  final bookingsBox = await Hive.openBox('bookings_box');
  getIt.registerSingleton<Box>(bookingsBox, instanceName: 'bookingsBox');
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  
  getIt.registerLazySingleton<BookingsLocalDataSource>(
    () => BookingsLocalDataSourceImpl(bookingsBox: getIt(instanceName: 'bookingsBox')),
  );
  getIt.registerLazySingleton<BookingsRemoteDataSource>(
    () => BookingsRemoteDataSourceImpl(firestore: getIt(), auth: getIt()),
  );

  getIt.registerFactory(() => BookingsCubit(getIt<BookingsRepo>()));
  getIt.registerLazySingleton<BookingsRepo>(
    () => BookingsRepoImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );
}