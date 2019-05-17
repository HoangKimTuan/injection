import 'package:dependencies/dependencies.dart';
import 'package:injection/infrastructure/database/database.dart';

import 'models.dart';

abstract class UserDatabase implements DatabaseHelper<User> {}

class UserDatabaseImplement extends BaseDatabaseImplement<User> implements UserDatabase {
  @override
  Map toMap(User object) {
    return object.toMap();
  }
}