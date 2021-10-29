import 'package:flutter/material.dart';
import 'package:messenger/models/users/usermodel.dart';


// ignore: must_be_immutable
class UserScreen extends StatelessWidget {
  List<Usermodel> users = [
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
    Usermodel(id: 20, name: 'mohamed', phone: '01018883100'),
    Usermodel(id: 30, name: 'sara', phone: '214654654'),
    Usermodel(id: 50, name: 'ahmed', phone: '646546'),
    Usermodel(id: 10, name: 'fawzy', phone: '465465465'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('users'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => buildUserItem(users[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 70),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    height: 1,
                  ),
                ),
            itemCount: users.length));
  }

  Widget buildUserItem(Usermodel users) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: CircleAvatar(
              radius: 25.0,
              child: Text(
                '${users.id}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  ' ${users.name}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                '${users.phone}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      );
}
