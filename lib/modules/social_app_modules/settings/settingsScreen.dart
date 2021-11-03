import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/commentModel.dart';
import 'package:messenger/models/socialModels/postModel%20.dart';
import 'package:messenger/models/socialModels/postfeedsusermodel.dart';
import 'package:messenger/modules/social_app_modules/edit_profile/edit_profileScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/styles/iconBroken.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
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
                        itemCount:
                            SocialCubit.get(context).postComments.length),
                  ));
        }

            
          },
          builder: (context, state) {
            var userModel = SocialCubit.get(context).usermodel;
var commentcontroller = TextEditingController();
            return BuildCondition(
              fallback: (context) => Center(child: CircularProgressIndicator()),
              condition: userModel != null && SocialCubit.get(context).myposts.length>0&&
             
                        
                         
                         SocialCubit.get(context).postsId.length> 0 &&
                          SocialCubit.get(context).myposts.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(onRefresh: ()=> SocialCubit.get(context).getposts(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(userModel!.coverimage!)),
                                )),
                            Transform.translate(
                              offset: Offset(0, 50),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(userModel.image!),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 55, width: double.infinity),
                        Text(
                          userModel.name!,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          userModel.bio!,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text('${SocialCubit.get(context).postsnumber.length}',
                                        style:
                                            Theme.of(context).textTheme.bodyText1),
                                    Text('post',
                                        style: Theme.of(context).textTheme.caption),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text('250',
                                        style:
                                            Theme.of(context).textTheme.bodyText1),
                                    Text('photos',
                                        style: Theme.of(context).textTheme.caption),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text('100',
                                        style:
                                            Theme.of(context).textTheme.bodyText1),
                                    Text('following',
                                        style: Theme.of(context).textTheme.caption),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text('10k',
                                        style:
                                            Theme.of(context).textTheme.bodyText1),
                                    Text('followers',
                                        style: Theme.of(context).textTheme.caption),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: OutlinedButton(
                              onPressed: () {},
                              child: Text('add photos'),
                            )),
                            SizedBox(
                              width: 3,
                            ),
                            OutlinedButton(
                              onPressed: () { 
                                NavigateTo(context, EditProfileScreen());
                              },
                              child: Icon(IconBroken.Edit),
                            )
                          ],
                        ),
                         ListView.separated(
                      itemCount: SocialCubit.get(context).myposts.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).postownerdetails,
                          SocialCubit.get(context).mylikedpostslist,
                          SocialCubit.get(context).postsLikesbymap,
                          SocialCubit.get(context).postsCommentsbymap,
                          SocialCubit.get(context).postsId[index],
                          SocialCubit.get(context).myposts[index],
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
                ),
              ),
            );
          }
    );
  }

Widget buildPostItem(
      Map<String, PostfeedUserData> postownerdetails,
      List<String> mylikedpostslist,
      Map<String, int> likes,
      Map<String, int> comments,
      String ids,
      PostModel model,
      context,
      index,
      TextEditingController t) {
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
                    backgroundImage:
                    
                     NetworkImage(model.image!),

                      //  NetworkImage('${postownerdetails[ids]!.image!}'),
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
                       //       '${postownerdetails[ids]!.name!}',
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
                                color:likes[ids]! > 0? Colors.red[300]:Colors.grey[300],
                                size: 20,
                              ),
                              Text(
                                likes[ids].toString(),
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
                          SocialCubit.get(context).getPostComments(ids);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                comments[ids].toString(),
                                style: Theme.of(context).textTheme.caption!.copyWith(color: comments[ids]! > 0? Colors.blueAccent:Colors.grey,),
                              ),
                             SizedBox(width: 1.5,),
                            if (comments[ids] == 1)
                              Text(
                                'comment',
                                style: Theme.of(context).textTheme.caption!.copyWith(color: comments[ids]! > 0? Colors.blueAccent:Colors.grey,),
                              ),
                            if (comments[ids] != 1)
                              Text(
                                'comments',
                                style: Theme.of(context).textTheme.caption!.copyWith(color: comments[ids]! > 0? Colors.blueAccent:Colors.grey,),
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
                                postid: ids,
                                dateTime: now.toString(),
                                userId:
                                    SocialCubit.get(context).usermodel!.uId!,
                                text: t.text,
                              );
                            },
                            icon: Icon(IconBroken.Send)),
                    
                    if (mylikedpostslist.contains(ids))
                     InkWell(
                            onTap: () {
                              SocialCubit.get(context).unlikePost(ids);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                
                                if (mylikedpostslist.contains(ids))
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red[300],
                                    size: 20,
                                  ),
                                if (!mylikedpostslist.contains(ids))
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.grey[300],
                                    size: 20,
                                  ),
                                Text(
                                  ' unlike',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          )
                      ,
                      if (!mylikedpostslist.contains(ids))
                       InkWell(
                            onTap: () {
                              SocialCubit.get(context).likePost(ids);
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
                          )
                        
                          ,
                          
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
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 5, right: 2.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

  

