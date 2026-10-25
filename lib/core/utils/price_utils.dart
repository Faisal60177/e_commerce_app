abstract final class PriceUtils {
  static double applyDiscount(double price, double discountPercentage){
    final discounted = price * (1 - discountPercentage / 100);
    return (discounted * 100).roundToDouble() / 100;
  }

}