import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (Appcubit.get(context).NewTasks.length == 0) {
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image(
                    image: AssetImage('images/cherry-list-is-empty.png'),
                    height: 200.0,
                    width: 200.0,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'No tasks please add some tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Container(
                  
                  
                  child: Image(image:AssetImage('images/48.png') ,
                  fit: BoxFit.fitWidth,),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        Buildtaskitem(Appcubit.get(context).NewTasks[index], context),
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    itemCount: Appcubit.get(context).NewTasks.length,
                  ),
                ),
              ],
            );
          }
        });
  }
}
