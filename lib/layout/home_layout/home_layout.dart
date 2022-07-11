import 'package:bmi_ca/modules/archived_tasks/archived_tasks.dart';
import 'package:bmi_ca/modules/done_tasks/done_tasks.dart';
import 'package:bmi_ca/modules/new_tasks/new_tasks.dart';
import 'package:bmi_ca/shared/compenents/components.dart';
import 'package:bmi_ca/shared/compenents/constant.dart';
import 'package:bmi_ca/shared/cubit/cubit.dart';
import 'package:bmi_ca/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget
{

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  late Database database;
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

/*  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CreateDatabase();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context , AppStates state){},
        builder: (BuildContext context, AppStates state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currenindex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isBottomSheetShown) {
                  if (formkey.currentState!.validate()) {
                    InsertToDatabase(
                      date: dateController.text,
                      title: titleController.text,
                      time: timeController.text,
                    ).then((value) {
                      getDataFromDatabase(database).then((value) {
                        Navigator.of(context,rootNavigator: true).pop();
                        /* setState(() {
                        isBottomSheetShown = false;
                        fabIcon = Icons.edit;
                        tasks = value;
                        print(tasks);
                      });*/
                      });
                    });
                  }
                } else {
                  ScaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'title must not be empty';
                                }
                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                    .then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'time must not be empty';
                                }
                              },
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2023-05-03'))
                                    .then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Date must not be empty';
                                }
                              },
                              label: 'Task Date',
                              prefix: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value) {
                    Navigator.of(context,rootNavigator: true).pop();
                    isBottomSheetShown = false;
                    /* setState(() {
                    fabIcon = Icons.edit;
                  });*/
                  });
                  isBottomSheetShown = true;
                  /*  setState(() {
                  fabIcon = Icons.add;
                });*/
                }
              },
              child: Icon(
                fabIcon,
              ),
            )
            ,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currenindex,
              onTap: (index) {
                cubit.changeindex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived'),
              ],
            ),
            body: ConditionalBuilder(
              condition: true,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) => cubit.screens[cubit.currenindex],
            ),
            //tasks.length==0 ?Center(child: CircularProgressIndicator()):screens[currenindex],
          );
        },
      ),
    );
  }

  void CreateDatabase() async {
    database = await openDatabase('Todo.db', version: 1,
        onCreate: (database, version) {
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
          /*  setState(() {
              tasks = value;
              print(tasks);
            });*/
          });
          print('Database opened');
        });
  }

  Future InsertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM Tasks');
  }
}


