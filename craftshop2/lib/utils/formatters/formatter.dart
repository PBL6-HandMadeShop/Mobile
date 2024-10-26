import 'package:intl/intl.dart';

class CSFormatter{
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }
  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(amount);
  }
  static String formatPhoneNumber(String phoneNumber){
    // VN phone number format: 0123456789 or 0123 456 789
    if(phoneNumber.length  == 10){
      return '${phoneNumber.substring(0,4)} ${phoneNumber.substring(4,6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11){
      return '${phoneNumber.substring(0,4)} ${phoneNumber.substring(4,7)} ${phoneNumber.substring(7)}';
    }

    return phoneNumber;
  }
  static String internationalFormatPhoneNumber(String phoneNumber){
    // VN phone number format: 0123456789 or 0123 456 789
  var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D+'), '');

  String countryCode = '+${digitsOnly.substring(0, 2)}';
  digitsOnly = digitsOnly.substring(2);

  final formattedPhoneNumber = StringBuffer();
  formattedPhoneNumber.write('($countryCode)');

  int i = 0;
  while (i < digitsOnly.length) {
    int groupLenght = 2;
    if(i == 0 && countryCode == '+1'){
      groupLenght = 3;
    }
    int end = i + groupLenght;
    formattedPhoneNumber.write(digitsOnly.substring(i, end));

    if(end < digitsOnly.length){
      formattedPhoneNumber.write(' ');
    }
    i = end;
  }
    return phoneNumber;
  }
}