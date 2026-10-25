// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_dimensions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDimensions {

 double get width; double get height; double get depth;
/// Create a copy of ProductDimensions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDimensionsCopyWith<ProductDimensions> get copyWith => _$ProductDimensionsCopyWithImpl<ProductDimensions>(this as ProductDimensions, _$identity);

  /// Serializes this ProductDimensions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProductDimensions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDimensions&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.depth, _this.depth) || other.depth == _this.depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProductDimensions;
  return Object.hash(runtimeType,_this.width,_this.height,_this.depth);
}

@override
String toString() {
  final _this = this as ProductDimensions;
  return 'ProductDimensions(width: ${_this.width}, height: ${_this.height}, depth: ${_this.depth})';
}


}

/// @nodoc
abstract mixin class $ProductDimensionsCopyWith<$Res>  {
  factory $ProductDimensionsCopyWith(ProductDimensions value, $Res Function(ProductDimensions) _then) = _$ProductDimensionsCopyWithImpl;
@useResult
$Res call({
 double width, double height, double depth
});




}
/// @nodoc
class _$ProductDimensionsCopyWithImpl<$Res>
    implements $ProductDimensionsCopyWith<$Res> {
  _$ProductDimensionsCopyWithImpl(this._self, this._then);

  final ProductDimensions _self;
  final $Res Function(ProductDimensions) _then;

/// Create a copy of ProductDimensions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,Object? depth = null,}) {
  return _then(ProductDimensions(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDimensions].
extension ProductDimensionsPatterns on ProductDimensions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDimensions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDimensions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDimensions value)  $default,){
final _that = this;
switch (_that) {
case _ProductDimensions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDimensions value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDimensions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double width,  double height,  double depth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDimensions() when $default != null:
return $default(_that.width,_that.height,_that.depth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double width,  double height,  double depth)  $default,) {final _that = this;
switch (_that) {
case _ProductDimensions():
return $default(_that.width,_that.height,_that.depth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double width,  double height,  double depth)?  $default,) {final _that = this;
switch (_that) {
case _ProductDimensions() when $default != null:
return $default(_that.width,_that.height,_that.depth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDimensions implements ProductDimensions {
  const _ProductDimensions({required this.width, required this.height, required this.depth});
  factory _ProductDimensions.fromJson(Map<String, dynamic> json) => _$ProductDimensionsFromJson(json);

@override final  double width;
@override final  double height;
@override final  double depth;

/// Create a copy of ProductDimensions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDimensionsCopyWith<_ProductDimensions> get copyWith => __$ProductDimensionsCopyWithImpl<_ProductDimensions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDimensionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDimensions&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,width,height,depth);
}

@override
String toString() {
    return 'ProductDimensions(width: $width, height: $height, depth: $depth)';
}


}

/// @nodoc
abstract mixin class _$ProductDimensionsCopyWith<$Res> implements $ProductDimensionsCopyWith<$Res> {
  factory _$ProductDimensionsCopyWith(_ProductDimensions value, $Res Function(_ProductDimensions) _then) = __$ProductDimensionsCopyWithImpl;
@override @useResult
$Res call({
 double width, double height, double depth
});




}
/// @nodoc
class __$ProductDimensionsCopyWithImpl<$Res>
    implements _$ProductDimensionsCopyWith<$Res> {
  __$ProductDimensionsCopyWithImpl(this._self, this._then);

  final _ProductDimensions _self;
  final $Res Function(_ProductDimensions) _then;

/// Create a copy of ProductDimensions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? depth = null,}) {
  return _then(_ProductDimensions(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
