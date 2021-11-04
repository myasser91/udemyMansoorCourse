// ignore_for_file: unused_import

import 'dart:async';

import 'package:buildcondition/buildcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/modules/social_app_modules/newpost/newPostScreen.dart';
import 'package:messenger/modules/social_app_modules/social_login_screen/social_login_screen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:messenger/styles/iconBroken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          NavigateTo(context, NewPostScreen());
        }

        if (state is SocialGetUserSuccessState) {
          SocialCubit.get(context).getUsers();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              BlocConsumer<Appcubit, Appstates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        Appcubit.get(context).darkmodetoggle();
                        SocialCubit.get(context).sumstories();
                      },
                      icon: Icon(Icons.dark_mode_outlined));
                },
              ),
              IconButton(
                  color: Colors.grey,
                  onPressed: () {
                    print(SocialCubit.get(context).storiesperperson.length);
                    print(SocialCubit.get(context).stories.length);
                    print(SocialCubit.get(context).stories);
                    print('the edited length ${SocialCubit.get(context).sotriesedited.length}');
                    
                  },
                  icon: Icon(IconBroken.Notification)),
              IconButton(
                  color: Colors.grey,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();

                    SocialCubit.get(context).users = [];

                    SocialCubit.get(context).messages = [];
                    SocialCubit.get(context).firsttime = true;
                    SocialCubit.get(context).firsttimechats = true;
                    print(SocialCubit.get(context).users.length);

                    profileImage = null;
                    coverimage = null;
                    uId = null;
                    CashHelper.removedata(key: 'uId');
                    NavigateToreplace(context, SocialLoginScreen());
                    SocialCubit.get(context).currentIndex = 0;
                    print(' the uid in constants is = $uId');
                    print(
                        ' the uid in cash helper =  ${CashHelper.getdata(key: 'uId')}');
                  },
                  icon: Icon(IconBroken.Logout)),
            ],
          ),
          body: Stack(
            children: [
              cubit.screens[cubit.currentIndex],
              // if (!FirebaseAuth.instance.currentUser!.emailVerified)
              //   emailverification(),
              if (state is SocialGetPostCommentsLoadingState)
                LinearProgressIndicator(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  label: 'home', icon: Icon(IconBroken.Home)),
              BottomNavigationBarItem(
                  label: 'chat', icon: Icon(IconBroken.Chat)),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Add_User,
                  ),
                  label: 'post'),
              BottomNavigationBarItem(
                  label: 'users', icon: Icon(IconBroken.User)),
              BottomNavigationBarItem(
                  label: 'settings', icon: Icon(IconBroken.Setting)),
            ],
          ),
        );
      },
    );
  }
}



//  BuildCondition(
//             condition: cubit.model != null,
//             fallback: (context) => Center(
//                 child: CircularProgressIndicator(
//               color: Colors.blueAccent,
//             )),
//             builder: (context) {
//               return Column(
//                 children: [
//                   if (!FirebaseAuth.instance.currentUser!.emailVerified)
//                     Container(
//                       height: 50,
//                       color: Colors.amber.withOpacity(.6),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Icon(Icons.info_outline),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                               child: Text(
//                             '  please verify your email',
//                             style: TextStyle(color: Colors.black),
//                           )),
//                           defaultButtom(
//                             width: 80,
//                             bottomcolor: Colors.transparent,
//                             onpress: () {
//                               FirebaseAuth.instance.currentUser!
//                                   .sendEmailVerification()
//                                   .then((value) {
//                                 showToast(
//                                     context: context,
//                                     t: 'Check your Email',
//                                     state: ToastStates.SUCCESS);
//                               }).catchError((error) {
//                                 print(error.toString());
//                               });
//                             },
//                             text: 'send',
//                           ),
//                         ],
//                       ),
//                     )
              
               
               
//                 ],
//               );
//             },
//           ),
       