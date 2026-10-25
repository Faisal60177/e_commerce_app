// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

 int get id; String get title; String get description; String get category; double get price; double get discountPercentage; double get rating; int get stock; List<String> get tags; String? get brand; String? get sku; double? get weight; ProductDimensions? get dimensions; String? get warrantyInformation; String? get shippingInformation; String? get availabilityStatus; List<ProductReview> get reviews; String? get returnPolicy; int? get minimumOrderQuantity; ProductMeta? get meta; List<String> get images; String get thumbnail;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Product;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.discountPercentage, _this.discountPercentage) || other.discountPercentage == _this.discountPercentage)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.stock, _this.stock) || other.stock == _this.stock)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.brand, _this.brand) || other.brand == _this.brand)&&(identical(other.sku, _this.sku) || other.sku == _this.sku)&&(identical(other.weight, _this.weight) || other.weight == _this.weight)&&(identical(other.dimensions, _this.dimensions) || other.dimensions == _this.dimensions)&&(identical(other.warrantyInformation, _this.warrantyInformation) || other.warrantyInformation == _this.warrantyInformation)&&(identical(other.shippingInformation, _this.shippingInformation) || other.shippingInformation == _this.shippingInformation)&&(identical(other.availabilityStatus, _this.availabilityStatus) || other.availabilityStatus == _this.availabilityStatus)&&const DeepCollectionEquality().equals(other.reviews, _this.reviews)&&(identical(other.returnPolicy, _this.returnPolicy) || other.returnPolicy == _this.returnPolicy)&&(identical(other.minimumOrderQuantity, _this.minimumOrderQuantity) || other.minimumOrderQuantity == _this.minimumOrderQuantity)&&(identical(other.meta, _this.meta) || other.meta == _this.meta)&&const DeepCollectionEquality().equals(other.images, _this.images)&&(identical(other.thumbnail, _this.thumbnail) || other.thumbnail == _this.thumbnail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Product;
  return Object.hashAll([runtimeType,_this.id,_this.title,_this.description,_this.category,_this.price,_this.discountPercentage,_this.rating,_this.stock,const DeepCollectionEquality().hash(_this.tags),_this.brand,_this.sku,_this.weight,_this.dimensions,_this.warrantyInformation,_this.shippingInformation,_this.availabilityStatus,const DeepCollectionEquality().hash(_this.reviews),_this.returnPolicy,_this.minimumOrderQuantity,_this.meta,const DeepCollectionEquality().hash(_this.images),_this.thumbnail]);
}

@override
String toString() {
  final _this = this as Product;
  return 'Product(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, category: ${_this.category}, price: ${_this.price}, discountPercentage: ${_this.discountPercentage}, rating: ${_this.rating}, stock: ${_this.stock}, tags: ${_this.tags}, brand: ${_this.brand}, sku: ${_this.sku}, weight: ${_this.weight}, dimensions: ${_this.dimensions}, warrantyInformation: ${_this.warrantyInformation}, shippingInformation: ${_this.shippingInformation}, availabilityStatus: ${_this.availabilityStatus}, reviews: ${_this.reviews}, returnPolicy: ${_this.returnPolicy}, minimumOrderQuantity: ${_this.minimumOrderQuantity}, meta: ${_this.meta}, images: ${_this.images}, thumbnail: ${_this.thumbnail})';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String category, double price, double discountPercentage, double rating, int stock, List<String> tags, String? brand, String? sku, double? weight, ProductDimensions? dimensions, String? warrantyInformation, String? shippingInformation, String? availabilityStatus, List<ProductReview> reviews, String? returnPolicy, int? minimumOrderQuantity, ProductMeta? meta, List<String> images, String thumbnail
});


$ProductDimensionsCopyWith<$Res>? get dimensions;$ProductMetaCopyWith<$Res>? get meta;

}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? rating = null,Object? stock = null,Object? tags = null,Object? brand = freezed,Object? sku = freezed,Object? weight = freezed,Object? dimensions = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? availabilityStatus = freezed,Object? reviews = null,Object? returnPolicy = freezed,Object? minimumOrderQuantity = freezed,Object? meta = freezed,Object? images = null,Object? thumbnail = null,}) {
  return _then(Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as ProductDimensions?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ProductReview>,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,minimumOrderQuantity: freezed == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ProductMeta?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDimensionsCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $ProductDimensionsCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
    return null;
  }

  return $ProductMetaCopyWith<$Res>(_self.meta!, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  List<String> tags,  String? brand,  String? sku,  double? weight,  ProductDimensions? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  List<ProductReview> reviews,  String? returnPolicy,  int? minimumOrderQuantity,  ProductMeta? meta,  List<String> images,  String thumbnail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.tags,_that.brand,_that.sku,_that.weight,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.images,_that.thumbnail);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  List<String> tags,  String? brand,  String? sku,  double? weight,  ProductDimensions? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  List<ProductReview> reviews,  String? returnPolicy,  int? minimumOrderQuantity,  ProductMeta? meta,  List<String> images,  String thumbnail)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.tags,_that.brand,_that.sku,_that.weight,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.images,_that.thumbnail);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String category,  double price,  double discountPercentage,  double rating,  int stock,  List<String> tags,  String? brand,  String? sku,  double? weight,  ProductDimensions? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  List<ProductReview> reviews,  String? returnPolicy,  int? minimumOrderQuantity,  ProductMeta? meta,  List<String> images,  String thumbnail)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.tags,_that.brand,_that.sku,_that.weight,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.images,_that.thumbnail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product extends Product {
  const _Product({required this.id, required this.title, required this.description, required this.category, required this.price, this.discountPercentage = 0.0, this.rating = 0.0, this.stock = 0,  List<String> tags = const [], this.brand, this.sku, this.weight, this.dimensions, this.warrantyInformation, this.shippingInformation, this.availabilityStatus,  List<ProductReview> reviews = const [], this.returnPolicy, this.minimumOrderQuantity, this.meta,  List<String> images = const [], this.thumbnail = ''}): _tags = tags,_reviews = reviews,_images = images,super._();
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String category;
@override final  double price;
@override@JsonKey() final  double discountPercentage;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int stock;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? brand;
@override final  String? sku;
@override final  double? weight;
@override final  ProductDimensions? dimensions;
@override final  String? warrantyInformation;
@override final  String? shippingInformation;
@override final  String? availabilityStatus;
 final  List<ProductReview> _reviews;
@override@JsonKey() List<ProductReview> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override final  String? returnPolicy;
@override final  int? minimumOrderQuantity;
@override final  ProductMeta? meta;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  String thumbnail;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&const DeepCollectionEquality().equals(other.reviews, _reviews)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other.images, _images)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,title,description,category,price,discountPercentage,rating,stock,const DeepCollectionEquality().hash(_tags),brand,sku,weight,dimensions,warrantyInformation,shippingInformation,availabilityStatus,const DeepCollectionEquality().hash(_reviews),returnPolicy,minimumOrderQuantity,meta,const DeepCollectionEquality().hash(_images),thumbnail]);
}

@override
String toString() {
    return 'Product(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, tags: $tags, brand: $brand, sku: $sku, weight: $weight, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, images: $images, thumbnail: $thumbnail)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String category, double price, double discountPercentage, double rating, int stock, List<String> tags, String? brand, String? sku, double? weight, ProductDimensions? dimensions, String? warrantyInformation, String? shippingInformation, String? availabilityStatus, List<ProductReview> reviews, String? returnPolicy, int? minimumOrderQuantity, ProductMeta? meta, List<String> images, String thumbnail
});


@override $ProductDimensionsCopyWith<$Res>? get dimensions;@override $ProductMetaCopyWith<$Res>? get meta;

}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? rating = null,Object? stock = null,Object? tags = null,Object? brand = freezed,Object? sku = freezed,Object? weight = freezed,Object? dimensions = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? availabilityStatus = freezed,Object? reviews = null,Object? returnPolicy = freezed,Object? minimumOrderQuantity = freezed,Object? meta = freezed,Object? images = null,Object? thumbnail = null,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as ProductDimensions?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ProductReview>,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,minimumOrderQuantity: freezed == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ProductMeta?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDimensionsCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $ProductDimensionsCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
    return null;
  }

  return $ProductMetaCopyWith<$Res>(_self.meta!, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
