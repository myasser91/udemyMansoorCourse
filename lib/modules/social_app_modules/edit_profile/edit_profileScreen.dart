
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/styles/iconBroken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).usermodel;
        var namecontroller = TextEditingController();
        var phonecontroller = TextEditingController();
        final emailcontroller = TextEditingController();

        var biocontroller = TextEditingController();
       
        namecontroller.text = SocialCubit.get(context).usermodel!.name!;
        biocontroller.text = SocialCubit.get(context).usermodel!.bio!;
        phonecontroller.text = SocialCubit.get(context).usermodel!.phone!;

        emailcontroller.text = SocialCubit.get(context).usermodel!.email!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'EDIT PROFILE',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateuser(
                        email: emailcontroller.text,
                        name: namecontroller.text,
                        bio: biocontroller.text,
                        phone: phonecontroller.text);
                  },
                  child: Text('UPDATE',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.blue)))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                                image: (coverimage == null
                                    ? NetworkImage(userModel!.coverimage!)
                                    : FileImage(coverimage!)) as ImageProvider),
                          )),
                      Transform.translate(
                        offset: Offset(0, 50),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage: (profileImage == null
                                  ? NetworkImage('${userModel!.image!}')
                                  : FileImage(profileImage!)) as ImageProvider),
                        ),
                      ),
                      Transform.translate(
                          offset: Offset(150, -110),
                          child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 15,
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      print('Pressed');
                                      SocialCubit.get(context).getcoverImage();
                                    },
                                    icon: (Icon(
                                      IconBroken.Camera,
                                      size: 14,
                                    ))),
                              ))),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(height: 55, width: double.infinity),
                      Transform.translate(
                          offset: Offset(35, -10),
                          child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 15,
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                    
                                      SocialCubit.get(context)
                                          .getProfileImage();
                                    },
                                    icon: (Icon(
                                      IconBroken.Camera,
                                      size: 15,
                                    ))),
                              ))),
                    ],
                  ),
                  if(SocialCubit.get(context).profilepicIsSelected || SocialCubit.get(context).coverpicisselected)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          if(SocialCubit.get(context).profilepicIsSelected)
                          Expanded(
                            child: defaultButtom(
                                onpress: () {
                                  SocialCubit.get(context).uploadProfielImage(
                                      email: emailcontroller.text,
                                      name: namecontroller.text,
                                      phone: phonecontroller.text,
                                      bio: biocontroller.text);
                                },
                                text: 'UPLOAD PROFILE'),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                         if(SocialCubit.get(context).coverpicisselected)
                          Expanded(
                              child: defaultButtom(
                                  onpress: () {
                                    SocialCubit.get(context).uploadCoverlImage(
                                        email: emailcontroller.text,
                                        name: namecontroller.text,
                                        phone: phonecontroller.text,
                                        bio: biocontroller.text);
                                  },
                                  text: 'UPLOAD cover')),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  if(state is SocialuploadingLoadingState)
                  LinearProgressIndicator(),
                   SizedBox(
                    height: 5,
                  ),
                  defaultFormField(
                      type: TextInputType.name,
                      prefixIcon: IconBroken.User,
                      labelText: 'Name',
                      controller: namecontroller,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'must be entered';
                        }
                      }),
                  SizedBox(height: 20, width: double.infinity),
                  defaultFormField(
                      type: TextInputType.name,
                      prefixIcon: IconBroken.Info_Circle,
                      labelText: 'bio',
                      controller: biocontroller,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'must be entered';
                        }
                      }),
                  SizedBox(height: 20, width: double.infinity),
                  defaultFormField(
                      type: TextInputType.phone,
                      prefixIcon: IconBroken.Call,
                      labelText: 'phone',
                      controller: phonecontroller,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'must be entered';
                        }
                      }),
                  SizedBox(height: 20, width: double.infinity),
                  defaultFormField(
                      type: TextInputType.emailAddress,
                      prefixIcon: IconBroken.Message,
                      labelText: 'Email',
                      controller: emailcontroller,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'must be entered';
                        }
                      }),
                  SizedBox(height: 20, width: double.infinity),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget uploadbottom(double x, double y) {
  //   return Transform.translate(
  //       offset: Offset(x, y),
  //       child: CircleAvatar(
  //           backgroundColor: Colors.blue,
  //           radius: 15,
  //           child: Center(
  //             child: IconButton(
  //                 onPressed: () {},
  //                 icon: (Icon(
  //                   IconBroken.Camera,
  //                   size: 14,
  //                 ))),
  //           )));
  // }
}
