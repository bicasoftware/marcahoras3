import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/utils/extensions/immutable_list_utils.dart';

void main() {
  group('ImmutableListHelpers', () {
    test('iCopy should return a hard copy of the list', () {
      final original = [1, 2, 3];
      final copy = original.iCopy();

      expect(copy, equals([1, 2, 3]));
      expect(copy, isNot(same(original))); // Verify it's a different instance
    });

    test('iAdd should return a new list with the added item', () {
      final original = [1, 2, 3];
      final newList = original.iAdd(4);

      expect(newList, equals([1, 2, 3, 4]));
      expect(newList, isNot(same(original)));
    });

    test(
        'iUpdateAt should return a new list with the item updated at the specified index',
        () {
      final original = [1, 2, 3];
      final newList = original.iUpdateAt(4, 1);

      expect(newList, equals([1, 4, 3]));
      expect(newList, isNot(same(original)));
    });

    test('iUpdateAt should throw RangeError if index is out of range', () {
      final original = [1, 2, 3];

      expect(() => original.iUpdateAt(4, 3), throwsRangeError);
    });

    test(
      'iUpdateItem should return a new list with the first matching item updated',
      () {
        final original = [1, 2, 3];
        final newList = original.iUpdateItem(4, 2);

        expect(newList, equals([1, 4, 3]));
        expect(newList, isNot(same(original)));
      },
    );

    test('iUpdateItem should throw StateError if item is not found', () {
      final original = [1, 2, 3];

      expect(() => original.iUpdateItem(4, 5), throwsRangeError);
    });

    test(
        'iUpdateWhere should return a new list with the item updated based on the condition',
        () {
      final original = [1, 2, 3];
      final newList = original.iUpdateWhere(
        newItem: 4,
        where: (item) => item == 2,
      );

      expect(newList, equals([1, 4, 3]));
      expect(newList, isNot(same(original)));
    });

    test('iUpdateWhere should throw StateError if condition is not met', () {
      final original = [1, 2, 3];

      expect(
        () => original.iUpdateWhere(newItem: 4, where: (item) => item == 5),
        throwsRangeError,
      );
    });

    test('iDelete should return a new list with the specified item removed',
        () {
      final original = [1, 2, 3];
      final newList = original.iDelete(2);

      expect(newList, equals([1, 3]));
      expect(newList, isNot(same(original)));
    });

    test('iDelete should throw RangeError if item is not found', () {
      final original = [1, 2, 3];

      expect(() => original.iDelete(4), throwsRangeError);
    });
  });
}
