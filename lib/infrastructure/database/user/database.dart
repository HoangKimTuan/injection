import 'package:dependencies/dependencies.dart';
import 'package:injection/infrastructure/database/database.dart';

import 'models.dart';

abstract class UserDatabase implements DatabaseHelper<User> {}

class UserDatabaseImplement extends BaseDatabaseImplement<User> implements UserDatabase {

  UserDatabaseImplement() {
    super.setTable("User");
  }

  @override
  Map toMap(User object) {
    return object.toMap();
  }
}