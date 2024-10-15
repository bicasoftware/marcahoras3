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
  List<T> iUpdateItem(T newItem, T oldItem) {
    final index = this.indexWhere((it) => it == oldItem);
    final newList = this.iCopy();
    newList[index] = newItem;

    return newList;
  }

  /// Returns a hard copy, with the updated item
  List<T> iUpdateWhere({
    required T newItem,
    required bool Function(T) where,
  }) {
    final index = this.indexWhere(where);
    final newList = this.iCopy();
    newList[index] = newItem;

    return newList;
  }

  List<T> iDelete(T toDeleteItem) {
    final newList = this.iCopy();
    newList.removeAt(this.indexOf(toDeleteItem));
    return newList;
  }

  /// Returns a hard copy, with the updated item
  List<T> iDeleteWhere({
    required T newItem,
    required bool Function(T) where,
  }) {
    final index = this.indexWhere(where);
    final newList = this.iCopy();
    newList[index] = newItem;

    return newList;
  }
}
