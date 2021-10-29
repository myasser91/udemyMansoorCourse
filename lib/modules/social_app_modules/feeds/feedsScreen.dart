// ignore_for_file: unused_import, must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/commentModel.dart';
import 'package:messenger/models/socialModels/postModel%20.dart';
import 'package:messenger/models/users/usermodel.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/styles/iconBroken.dart';
import 'package:path/path.dart';

class FeedsScreen extends StatelessWidget {

  var commentcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

        if (state is SocialCommentonPostsuccessState)
        {
          commentcontroller.clear();
        }
        if (state is SocialGetPostCommentsSuccessState) {
          showModalBottomSheet(
              backgroundColor: Colors.grey[300],
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                    itemBuilder: (context, index) => buildCommentItem(
                        SocialCubit.get(context).postComments[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                    itemCount: SocialCubit.get(context).postComments.length),
              ));
        }
      },
      builder: (context, state) {
      
        return BuildCondition(
          condition:
          SocialCubit.get(context).posts.length > 0 &&
         // && SocialCubit.get(context).likes.length > 0  && SocialCubit.get(context).comments.length > 0 &&
              SocialCubit.get(context).usermodel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 200,
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/terrifed-young-woman-warns-you-about-something-indicates-aside-with-fore-finger-keeps-mouth-widely-opened-stares-with-bugged-eyes-isolated-pink-wall-advertising-concept_273609-2957.jpg')),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  itemCount: SocialCubit.get(context).posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialCubit.get(context).posts[index],
                      context,
                      index,
                      commentcontroller),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(
      PostModel model, context, index, TextEditingController t) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${model.image}'),
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
                              '${model.name}',
                              style: TextStyle(height: 1.3),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 14.4,
                            )
                          ],
                        ),
                        Text(
                          '${model.datetime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              Container(
                width: double.infinity,
                child: Text('${model.text}'),
              ),
              if (model.postimage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${model.postimage}')),
                      )),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.grey[300],
                                size: 20,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SocialCubit.get(context).getPostComments(
                              SocialCubit.get(context).postsId[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Icon(
                              //   Icons.chat,
                              //   color: Colors.grey[300],
                              //   size: 20,
                              // ),
                              Text(
                                'Comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(
                                    '${SocialCubit.get(context).usermodel!.image!}'),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: t,
                                  decoration: InputDecoration(
                                      hintText: 'comment ..  ',
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              var now = DateTime.now();
                              SocialCubit.get(context).comment(
                                userImage:
                                    SocialCubit.get(context).usermodel!.image!,
                                postid: SocialCubit.get(context).postsId[index],
                                dateTime: now.toString(),
                                userId:
                                    SocialCubit.get(context).usermodel!.uId!,
                                text: t.text,
                              );
                            },
                            icon: Icon(IconBroken.Send)),
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).likePost(
                                SocialCubit.get(context).postsId[index]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.grey[300],
                                size: 20,
                              ),
                              Text(
                                'like',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCommentItem(CommentModel model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(model.userImage!),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 2.5),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.text!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
