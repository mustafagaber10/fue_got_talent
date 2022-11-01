//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fue_got_talent/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
// import 'package:fue_got_talent/modules/todo_app/done_tasks/done_tasks_screen.dart';
// import 'package:fue_got_talent/modules/todo_app/new_tasks/new_tasks_screen.dart';
// import 'package:fue_got_talent/shared/cubit/states.dart';
// import 'package:fue_got_talent/shared/network/local/cache_helper.dart';
// import 'package:sqflite/sqflite.dart';
// import '../network/local/cache_helper.dart';
// class AppCubit extends Cubit<AppStates>
// {
//   int currentIndex = 0;
//
//   List<Widget> screens = [
//     newTasksScreen(),
//     doneTasksScreen(),
//     archivedTasksScreen(),
//
//   ];
//   List<String> titleAppBar = [
//     'New Tasks',
//     'Done Tasks',
//     'Archived Tasks',
//
//   ];
//   AppCubit() : super(AppInitialState());
//
//   static AppCubit get(context)=>BlocProvider.of(context);
//   void changeIndex(index){
//     currentIndex=index;
//     emit(AppChangeBottomNavBarState());
//   }
//
//
//   late Database db;
//   List<Map> newTasks = [];
//   List<Map> doneTasks = [];
//   List<Map> archivedTasks = [];
//
//   void createDatabase()
//   {
//      openDatabase(
//         'todo1.db',
//         version: 1,
//         onCreate: (db, version) {
//           print("db created");
//           db.execute(
//               'CREATE TABLE Task(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
//               .then((value) {
//             print("table created");
//           }).catchError((error) {
//             print('error when creating table ${error.toString()}');
//           });
//         },
//         onOpen: (db) {
//           getDataFromDB(db);
//           print("db opened");
//         }
//
//     ).then((value)
//     {
//        db = value;
//       emit(AppCreateDatabaseState());
//     });
//   }
//
//   insertToDatabase(
//       {
//         required String title,
//         required String time,
//         required String date
//       }) async
//   {
//      await db.transaction((txn) async
//     {
//       txn.rawInsert(
//           'INSERT INTO Task(title,date,time,status)VALUES("$title","$date","$time","NEW")')
//           .then((value) {
//         print('$value inserted successfully');
//         emit(AppInsertDatabaseState());
//
//         getDataFromDB(db);
//       }).catchError((error) {
//         print('Error when Inserting New Record ${error.toString()}');
//       });
//       return null;
//     });
//   }
//
//   void getDataFromDB(db)
//   {
//     newTasks=[];
//     doneTasks=[];
//     archivedTasks=[];
//
//     emit(AppGetDatabaseLoadingState());
//     db.rawQuery('SELECT * FROM Task').then((value) {
//
//       value.forEach((element)
//       {
//         if(element['status']=='NEW') {
//           newTasks.add(element);
//         } else if(element['status']=='Done') {
//           doneTasks.add(element);
//         } else {
//           archivedTasks.add(element);
//         }
//
//       });
//       emit(AppGetDatabaseState());
//     });
//     //return tasks;
//   }
//   bool isBottomSheetShown = false;
//   IconData fabIcon = Icons.edit;
//   void changeBottomSheetState({
//     required bool isShow,
//     required IconData icon
//   })
//   {
//     isBottomSheetShown = isShow;
//     fabIcon = icon;
//     emit(AppChangeBottomSheetState());
//   }
//   void updateData(
//   {
//     required String status,
//     required int id
//
//   }) async
//   {
//     db.rawUpdate(
//         'UPDATE Task SET status = ? WHERE id = ?',
//         [status, id],
//     ).then((value){
//       getDataFromDB(db);
//       emit(AppUpdateDatabaseState());
//
//     });
//   }
//   void deleteData(
//       {
//         required int id
//       }) async
//   {
//     db.rawUpdate(
//       //DELETE FROM Test WHERE name = ?', ['another name']);
//       'DELETE FROM Task WHERE id = ?',
//       [id],
//     ).then((value){
//       getDataFromDB(db);
//       emit(AppDeleteDatabaseState());
//
//     });
//   }
//   bool isDark = false;
//   void changeAppMode({bool? fromShared})
//   {
//     if(fromShared != null)
//     {
//       isDark = fromShared;
//       emit(AppChangeModeStateapp());
//     }
//     else
//     {
//       isDark = !isDark;
//       CacheHelper.saveData(key:'isDark', value: isDark).then((value)
//       {
//         emit(AppChangeModeStateapp());
//       });
//     }
//
//
//   }
//
// }