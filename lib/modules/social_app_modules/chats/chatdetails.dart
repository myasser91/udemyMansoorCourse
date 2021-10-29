// ignore_for_file: unused_import, must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/messageModel.dart';

import 'package:messenger/models/socialModels/socialUserModel.dart';
import 'package:messenger/models/users/usermodel.dart';
import 'package:messenger/styles/iconBroken.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetailsScreen({
    required this.userModel,
  });
  var messagecontroller = TextEditingController();
  final ItemScrollController sc = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(recieverId: userModel.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
         
          if (state is SocialSendMessageSuccessState) {
            if (SocialCubit.get(context).messageimage != null) {
              SocialCubit.get(context).removemessageimage();
            }
            sc.scrollTo(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                index: SocialCubit.get(context).messages.length);
            messagecontroller.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left, color: Colors.black)),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userModel.image!),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    userModel.name!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
            body:
             BuildCondition(
              condition: State is! SocialgetMessageLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      FloatingActionButton(backgroundColor: Colors.blue,
                        child: Icon(IconBroken.Arrow___Down),
                        onPressed: (){sc.scrollTo(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                index: SocialCubit.get(context).messages.length);
                        
                      }),
                      Expanded(
                        child: ScrollablePositionedList.separated(
                          itemScrollController: sc,
                          itemBuilder: (context, index) {
                            if (SocialCubit.get(context).usermodel!.uId ==
                                SocialCubit.get(context)
                                    .messages[index]
                                    .senderId) {
                              return buildMymessage(
                                  SocialCubit.get(context).messages[index]);
                            } else {
                              return buildothermessage(
                                  SocialCubit.get(context).messages[index]);
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                          initialScrollIndex:
                              SocialCubit.get(context).messages.length,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (SocialCubit.get(context).messageimage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(SocialCubit.get(context)
                                          .messageimage!),
                                    ))),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                  iconSize: 16,
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .removemessageimage();
                                  },
                                  icon: Icon(IconBroken.Close_Square)),
                            ),
                          ],
                        ),
                      if (state is SocialCreateMessageImageLoadingState)
                        Center(child: LinearProgressIndicator()),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 385,
                                    controller: messagecontroller,
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Tybe your message here',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .getmessageimage();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(IconBroken.Image),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                      color: Colors.blue,
                                      onPressed: () {
                                        if (SocialCubit.get(context)
                                                .messageimage !=
                                            null) {
                                          SocialCubit.get(context)
                                              .uploadmessageImage(
                                                  receiverId: userModel.uId!,
                                                  datetime:
                                                      DateTime.now().toString(),
                                                  text: messagecontroller.text);
                                        } else {
                                          SocialCubit.get(context).sendmessage(
                                              receiverId: userModel.uId!,
                                              dateTime:
                                                  DateTime.now().toString(),
                                              text: messagecontroller.text);
                                        }
                                      },
                                      minWidth: 1,
                                      height: 50,
                                      child: Icon(
                                        IconBroken.Send,
                                        size: 16,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }

  Widget buildMymessage(MessageModel model) {
    if (model.messageimage == '')
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.5),
            decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            child: Text(
              model.text!,
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
      );
    else if (model.messageimage != '' && model.text != '')
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(30),
              topEnd: Radius.circular(30),
              topStart: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Image(
                  image: NetworkImage('${model.messageimage}'),
                  fit: BoxFit.cover,
                ),
                width: double.infinity,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model.text!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    else
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(20),
                topEnd: Radius.circular(20),
                topStart: Radius.circular(20),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${model.messageimage}')),
            )),
      );
  }

  Widget buildothermessage(MessageModel model) {
    if (model.messageimage == '')
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.5),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            child: Text(
              model.text!,
              style: TextStyle(color: Colors.black, fontSize: 14),
            )),
      );
    else if (model.messageimage != '' && model.text != '')
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(30),
              topEnd: Radius.circular(30),
              topStart: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image(
                  image: NetworkImage('${model.messageimage}'),
                  fit: BoxFit.cover,
                ),
                width: double.infinity,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model.text!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    else
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${model.messageimage}')),
            )),
      );
  }
}
