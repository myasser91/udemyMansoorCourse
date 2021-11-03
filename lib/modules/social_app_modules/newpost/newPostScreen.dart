// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/postModel%20.dart';
import 'package:messenger/styles/iconBroken.dart';

class NewPostScreen extends StatelessWidget {
  var datetimecontroller = TextEditingController();
  var textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

        if(state is SocialCreatePostSuccessState)
        {SocialCubit.get(context).getposts();
        SocialCubit.get(context).getpostsnumber();

        SocialCubit.get(context).removepostimage();
          Navigator.pop(context);
         // SocialCubit.get(context).removepostimage();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left,
                  color: Colors.black,
                )),
            title: Text(
              'Create Post',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 30, color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();

                    print(now.toString());
                    if (SocialCubit.get(context).postimage == null) {
                      SocialCubit.get(context).createPost(
                          datetime: now.toString(), text: textcontroller.text);
                    } else {
                      SocialCubit.get(context).uploadpostImage(
                        dateTime: now.toString(),
                        text: textcontroller.text,
                      );
                    }
                  },
                  child: Text('Post',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                            fontSize: 20,
                          ))),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          cubit.usermodel!.image!),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cubit.usermodel!.name!,
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                            ],
                          ),
                          Text(
                            'public',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.3),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    
                  keyboardType: TextInputType.multiline,
                  maxLines:null,
                   controller: textcontroller,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind ...  ',
                        border: InputBorder.none),
                  ),
                ),
                if (SocialCubit.get(context).postimage != null)
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
                                image: FileImage(
                                    SocialCubit.get(context).postimage!),
                              ))),
                      CircleAvatar(radius: 20,backgroundColor: Colors.blue,
                        child: IconButton(iconSize: 16,
                            onPressed: () {

                              SocialCubit.get(context).removepostimage();
                            },
                            icon: Icon(IconBroken.Close_Square)),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getpostimage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: Text('# tages'))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
