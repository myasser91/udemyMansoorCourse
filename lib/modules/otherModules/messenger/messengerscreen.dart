// ignore: unused_import
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/117424435_2634987316760754_4060594253208063060_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=gJYXprLThC4AX-w-1_a&tn=guRW2lCp7mQHWfzr&_nc_ht=scontent.fcai20-3.fna&oh=005c0b8dcc432ec607a4a7c8a31fa5da&oe=6154FEB3'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Chats',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
              radius: 20,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    size: 20.0,
                  ))),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                radius: 20,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      size: 16.0,
                    ))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text('search'),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildstoryitem(),
                  itemCount: 20,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => bulidchatitem(),
              itemCount: 20,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulidchatitem() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/117424435_2634987316760754_4060594253208063060_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=gJYXprLThC4AX-w-1_a&tn=guRW2lCp7mQHWfzr&_nc_ht=scontent.fcai20-3.fna&oh=005c0b8dcc432ec607a4a7c8a31fa5da&oe=6154FEB3'),
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
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'sarah salah',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'The video chat ended',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text('8:59 pm'),
        ],
      );

  Widget buildstoryitem() => Container(
        width: 40,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'https://scontent.fcai20-3.fna.fbcdn.net/v/t1.6435-9/117424435_2634987316760754_4060594253208063060_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=gJYXprLThC4AX-w-1_a&tn=guRW2lCp7mQHWfzr&_nc_ht=scontent.fcai20-3.fna&oh=005c0b8dcc432ec607a4a7c8a31fa5da&oe=6154FEB3'),
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
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 3.0,
              ),
              child: Text(
                'mohamed yasser abdelaziz',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 10,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
