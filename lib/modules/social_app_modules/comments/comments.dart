import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) => buildcommentitem(context),
          separatorBuilder: (context, index) => SizedBox(height: 1,),
          itemCount: 20),
    );
  }

  Widget buildcommentitem(context) {
    return    Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/beautiful-stupefied-european-woman-indicates-upwards-introduces-new-product-gasps-from-wonder-has-bugged-eyes-invites-click-promo-banner-wears-hoodie-isolated-yellow-wall_273609-42862.jpg'),
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
                               'mohamed yasser',
                            style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Text(
                            'the comment',
                            style: Theme.of(context).textTheme.caption,
                            
                          )
                        ],
                      ),
                    ),
                  ],
                );
            
  }
}
