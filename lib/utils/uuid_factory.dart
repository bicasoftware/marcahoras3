import 'package:sane_uuid/uuid.dart' show Uuid;

class UuidFactory {
  static String build() {
    return Uuid.v4().toString();
  }
}
