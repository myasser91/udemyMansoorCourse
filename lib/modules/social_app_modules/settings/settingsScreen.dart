import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/modules/social_app_modules/edit_profile/edit_profileScreen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/styles/iconBroken.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userModel = SocialCubit.get(context).usermodel;

            return BuildCondition(
              fallback: (context) => Center(child: CircularProgressIndicator()),
              condition: userModel != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
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
                                Text('315',
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
                  ],
                ),
              ),
            );
          }
    );
  }
}
