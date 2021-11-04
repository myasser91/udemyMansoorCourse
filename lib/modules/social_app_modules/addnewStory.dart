import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/styles/iconBroken.dart';

class AddStory extends StatelessWidget {
  const AddStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
if (state is SocialCreateStorySuccessState)
{
  Navigator.pop(context);
}

      },
      builder: (context, state) {
        var model = SocialCubit.get(context).usermodel;
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                if(state is SocialCreateStoryLoadingState)
                LinearProgressIndicator(),
                if (SocialCubit.get(context).storyimage != null)
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: FileImage(
                        SocialCubit.get(context).storyimage!,
                      ),
                    )),
                  ),
                if ((SocialCubit.get(context).storyimage == null))
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                 if (SocialCubit.get(context).storyimage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,right: 20),
                  child: IconButton(onPressed: () {
SocialCubit.get(context).uploadStorylImage(name: model!.name!, uId: model.uId!, datetime: DateTime.now().toString(), image: model.image!);


                  }, icon: Icon(IconBroken.Arrow___Right,color: Colors.blue,size: 40,)),
                ),
            if(state is SocialuploadingLoadingState)
                Transform.translate(offset: Offset(0, -700),
                  child: LinearProgressIndicator(minHeight: 8,)),
              ],
            ),
          ),
        );
      },
    );
  }
}
