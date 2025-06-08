import 'package:marcahoras3/domain_layer/models.dart';

class EmpregosArguments {
  final Empregos? emprego;
  final bool isInsert;

  const EmpregosArguments(this.emprego, this.isInsert);

  factory EmpregosArguments.empty() {
    return const EmpregosArguments(null, true);
  }
}
