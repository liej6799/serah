import 'package:intl/intl.dart';

class Common {
  final dateFormatString = 'dd/MM/yyyy hh:mm';

  String convertTimeStampToDateTime(int timeStamp) {
    return DateFormat(dateFormatString)
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000))
        .toString();
  }
}
