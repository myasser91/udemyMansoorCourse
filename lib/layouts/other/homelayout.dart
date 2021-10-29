// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:messenger/modules/otherModules/archived_tasks/new_archived_screen.dart';
// import 'package:messenger/modules/otherModules/done_tasks/new_donetasks_screen.dart';
// import 'package:messenger/modules/otherModules/new_tasks/new_tasks_screen.dart';
// import 'package:messenger/shared/components/components.dart';
// import 'package:messenger/shared/components/constants.dart';
// import 'package:messenger/shared/cubit/cubit.dart';
// import 'package:messenger/shared/cubit/states.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:intl/intl.dart';

// class HomeLayout extends StatelessWidget {
//   var titlecontroller = TextEditingController();
//   var timecontroller = TextEditingController();
//   var scaffoldkey = GlobalKey<ScaffoldState>();
//   var datecontroller = TextEditingController();
//   var formkey = GlobalKey<FormState>();

  

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => Appcubit()..createDatabase(),
//       child: BlocConsumer<Appcubit, Appstates>(
//           listener: (context, state) {
//             if(state is Appinsertdatabasestate)
//             Navigator.pop(context);
//           },
//           builder: (context, state) {
//             return Scaffold(
//               key: scaffoldkey,
//               appBar: AppBar(
//                 title: Text(Appcubit.get(context)
//                     .titles[Appcubit.get(context).currentIndex]),
//               ),
//               body: state is AppgetdatabaseLoadingstate
//                   ? Center(child: CircularProgressIndicator())
//                   : Appcubit.get(context)
//                       .screens[Appcubit.get(context).currentIndex],
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () 
//                 {
//                   if (Appcubit.get(context).isBottomsheetshown) {
//                     if (formkey.currentState!.validate()) {
                     
//                      Appcubit.get(context).insertdatabase(title: titlecontroller.text, time: timecontroller.text ,date: datecontroller.text);
//                       // insertdatabase(
//                       //   title: titlecontroller.text,
//                       //   date: datecontroller.text,
//                       //   time: timecontroller.text,
//                       // ).then((value) {
//                       //   getDataFromDatabase(database).then((value) {
//                       //     Navigator.pop(context);

//                       //     // setState(()
//                       //     // {
//                       //     //   isBottomsheetshown = false;
//                       //     //   fabicon = Icons.edit;
//                       //     //   tasks = value;
//                       //     //   print(tasks);
//                       //     // });
//                       //   });
//                       // });
//                     }
//                   } else {
//                     scaffoldkey.currentState!
//                         .showBottomSheet((context) => Container(
//                               width: double.infinity,

//                               // color: Colors.grey[300],
//                               padding: EdgeInsets.all(20.0),
//                               child: Form(
//                                 key: formkey,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Container(
//                                         color: Colors.grey[300],
//                                         child: defaultFormField(
//                                             controller: titlecontroller,
//                                            // onTap: () {},
//                                             labelText: 'Task title',
//                                             prefixIcon: Icons.title,
//                                             validate: (String? value) {
//                                               if (value!.isEmpty) {
//                                                 return 'must enterd';
//                                               }
//                                             }),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                         width: double.infinity,
//                                       ),
//                                       Container(
//                                         color: Colors.grey[300],
//                                         child: defaultFormField(
//                                             controller: timecontroller,
//                                             onTap: () {
//                                               showTimePicker(
//                                                 context: context,
//                                                 initialTime: TimeOfDay.now(),
//                                               ).then((value) {
//                                                 timecontroller.text = value!
//                                                     .format(context)
//                                                     .toString();
//                                                 print(value.format(context));
//                                               });
//                                             },
//                                             validate: (String? value) {
//                                               if (value!.isEmpty) {
//                                                 return 'must not be empty';
//                                               }
//                                             },
//                                             labelText: 'time',
//                                             type: TextInputType.datetime,
//                                             prefixIcon: Icons.timelapse_sharp),
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Container(
//                                         color: Colors.grey[300],
//                                         child: defaultFormField(
//                                             controller: datecontroller,
//                                             onTap: () {
//                                               showDatePicker(
//                                                 context: context,
//                                                 initialDate: DateTime.now(),
//                                                 firstDate: DateTime.now(),
//                                                 lastDate: DateTime.parse(
//                                                     '2022-05-03'),
//                                               ).then((value) {
//                                                 datecontroller.text =
//                                                     DateFormat.yMMMd()
//                                                         .format(value!);
//                                                 print(DateFormat.yMMMd()
//                                                     .format(value));
//                                               });
//                                             },
//                                             validate: (String? value) {
//                                               if (value!.isEmpty) {
//                                                 return 'must not be empty';
//                                               }
//                                             },
//                                             labelText: 'date',
//                                             type: TextInputType.datetime,
//                                             prefixIcon:
//                                                 Icons.calendar_today_rounded),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ))
//                         .closed
//                         .then((value) {
//                      Appcubit.get(context).Changebottomsheet(isshow: false, icon: Icons.edit);
                      
//                     });

//                     Appcubit.get(context).Changebottomsheet(isshow: true, icon: Icons.add);
//                   }
//                 },
//                 child: Icon(Appcubit.get(context).fabicon),
//               ),
//               bottomNavigationBar: BottomNavigationBar(
//                 showSelectedLabels: true,
//                 currentIndex: Appcubit.get(context).currentIndex,
//                 onTap: (index) {
//                   Appcubit.get(context).changeIndex(index);
//                 },
//                 type: BottomNavigationBarType.fixed,
//                 items: [
//                   BottomNavigationBarItem(
//                     icon: Image(image: AssetImage('images/48.png'),
//                     height: 30,
//                     width: 20,),
//                     label: 'Tasks',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.check_circle_outline),
//                     label: 'done',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.archive_outlined),
//                     label: 'archived',
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
