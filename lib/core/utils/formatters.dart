import 'package:intl/intl.dart';

abstract final class Formatters {

  static final _currency = NumberFormat.currency(locale: 'en_US', symbol: r'$');
  static final _date = DateFormat.yMMMd();
  static final _dateTime = DateFormat.yMMMd().add_jm();

  static String price(num value) => _currency.format(value);

  static String date(DateTime value) => _date.format(value.toLocal());

  static String dateTime(DateTime value) => _dateTime.format(value.toLocal());

  static String discount(double percentage) => '-${percentage.round()}%';

  static String rating(double value) => value.toStringAsFixed(1);
}