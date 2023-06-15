import 'package:intl/intl.dart';

String getDateFormated(String input) {
  DateTime date = DateTime.parse(input);

  return DateFormat.yMMMEd().add_jm().format(date);
}
