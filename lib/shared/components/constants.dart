//https://newsapi.org/v2/everything?q=tesla&apiKey=807e5010516a48ff9810a1da5befb883
// import 'package:fue_got_talent/modules/shop_app/login/shop_login_screen.dart';
import 'package:fue_got_talent/shared/network/local/cache_helper.dart';
import 'components.dart';

// void signOut(context){
//   CacheHelper.removeData(key:'token').then((value)
//   {
//     if(value)
//     {
//       navigateAndFinish(context, ShopLoginScreen());
//     }
//   });
// }
void printFullText(String text){
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((element)=>print(element.group(0)));
}
String? token;
String? uid;
