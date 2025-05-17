import 'package:marcahoras3/domain_layer/models.dart';

class EmpregosArguments {
  final Empregos? emprego;

  const EmpregosArguments(this.emprego);

  factory EmpregosArguments.empty() {
    return const EmpregosArguments(null);
  }
}
