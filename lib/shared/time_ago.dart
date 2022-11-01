import 'package:intl/intl.dart';

class TimeAgo{
    static String timeAgoSinceDate(DateTime date)
    {
      final date2 = DateTime.now();
      final diff = date2.difference(date);
      if (diff.inDays>8)
      {
        return   DateFormat.yMMMMd('en_US').add_jm().format(date);
      } else if((diff.inDays/7).floor()>=1) {
        return "1w";

      }
      else if(diff.inDays > 2) {
        return "${diff.inDays}d";

      }
      else if(diff.inDays >= 1) {
        return "1d";

      }
      else if(diff.inHours >= 2) {
        return "${diff.inHours}h";
      }
      else if(diff.inHours >= 1) {
        return "1h";
      }
      else if(diff.inMinutes >= 2) {
        return "${diff.inMinutes}m";
      }
      else if(diff.inMinutes >= 1) {
        return "1m";
      }
      else if(diff.inSeconds >= 60) {
        return "${diff.inSeconds}s";
      }else{
        return 'just now';
      }
    }
    // static String timeAgoSinceDate(int time)
    // {
    //   DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
    //   final date2 = DateTime.now();
    //   final diff = date2.difference(date);
    //   if (diff.inDays>8)
    //   {
    //     return DateFormat("dd-MM-yyyy HH:mm:ss").format(date);
    //   } else if((diff.inDays/7).floor()>=1) {
    //     return "1w";
    //
    //   }
    //   else if(diff.inDays > 2) {
    //     return "${diff.inDays}d";
    //
    //   }
    //   else if(diff.inDays >= 1) {
    //     return "1d";
    //
    //   }
    //   else if(diff.inHours >= 2) {
    //     return "${diff.inHours}h";
    //   }
    //   else if(diff.inHours >= 1) {
    //     return "1h";
    //   }
    //   else if(diff.inMinutes >= 2) {
    //     return "${diff.inMinutes}m";
    //   }
    //   else if(diff.inMinutes >= 1) {
    //     return "1m";
    //   }
    //   else if(diff.inSeconds >= 60) {
    //     return "${diff.inSeconds}s";
    //   }else{
    //     return 'just now';
    //   }
    // }
}
