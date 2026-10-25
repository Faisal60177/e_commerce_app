enum ProductSort {
  relevance('Relevance'),
  newest('Newest first', sortBy: 'id', order: 'desc'),
  priceLowToHigh('Price: Low to High', sortBy: 'price', order: 'asc'),
  priceHighToLow('Price: High to Low', sortBy: 'price', order: 'desc'),
  topRated('Top rated', sortBy: 'rating', order: 'desc'),
  biggestDiscount(
    'Biggest discount',
    sortBy: 'discountPercentage',
    order: 'desc',
  ),
  nameAToZ('Name: A to Z', sortBy: 'title', order: 'asc');

  const ProductSort(this.label, {this.sortBy, this.order});

  final String label;
  final String? sortBy;
  final String? order;

  Map<String, dynamic> get queryParameters => {
    if (sortBy != null) 'sortBy': sortBy,
    if (order != null) 'order': order,
  };
}