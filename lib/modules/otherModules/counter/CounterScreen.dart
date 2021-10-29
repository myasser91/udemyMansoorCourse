// ignore: unused_import
// ignore_for_file: must_be_immutable

// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/otherModules/counter/cubit/cubit.dart';
import 'package:messenger/modules/otherModules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Center(child: Text('Counter')),
              ),
              body: Container(
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text(
                        'MINUS',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text(
                        'PLUS',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
