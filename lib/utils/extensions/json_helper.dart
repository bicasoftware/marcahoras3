import '../typedefs.dart';

extension NodeHelper on JsonObj {
  T nodeValueOrDefault<T>(String nodeName, T defValue) {
    return this[nodeName] == null ? defValue : this[nodeName]!;
  }
}
