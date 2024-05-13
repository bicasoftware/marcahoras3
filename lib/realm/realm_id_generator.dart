import 'package:realm/realm.dart';

class IdGenerator {
  static String generate() => (Uuid.v4()).toString();
}
