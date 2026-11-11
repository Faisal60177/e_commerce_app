// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Order {

 String get id; OrderStatus get status; List<OrderItem> get items; Address get address; PaymentMethod get paymentMethod; double get listSubtotal; double get itemsTotal; double get shipping; double get total; DateTime get createdAt; Map<OrderStatus, DateTime> get timeline; String get note;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Order;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod)&&(identical(other.listSubtotal, _this.listSubtotal) || other.listSubtotal == _this.listSubtotal)&&(identical(other.itemsTotal, _this.itemsTotal) || other.itemsTotal == _this.itemsTotal)&&(identical(other.shipping, _this.shipping) || other.shipping == _this.shipping)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.timeline, _this.timeline)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as Order;
  return Object.hash(runtimeType,_this.id,_this.status,const DeepCollectionEquality().hash(_this.items),_this.address,_this.paymentMethod,_this.listSubtotal,_this.itemsTotal,_this.shipping,_this.total,_this.createdAt,const DeepCollectionEquality().hash(_this.timeline),_this.note);
}

@override
String toString() {
  final _this = this as Order;
  return 'Order(id: ${_this.id}, status: ${_this.status}, items: ${_this.items}, address: ${_this.address}, paymentMethod: ${_this.paymentMethod}, listSubtotal: ${_this.listSubtotal}, itemsTotal: ${_this.itemsTotal}, shipping: ${_this.shipping}, total: ${_this.total}, createdAt: ${_this.createdAt}, timeline: ${_this.timeline}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String id, OrderStatus status, List<OrderItem> items, Address address, PaymentMethod paymentMethod, double listSubtotal, double itemsTotal, double shipping, double total, DateTime createdAt, Map<OrderStatus, DateTime> timeline, String note
});


$AddressCopyWith<$Res> get address;

}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? items = null,Object? address = null,Object? paymentMethod = null,Object? listSubtotal = null,Object? itemsTotal = null,Object? shipping = null,Object? total = null,Object? createdAt = null,Object? timeline = null,Object? note = null,}) {
  return _then(Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,listSubtotal: null == listSubtotal ? _self.listSubtotal : listSubtotal // ignore: cast_nullable_to_non_nullable
as double,itemsTotal: null == itemsTotal ? _self.itemsTotal : itemsTotal // ignore: cast_nullable_to_non_nullable
as double,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as Map<OrderStatus, DateTime>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  OrderStatus status,  List<OrderItem> items,  Address address,  PaymentMethod paymentMethod,  double listSubtotal,  double itemsTotal,  double shipping,  double total,  DateTime createdAt,  Map<OrderStatus, DateTime> timeline,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.status,_that.items,_that.address,_that.paymentMethod,_that.listSubtotal,_that.itemsTotal,_that.shipping,_that.total,_that.createdAt,_that.timeline,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  OrderStatus status,  List<OrderItem> items,  Address address,  PaymentMethod paymentMethod,  double listSubtotal,  double itemsTotal,  double shipping,  double total,  DateTime createdAt,  Map<OrderStatus, DateTime> timeline,  String note)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.status,_that.items,_that.address,_that.paymentMethod,_that.listSubtotal,_that.itemsTotal,_that.shipping,_that.total,_that.createdAt,_that.timeline,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  OrderStatus status,  List<OrderItem> items,  Address address,  PaymentMethod paymentMethod,  double listSubtotal,  double itemsTotal,  double shipping,  double total,  DateTime createdAt,  Map<OrderStatus, DateTime> timeline,  String note)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.status,_that.items,_that.address,_that.paymentMethod,_that.listSubtotal,_that.itemsTotal,_that.shipping,_that.total,_that.createdAt,_that.timeline,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Order extends Order {
  const _Order({required this.id, required this.status, required  List<OrderItem> items, required this.address, required this.paymentMethod, required this.listSubtotal, required this.itemsTotal, required this.shipping, required this.total, required this.createdAt,  Map<OrderStatus, DateTime> timeline = const {}, this.note = ''}): _items = items,_timeline = timeline,super._();
  

@override final  String id;
@override final  OrderStatus status;
 final  List<OrderItem> _items;
@override List<OrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  Address address;
@override final  PaymentMethod paymentMethod;
@override final  double listSubtotal;
@override final  double itemsTotal;
@override final  double shipping;
@override final  double total;
@override final  DateTime createdAt;
 final  Map<OrderStatus, DateTime> _timeline;
@override@JsonKey() Map<OrderStatus, DateTime> get timeline {
  if (_timeline is EqualUnmodifiableMapView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_timeline);
}

@override@JsonKey() final  String note;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.address, address) || other.address == address)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.listSubtotal, listSubtotal) || other.listSubtotal == listSubtotal)&&(identical(other.itemsTotal, itemsTotal) || other.itemsTotal == itemsTotal)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.total, total) || other.total == total)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.timeline, _timeline)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,const DeepCollectionEquality().hash(_items),address,paymentMethod,listSubtotal,itemsTotal,shipping,total,createdAt,const DeepCollectionEquality().hash(_timeline),note);
}

@override
String toString() {
    return 'Order(id: $id, status: $status, items: $items, address: $address, paymentMethod: $paymentMethod, listSubtotal: $listSubtotal, itemsTotal: $itemsTotal, shipping: $shipping, total: $total, createdAt: $createdAt, timeline: $timeline, note: $note)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String id, OrderStatus status, List<OrderItem> items, Address address, PaymentMethod paymentMethod, double listSubtotal, double itemsTotal, double shipping, double total, DateTime createdAt, Map<OrderStatus, DateTime> timeline, String note
});


@override $AddressCopyWith<$Res> get address;

}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? items = null,Object? address = null,Object? paymentMethod = null,Object? listSubtotal = null,Object? itemsTotal = null,Object? shipping = null,Object? total = null,Object? createdAt = null,Object? timeline = null,Object? note = null,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,listSubtotal: null == listSubtotal ? _self.listSubtotal : listSubtotal // ignore: cast_nullable_to_non_nullable
as double,itemsTotal: null == itemsTotal ? _self.itemsTotal : itemsTotal // ignore: cast_nullable_to_non_nullable
as double,shipping: null == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as Map<OrderStatus, DateTime>,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
