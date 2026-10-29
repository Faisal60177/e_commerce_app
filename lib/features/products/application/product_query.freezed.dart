// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductQuery {

 String? get category; String? get search; ProductSort get sort;
/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductQueryCopyWith<ProductQuery> get copyWith => _$ProductQueryCopyWithImpl<ProductQuery>(this as ProductQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProductQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductQuery&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.search, _this.search) || other.search == _this.search)&&(identical(other.sort, _this.sort) || other.sort == _this.sort));
}


@override
int get hashCode {
  final _this = this as ProductQuery;
  return Object.hash(runtimeType,_this.category,_this.search,_this.sort);
}

@override
String toString() {
  final _this = this as ProductQuery;
  return 'ProductQuery(category: ${_this.category}, search: ${_this.search}, sort: ${_this.sort})';
}


}

/// @nodoc
abstract mixin class $ProductQueryCopyWith<$Res>  {
  factory $ProductQueryCopyWith(ProductQuery value, $Res Function(ProductQuery) _then) = _$ProductQueryCopyWithImpl;
@useResult
$Res call({
 String? category, String? search, ProductSort sort
});




}
/// @nodoc
class _$ProductQueryCopyWithImpl<$Res>
    implements $ProductQueryCopyWith<$Res> {
  _$ProductQueryCopyWithImpl(this._self, this._then);

  final ProductQuery _self;
  final $Res Function(ProductQuery) _then;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? search = freezed,Object? sort = null,}) {
  return _then(ProductQuery(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductQuery].
extension ProductQueryPatterns on ProductQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductQuery value)  $default,){
final _that = this;
switch (_that) {
case _ProductQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductQuery value)?  $default,){
final _that = this;
switch (_that) {
case _ProductQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? category,  String? search,  ProductSort sort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductQuery() when $default != null:
return $default(_that.category,_that.search,_that.sort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? category,  String? search,  ProductSort sort)  $default,) {final _that = this;
switch (_that) {
case _ProductQuery():
return $default(_that.category,_that.search,_that.sort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? category,  String? search,  ProductSort sort)?  $default,) {final _that = this;
switch (_that) {
case _ProductQuery() when $default != null:
return $default(_that.category,_that.search,_that.sort);case _:
  return null;

}
}

}

/// @nodoc


class _ProductQuery implements ProductQuery {
  const _ProductQuery({this.category, this.search, this.sort = ProductSort.relevance});
  

@override final  String? category;
@override final  String? search;
@override@JsonKey() final  ProductSort sort;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductQueryCopyWith<_ProductQuery> get copyWith => __$ProductQueryCopyWithImpl<_ProductQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductQuery&&(identical(other.category, category) || other.category == category)&&(identical(other.search, search) || other.search == search)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode {
    return Object.hash(runtimeType,category,search,sort);
}

@override
String toString() {
    return 'ProductQuery(category: $category, search: $search, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$ProductQueryCopyWith<$Res> implements $ProductQueryCopyWith<$Res> {
  factory _$ProductQueryCopyWith(_ProductQuery value, $Res Function(_ProductQuery) _then) = __$ProductQueryCopyWithImpl;
@override @useResult
$Res call({
 String? category, String? search, ProductSort sort
});




}
/// @nodoc
class __$ProductQueryCopyWithImpl<$Res>
    implements _$ProductQueryCopyWith<$Res> {
  __$ProductQueryCopyWithImpl(this._self, this._then);

  final _ProductQuery _self;
  final $Res Function(_ProductQuery) _then;

/// Create a copy of ProductQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? search = freezed,Object? sort = null,}) {
  return _then(_ProductQuery(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,
  ));
}


}

// dart format on
