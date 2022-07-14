import 'package:bmi_ca/shared/compenents/components.dart';
import 'package:bmi_ca/shared/cubit/cubit.dart';
import 'package:bmi_ca/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class archivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context , state)
      {
        var tasks=AppCubit.get(context).Archivetasks;
        return ListView.separated(
            itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20,
              ),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],

              ),
            ),
            itemCount: tasks.length);
      },
    );
  }
}
