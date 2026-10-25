import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/api_constants.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/products/data/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class _Reply {
  const _Reply(this.body, {this.status = 200});

  final Object body;
  final int status;
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.responder);

  final _Reply Function(RequestOptions options) responder;

  @override
  Future<ResponseBody> fetch(
      RequestOptions options,
      Stream<Uint8List>? requestStream,
      Future<void>? cancelFuture,
      ) async {
    final reply = responder(options);
    return ResponseBody.fromString(
      jsonEncode(reply.body),
      reply.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ProductRepositoryImpl _repo(_Reply Function(RequestOptions) responder) {
  final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl))
    ..httpClientAdapter = _FakeAdapter(responder);
  return ProductRepositoryImpl(dio);
}

const _summaryPage = <String, Object>{
  'products': [
    {
      'id': 1,
      'title': 'Essence Mascara Lash Princess',
      'price': 9.99,
      'thumbnail':
      'https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp',
      'rating': 2.56,
      'discountPercentage': 10.48,
    },
    {
      'id': 2,
      'title': 'Eyeshadow Palette with Mirror',
      'price': 19.99,
      'thumbnail':
      'https://cdn.dummyjson.com/product-images/beauty/eyeshadow-palette-with-mirror/thumbnail.webp',
      'rating': 2.86,
      'discountPercentage': 18.19,
    },
  ],
  'total': 194,
  'skip': 0,
  'limit': 10,
};

// Groceries product: note there is no `brand` field.
const _groceryProduct = <String, Object>{
  'id': 16,
  'title': 'Apple',
  'description': 'Fresh and crisp apples.',
  'category': 'groceries',
  'price': 1.99,
  'discountPercentage': 12.62,
  'rating': 4.19,
  'stock': 8,
  'tags': ['fruits'],
  'sku': 'GRO-BRD-APP-016',
  'weight': 9,
  'dimensions': {'width': 13.66, 'height': 11, 'depth': 9.73},
  'warrantyInformation': '3 year warranty',
  'shippingInformation': 'Ships in 2 weeks',
  'availabilityStatus': 'In Stock',
  'reviews': [
    {
      'rating': 5,
      'comment': 'Very satisfied!',
      'date': '2025-04-30T09:41:02.053Z',
      'reviewerName': 'Sophia Brown',
      'reviewerEmail': 'sophia.brown@x.dummyjson.com',
    },
  ],
  'returnPolicy': '90 days return policy',
  'minimumOrderQuantity': 7,
  'meta': {
    'createdAt': '2026-03-03T03:28:19.029Z',
    'updatedAt': '2026-04-21T05:42:48.171Z',
    'barcode': '7962803553314',
    'qrCode': 'https://cdn.dummyjson.com/public/qr-code.png',
  },
  'images': ['https://cdn.dummyjson.com/product-images/groceries/apple/1.webp'],
  'thumbnail':
  'https://cdn.dummyjson.com/product-images/groceries/apple/thumbnail.webp',
};

void main() {
  group('ProductRepositoryImpl', () {
    test('getProducts parses a page and sends paging/select params', () async {
      late RequestOptions captured;
      final repo = _repo((options) {
        captured = options;
        return const _Reply(_summaryPage);
      });

      final page = await repo.getProducts(limit: 10);

      expect(page.items, hasLength(2));
      expect(page.items.first.title, 'Essence Mascara Lash Princess');
      expect(page.items.first.discountedPrice, closeTo(8.94, 0.001));
      expect(page.total, 194);
      expect(page.hasMore, isTrue);
      expect(page.nextSkip, 2);
      expect(captured.path, '/products');
      expect(captured.queryParameters['limit'], 10);
      expect(captured.queryParameters['select'], ApiConstants.summaryFields);
    });

    test('getProductById parses a product without brand', () async {
      final repo = _repo((_) => const _Reply(_groceryProduct));

      final product = await repo.getProductById(16);

      expect(product.brand, isNull);
      expect(product.category, 'groceries');
      expect(product.reviews, hasLength(1));
      expect(product.reviews.first.reviewerName, 'Sophia Brown');
      expect(product.dimensions?.height, 11.0);
      expect(product.meta?.createdAt?.year, 2026);
      expect(product.discountedPrice, closeTo(1.74, 0.001));
      expect(product.isInStock, isTrue);
      expect(product.toSummary().id, 16);
    });

    test('getCategories parses slug and name', () async {
      final repo = _repo(
            (_) => const _Reply([
          {
            'slug': 'beauty',
            'name': 'Beauty',
            'url': 'https://dummyjson.com/products/category/beauty',
          },
          {
            'slug': 'mens-shirts',
            'name': 'Mens Shirts',
            'url': 'https://dummyjson.com/products/category/mens-shirts',
          },
        ]),
      );

      final categories = await repo.getCategories();

      expect(categories.map((c) => c.slug), ['beauty', 'mens-shirts']);
      expect(categories.last.name, 'Mens Shirts');
    });

    test('maps a 404 response to NotFoundFailure', () async {
      final repo = _repo(
            (_) => const _Reply(
          {'message': "Product with id '999' not found"},
          status: 404,
        ),
      );

      expect(repo.getProductById(999), throwsA(isA<NotFoundFailure>()));
    });
  });
}