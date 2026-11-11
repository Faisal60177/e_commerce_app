enum PaymentMethod {
  cashOnDelivery('Cash on Delivery', 'Pay with cash when your order arrives');

  const PaymentMethod(this.title, this.description);

  final String title;
  final String description;

  static PaymentMethod fromName(String? name) {
    return values.firstWhere(
        (method) => method.name == name,
      orElse: () => cashOnDelivery,
    );
  }
}