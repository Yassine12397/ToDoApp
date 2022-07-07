import 'package:bmi_ca/shared/compenents/components.dart';
import 'package:bmi_ca/shared/compenents/constant.dart';
import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index)=>buildTaskItem(tasks[index]),
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
  }
}
