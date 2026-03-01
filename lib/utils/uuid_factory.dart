import 'package:sane_uuid/uuid.dart' show Uuid;

String generateId() {
  return Uuid.v4().toString();
}
