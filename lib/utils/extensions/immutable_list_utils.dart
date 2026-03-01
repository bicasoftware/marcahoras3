extension ImmutableListHelpers<T> on List<T> {
  /// Generates a hard copy
  List<T> iCopy() {
    return [...this];
  }

  /// Generates a hard copy with a new item in it
  List<T> iAdd(T newItem) {
    return [...this, newItem];
  }

  /// Returns a hard copy, with the updated item
  List<T> iUpdateAt(T newItem, int pos) {
    final newList = this.iCopy();
    newList[pos] = newItem;

    return newList;
  }

  /// Returns a hard copy, with the updated item
  List<T> iUpdateItem({required T fresh, required T original}) {
    final index = this.indexWhere((it) => it == original);
    final newList = this.iCopy();
    newList[index] = fresh;

    return newList;
  }

  /// Returns a hard copy, with the updated item
  List<T> iUpdateWhere({
    required T fresh,
    required bool Function(T) where,
  }) {
    final index = this.indexWhere(where);
    final newList = this.iCopy();
    newList[index] = fresh;

    return newList;
  }

  List<T> iDelete(T toDeleteItem) {
    final newList = [...this];
    newList.removeAt(this.indexOf(toDeleteItem));
    return newList;
  }

  List<T> iDeleteAt(int pos) {
    final newList = [...this];
    newList.removeAt(pos);
    return newList;
  }
}
