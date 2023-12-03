void assertAllNotNull(List<Object?> values) {
  assert(values.every((it) => it != null));
}
