class Paginated<T> {

  const Paginated({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit
});

  final List<T> items;
  final int total;
  final int skip;
  final int limit;

  int get nextSkip => skip + items.length;

  bool get hasMore => nextSkip < total;
}