import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:salahly/features/client/booking/data/datasources/bookings_remot_data_source.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repos/bookings_repo.dart';
import '../datasources/bookings_local_data_source.dart';


class BookingsRepoImpl implements BookingsRepo {
  final BookingsRemoteDataSource remoteDataSource;
  final BookingsLocalDataSource localDataSource;

  BookingsRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<BookingEntity>>> fetchActiveBookings() async {
    try {
      final remoteBookings = await remoteDataSource.fetchActiveBookings();
      await localDataSource.cacheBookings(remoteBookings); 
      return Either.right(remoteBookings);
    } on FirebaseException catch (e) {
      
      final cached = localDataSource.getCachedBookings();
      if (cached.isNotEmpty) return Either.right(cached);
      return Either.left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Either.left(ServerFailure('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> fetchScheduledBookings() async {
    try {
      final remoteBookings = await remoteDataSource.fetchScheduledBookings();
      return Either.right(remoteBookings);
    } on FirebaseException catch (e) {
      return Either.left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Either.left(ServerFailure('default_failure'.tr()));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> fetchHistoryBookings() async {
    try {
      final remoteBookings = await remoteDataSource.fetchHistoryBookings();
      return Either.right(remoteBookings);
    } on FirebaseException catch (e) {
      return Either.left(ServerFailure.fromFirebaseException(e));
    } catch (e) {
      return Either.left(ServerFailure('default_failure'.tr()));
    }
  }
}