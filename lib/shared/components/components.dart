import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fue_got_talent/modules/news_app/web_view/web_view_screen.dart';
import 'package:fue_got_talent/shared/cubit/cubit.dart';

import '../../models/social_app/rating_model.dart';
import 'rating_star_widget.dart';


Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  double fontSize = 16.0,
  Color background = Colors.blue,
  required Function function,
  required String text,
  bool isUpperCase= true,
  double radius = 3.0,
  Color textColor = Colors.white,

}) =>
    Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
        ),
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            isUpperCase ? text.toUpperCase():text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
            ),
          ),
        ),
      ),
    );
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressedToggle,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged:onChange,

      //textInputAction: TextInputAction.search,
      style: const TextStyle(fontWeight: FontWeight.w500),
      validator: (value) => validate(value),
      decoration: InputDecoration(

        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressedToggle,
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0),
          ),
        ),
      ),
    );
PreferredSizeWidget defaultAppBar({
  String? title,
  required BuildContext context,
  List<Widget>? actions,
  required Widget leadingWidget,
}) => AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      // borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(25),
      //     bottomRight: Radius.circular(25),
      // ),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:Alignment.centerRight,
          colors: [Colors.deepPurpleAccent,
            Colors.deepPurple,
          ]),
    ),
  ),
  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  leading: leadingWidget,
  titleSpacing: 5.0,
  title: Text(
    title!,
  ),
  actions: actions,
);
// Widget buildTaskItem(Map model, context) => Dismissible(
//       key: Key(model['id'].toString()),
//       onDismissed: (direction) {
//         AppCubit.get(context).deleteData(
//           id: model['id'],
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40.0,
//               child: Text('${model['time']}'),
//             ),
//             const SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${model['title']}',
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${model['date']}',
//                     style: TextStyle(
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 20.0,
//             ),
//             IconButton(
//               onPressed: () {
//                 AppCubit.get(context)
//                     .updateData(status: 'Done', id: model['id']);
//               },
//               icon: const Icon(
//                 Icons.check_box,
//                 color: Colors.green,
//               ),
//             ),
//             IconButton(
//                 onPressed: () {
//                   AppCubit.get(context)
//                       .updateData(status: 'archive', id: model['id']);
//                 },
//                 icon: const Icon(Icons.archive),
//                 color: Colors.grey)
//           ],
//         ),
//       ),
//     );
// Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
//       condition: tasks.isNotEmpty,
//       builder: (BuildContext context) => ListView.separated(
//           itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//           separatorBuilder: (context, index) => myDivider(),
//           itemCount: tasks.length),
//       fallback: (BuildContext context) => Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
//           Icon(
//             Icons.menu,
//             size: 40.0,
//           ),
//           SizedBox(
//             height: 25.0,
//           ),
//           Text('No Tasks Yet , Please Add Some Tasks')
//         ]),
//       ),
//     );
Widget myDivider() => Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey[300],
    );
// Widget buildArticleItem(article, context) => InkWell(
//       onTap: () {
//         navigateTo(context, webViewScreen(article['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(children: [
//           Container(
//             height: 120.0,
//             width: 120.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover),
//             ),
//           ),
//           const SizedBox(
//             width: 20.0,
//           ),
//           Expanded(
//             child: SizedBox(
//               height: 120.0,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '${article['title']}',
//                       style: Theme.of(context).textTheme.bodyText1,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Text(
//                     '${article['publishedAt']}',
//                     style: const TextStyle(
//                       fontSize: 15.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
// Widget articlebuilder(list, context) => ConditionalBuilder(
//       condition: list.isNotEmpty,
//       builder: (context) => ListView.separated(
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: list.length,
//       ),
//       fallback: (context) => const Center(child: CircularProgressIndicator()),
//     );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
void showToast({required String msg,required ToastStates state})=>Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color =Colors.amber;
      break;
  }
  return color;
}
List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];
Widget ratingWidget({required RatingModel model})=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 15),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        model.username,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 200,
                // width: MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width / 4,
                child: FittedBox(
                  child: RatingStatWidget(
                    rating: model.rating.round(),
                  ),
                ),
              ),
            ),
            Text(
              keysOfRating[model.rating.round() - 1],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),

    ],
  ),
);

