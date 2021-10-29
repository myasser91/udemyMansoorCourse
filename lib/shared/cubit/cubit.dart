// ignore_for_file: unused_import, non_constant_identifier_names, dead_code

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/otherModules/archived_tasks/new_archived_screen.dart';
import 'package:messenger/modules/otherModules/done_tasks/new_donetasks_screen.dart';
import 'package:messenger/modules/otherModules/new_tasks/new_tasks_screen.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Appcubit extends Cubit<Appstates> {
  Appcubit() : super(Appinitialstate());

  static Appcubit get(context) => BlocProvider.of(context);
  late Database database;

  List<Map> NewTasks = [];
  List<Map> DoneTasks = [];
  List<Map> ArchivedTasks = [];
  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    NewDoneTasksScreen(),
    NewArchivedScreen(),
  ];
  List<String> titles = [
    'Tasks',
    'Done',
    'archived',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() async {
    database = await openDatabase(
      'tod.db',
      version: 1,
      onCreate: (database, version) {
        print('data base created');
        database
            .execute(
                'CREATE TABLE taskss (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT )')
            .then((value) {
          print('thr table is created');
        }).catchError((error) {
          print('error when creating table is ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opended');
      },
    ).then((value) {
      return database = value;
      emit(Appcreatedatabasestate());
    });
  }

  insertdatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO taskss(title,time,date,status) VALUES ("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted sucsessfuly');
        emit(Appinsertdatabasestate());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserting new record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    NewTasks = [];

    DoneTasks = [];
    ArchivedTasks = [];
    emit(AppgetdatabaseLoadingstate());
    database.rawQuery('SELECT * FROM taskss').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          NewTasks.add(element);
        else if (element['status'] == 'done')
          DoneTasks.add(element);
        else
          ArchivedTasks.add(element);
      });

      emit(Appgetdatabasestate());
    });
  }

  bool isBottomsheetshown = false;
  IconData fabicon = Icons.edit;

  void Changebottomsheet({
    required bool isshow,
    required IconData icon,
  }) {
    isBottomsheetshown = isshow;
    fabicon = icon;
    emit(AppChangeBottomSheetBarState());
  }

  void updatedata({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE taskss SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(Appupdatedatabasestate());
    });
  }

  

  void deletdata({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM taskss WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(Appdeletedatabasestate());
    });
  }


  var isDark = false;
  void darkmodetoggle({bool? fromshared}) async {
    if (fromshared != null)
      isDark = fromshared;
    else
      isDark = !isDark;

    CashHelper.prefs!.setBool('isDark', isDark).then((value) {
      emit(Darkmodetogglestate());
      print(isDark);
    });
  }
}
