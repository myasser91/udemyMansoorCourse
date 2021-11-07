import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/storyModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Story extends StatefulWidget {
  String? id;
  Story({this.id});

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  var indicatorcontroller = PageController();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 10)).then((_) {
      int nextPage = indicatorcontroller.page!.round() + 1;

      if (nextPage == SocialCubit.get(context).storiesperperson.length) {
        nextPage = 0;
      }

      indicatorcontroller
          .animateToPage(nextPage,
              duration: Duration(milliseconds: 500), curve: Curves.linear)
          .then((_) => _animateSlider());
    });
  }

  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getStoriesperperson(widget.id!);
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
                    offset: Offset(0, -330),
                    child: SmoothPageIndicator(
                        effect: ExpandingDotsEffect(
                          expansionFactor: 10,
                          dotColor: Colors.white,
                          activeDotColor: Colors.teal,
                        ),
                        //  WormEffect(
                        //   dotColor: Colors.grey,
                        //   dotWidth: 30,
                        //   paintStyle: PaintingStyle.fill,
                        //   activeDotColor: Colors.teal,
                        // ),
                      
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
    return Container(color: Colors.grey.withAlpha(50) ,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
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
            child: Padding(

              padding: const EdgeInsets.only(left: 25,right: 25,bottom: 25,),
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    
                    image: NetworkImage(model.storyimage!),
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}
