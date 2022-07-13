import 'package:bloc/bloc.dart';
import 'package:bmi_ca/modules/archived_tasks/archived_tasks.dart';
import 'package:bmi_ca/modules/done_tasks/done_tasks.dart';
import 'package:bmi_ca/modules/new_tasks/new_tasks.dart';
import 'package:bmi_ca/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    archivedTasksScreen(),
  ];
  int currenindex = 0;
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  late Database database;
  List<Map> tasks = [];
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown=isShow;
    fabIcon=icon;
    emit(AppBottomSheetState());
  }

  void changeindex(int index) {
    currenindex = index;
    emit(AppChangeBottomNavBarState());
  }

  void CreateDatabase() {
    openDatabase('Todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('Table created');
      }).catchError((error) {
        print('Error when Creating table${error.toString()}');
      });
      print('Database created');
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        tasks = value;
        print(tasks);
        emit(AppGetDatabaseState());
      });
      print('Database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

   InsertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
 await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM Tasks');
  }
}
