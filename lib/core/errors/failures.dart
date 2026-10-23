import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromFirebaseException(FirebaseException e) {
    print("🚨 [Firebase Exception Code]: ${e.code}");
    print("🚨 [Firebase Exception Message]: ${e.message}");

    switch (e.code) {
      case 'permission-denied':
        return ServerFailure('permission-denied'.tr());

      case 'unavailable':
        return ServerFailure('unavailable'.tr());

      case 'not-found':
        return ServerFailure('not-found'.tr());

      case 'already-exists':
        return ServerFailure('already-exists'.tr());

      case 'unauthenticated':
        return ServerFailure('unauthenticated'.tr());

      case 'network-request-failed':
        return ServerFailure('network-request-failed'.tr());

      default:
        return ServerFailure(e.message ?? 'default_failure'.tr());
    }
  }
}
