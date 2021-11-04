import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/storyModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Story extends StatelessWidget {
  String? id;
  Story({this.id});
  var indicatorcontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getStoriesperperson(id!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: PageView.builder(
                    itemBuilder: (context, index) => buildStory(context,
                        SocialCubit.get(context).storiesperperson[index]),
                    itemCount: SocialCubit.get(context).storiesperperson.length,
                    controller: indicatorcontroller,
                  ),
                ),
                Transform.translate(
                    offset: Offset(0, -270),
                    child: SmoothPageIndicator(
                        effect: WormEffect(
                          dotColor: Colors.grey,
                          dotWidth: 30,
                          paintStyle: PaintingStyle.fill,
                          activeDotColor: Colors.teal,
                        ),
                        controller: indicatorcontroller,
                        count:
                            SocialCubit.get(context).storiesperperson.length)),
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildStory(context, StoryModel model) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              width: double.infinity,
              height: 60,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(model.image!),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Text(
                        model.name!,
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                    ],
                  ),
                ],
              )),
        ),
        Expanded(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(model.storyimage!),
              ))),
        ),
      ],
    );
  }
}
