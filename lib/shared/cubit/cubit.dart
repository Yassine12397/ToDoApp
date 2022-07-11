import 'package:bloc/bloc.dart';
import 'package:bmi_ca/modules/archived_tasks/archived_tasks.dart';
import 'package:bmi_ca/modules/done_tasks/done_tasks.dart';
import 'package:bmi_ca/modules/new_tasks/new_tasks.dart';
import 'package:bmi_ca/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
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
void changeindex (int index)
{
  currenindex=index;
  emit(AppChangeBottomNavBarState());
}
}