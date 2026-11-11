enum OrderStatus {
  pending('Pending', 'Order placed'),
  confirmed('Confirmed', 'Order confirmed'),
  shipped('Shipped', 'Out for delivery'),
  delivered('Delivered', 'Delivered'),
  cancelled('Cancelled', 'Order cancelled');

  const OrderStatus(this.label, this.timelineTitle);

  final String label;
  final String timelineTitle;
  static const progress = [pending, confirmed, shipped, delivered];

  static OrderStatus? tryParse(String? name) {
    for(final status in values) {
      if(status.name == name) return status;
    }
    return null;
  }

  static OrderStatus fromName(String? name) => tryParse(name) ?? pending;
  bool get isFinal => this == delivered || this == cancelled;
  bool get canCancel => this == pending;

  OrderStatus? get next => switch(this) {
    OrderStatus.pending => OrderStatus.confirmed,
  OrderStatus.confirmed => OrderStatus.shipped,
  OrderStatus.shipped => OrderStatus.delivered,
  OrderStatus.delivered || OrderStatus.cancelled => null,
  };

}