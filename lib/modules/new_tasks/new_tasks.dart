import 'package:bmi_ca/shared/compenents/components.dart';
import 'package:bmi_ca/shared/compenents/constant.dart';
import 'package:bmi_ca/shared/cubit/cubit.dart';
import 'package:bmi_ca/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context , state)
      {
        var tasks=AppCubit.get(context).Newtasks;
        return TasksBuilder(tasks: tasks);
      },
    );
  }
}
