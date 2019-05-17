import "package:dependencies/dependencies.dart";
import 'package:injection/infrastructure/database/user/database.dart';

class DatabaseModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton<UserDatabase>((i, p) => UserDatabaseImplement());
  }
}