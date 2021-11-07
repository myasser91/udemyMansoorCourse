// ignore_for_file: unused_import, must_be_immutable
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/commentModel.dart';
import 'package:messenger/models/socialModels/postModel%20.dart';
import 'package:messenger/models/socialModels/postfeedsusermodel.dart';
import 'package:messenger/models/socialModels/storyModel.dart';
import 'package:messenger/models/users/usermodel.dart';
import 'package:messenger/modules/social_app_modules/addnewStory.dart';
import 'package:messenger/modules/social_app_modules/settings/settingsScreen.dart';
import 'package:messenger/modules/social_app_modules/story.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:messenger/styles/iconBroken.dart';
import 'package:path/path.dart';

class FeedsScreen extends StatelessWidget {
  
  var indicatorcontroller = IndicatorController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialStoryImagePicckedSuccessState) {
          NavigateTo(context, AddStory());
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
                            SocialCubit.get(context).postComments[index],context),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1,
                            ),
                        itemCount:
                            SocialCubit.get(context).postComments.length),
                  ));
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: SocialCubit.get(context).usermodel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => RefreshIndicator(
            onRefresh: () => SocialCubit.get(context).getposts(),
            displacement: 20,
            edgeOffset: 20,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          SocialCubit.get(context).getStoryImage();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        SocialCubit.get(context)
                                            .usermodel!
                                            .image!),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, 10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue[800],
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      radius: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => buildstoryitem(
                                context,
                                SocialCubit.get(context).sotriesedited[index],
                              ),
                              itemCount:
                                  SocialCubit.get(context).sotriesedited.length,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                    itemCount: SocialCubit.get(context).posts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).postownerdetails,
                        SocialCubit.get(context).mylikedpostslist,
                        SocialCubit.get(context).postsLikesbymap,
                        SocialCubit.get(context).postsCommentsbymap,
                        SocialCubit.get(context).postsId[index],
                        SocialCubit.get(context).posts[index],
                        context,
                        index,
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(
      Map<String, PostfeedUserData> postownerdetails,
      List<String> mylikedpostslist,
      Map<String, int> likes,
      Map<String, int> comments,
      String postId,
      PostModel model,
      context,
      index,
      ) {
        var text = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: BlocConsumer<Appcubit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Card(
            color: Appcubit.get(context).isDark ? Colors.grey : Colors.white,
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
                        backgroundImage: NetworkImage(model.image!),

                        //  NetworkImage('${postownerdetails[postId]!.image!}'),
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
                                  model.name!,
                                  style: TextStyle(height: 1.3),
                                ),
                                SizedBox(
                                  width: 3,
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
                      if (model.uId == FirebaseAuth.instance.currentUser!.uid)
                        PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              height: 7,
                              onTap: () {
                                SocialCubit.get(context).deletepost(postId);
                              },
                              child: Text('remove'),
                            ),
                          ],
                        )
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
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          width: double.infinity,
                          height: 300,
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
                                    color: likes[postId]! > 0
                                        ? Colors.red[300]
                                        : Colors.grey[300],
                                    size: 20,
                                  ),
                                  Text(
                                    likes[postId].toString(),
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
                              SocialCubit.get(context).getPostComments(postId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BlocConsumer<Appcubit, Appstates>(
                                    listener: (context, states) {},
                                    builder: (context, states) {
                                      if (Appcubit.get(context).isDark)
                                        return Text(
                                          comments[postId].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: comments[postId]! > 0
                                                    ? Colors.blueAccent
                                                    : Colors.white,
                                              ),
                                        );
                                      else
                                        return Text(
                                          comments[postId].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: comments[postId]! > 0
                                                    ? Colors.blueAccent
                                                    : Colors.grey,
                                              ),
                                        );
                                    },
                                  ),
                                  SizedBox(
                                    width: 1.5,
                                  ),
                                  if (comments[postId] == 1)
                                    Text(
                                      'comment',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: comments[postId]! > 0
                                                ? Colors.blueAccent
                                                : Colors.grey,
                                          ),
                                    ),
                                  if (comments[postId] != 1)
                                    BlocConsumer<Appcubit, Appstates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        if (Appcubit.get(context).isDark)
                                          return Text(
                                            'comments',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: comments[postId]! > 0
                                                      ? Colors.blueAccent
                                                      : Colors.white,
                                                ),
                                          );
                                        else
                                          return Text(
                                            'comments',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: comments[postId]! > 0
                                                      ? Colors.blueAccent
                                                      : Colors.grey,
                                                ),
                                          );
                                      },
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
                                      controller: text,
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
                                  if (text.text != '') {
                                    SocialCubit.get(context).comment(
                                      name: SocialCubit.get(context)
                                          .usermodel!
                                          .name!,
                                      userImage: SocialCubit.get(context)
                                          .usermodel!
                                          .image!,
                                      postid: postId,
                                      dateTime: now.toString(),
                                      userId: SocialCubit.get(context)
                                          .usermodel!
                                          .uId!,
                                      text: text.text,
                                    );
                                  }
                                },
                                icon: Icon(IconBroken.Send)),
                            if (mylikedpostslist.contains(postId))
                              InkWell(
                                onTap: () {
                                  SocialCubit.get(context).unlikePost(postId);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (mylikedpostslist.contains(postId))
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.red[300],
                                        size: 20,
                                      ),
                                    if (!mylikedpostslist.contains(postId))
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.grey[300],
                                        size: 20,
                                      ),
                                    Text(
                                      ' unlike',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                            if (!mylikedpostslist.contains(postId))
                              InkWell(
                                onTap: () {
                                  SocialCubit.get(context).likePost(postId);
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
                                      style:
                                          Theme.of(context).textTheme.caption,
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
          );
        },
      ),
    );
  }

  Widget buildCommentItem(CommentModel model,context) {
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
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 5, right: 2.5),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.name!,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 3.5,
                          ),
                          Text(
                            model.text!,
                          ),
                        ],
                      ),
                      Spacer(),
                      ],
                  ),
                ),
              ),
            ),
          if(model.userId == FirebaseAuth.instance.currentUser!.uid)
            Container(width: 20,
              child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).deletesinglecomment(
                                  model.postid!, model.commentId!);
                                 Navigator.pop(context);
                            },
                            icon: Icon(Icons.delete_forever_outlined)),
            )
                 
          ],
        ),
      ),
    );
  }

  Widget buildstoryitem(context, StoryModel model) => Container(
        width: 40,
        child: InkWell(
          onTap: () {
            NavigateTo(
                context,
                Story(
                  id: model.uId,
                ));
            print(model.uId);
          },
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(model.storyimage!),
                  ),
                  CircleAvatar(
                    radius: 6.0,
                    backgroundColor: Colors.white,
                  ),
                  CircleAvatar(
                    radius: 5.0,
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                model.name!,
                maxLines: 2,
                style: TextStyle(
                  height: 1,
                  fontSize: 8,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
}
