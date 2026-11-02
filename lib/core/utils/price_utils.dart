abstract final class PriceUtils {
  static double roundMoney(double value) => (value * 100).roundToDouble() / 100;

  static double applyDiscount(double price, double discountPercentage) {
    return roundMoney(price * (1 - discountPercentage / 100));
  }
}