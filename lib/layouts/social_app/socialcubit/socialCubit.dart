import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/commentModel.dart';
import 'package:messenger/models/socialModels/messageModel.dart';
import 'package:messenger/models/socialModels/postModel%20.dart';
import 'package:messenger/models/socialModels/socialUserModel.dart';
import 'package:messenger/modules/social_app_modules/chats/chatsScreen.dart';
import 'package:messenger/modules/social_app_modules/feeds/feedsScreen.dart';
import 'package:messenger/modules/social_app_modules/newpost/newPostScreen.dart';
import 'package:messenger/modules/social_app_modules/settings/settingsScreen.dart';
import 'package:messenger/modules/social_app_modules/users/usersScreen.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  bool profilepicIsSelected = false;
  bool messageimageselected = false;
  bool coverpicisselected = false;
  bool firsttime = true;
  bool firsttimechats = true;
  SocialUserModel? usermodel;
  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SocialSettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'post',
    'USers',
    'Settings',
  ];

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      //  print(pickedFile.path);
      print(' the profileimage path is  $profileImage');
      emit(SocialProfileImagePicckedSuccessState());
      profilepicIsSelected = true;
    } else {
      print('No image selected.');
      emit(SocialProfileImagePicckedErrorState());
    }
  }

  Future<void> getmessageimage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      messageimage = File(pickedFile.path);
      //  print(pickedFile.path);
      //  print(' the messsageimage path is  ${messageimage}');
      emit(SocialMessageImagePicckedSuccessState());
      messageimageselected = true;
    } else {
      print('No image selected.');
      emit(SocialMessageImagePicckedErrorState());
    }
  }

  Future<void> getcoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverimage = File(pickedFile.path);
      print(pickedFile.path);

      emit(SocialCoverImagePicckedSuccessState());
      coverpicisselected = true;
    } else {
      print('No image selected.');
      emit(SocialCoverImagePicckedErrorState());
    }
  }

  void uploadProfielImage({
    required String? name,
    required String? email,
    required String? phone,
    required String? bio,
  }) {
    emit(SocialuploadingLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print(value);

        emit(SocialProfileImageUploadSuccessState());
        updateuser(
            email: email, name: name, phone: phone, bio: bio, profile: value);
        profilepicIsSelected = false;
      }).catchError((error) {
        emit(SocialProfileImageUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialProfileImageUploadErrorState());
    });
  }

  void uploadCoverlImage({
    required String? name,
    required String? phone,
    required String? bio,
    required String? email,
  }) {
    emit(SocialuploadingLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        emit(SocialCoverImageUploadSuccessState());
        updateuser(
            email: email, name: name, phone: phone, bio: bio, cover: value);
        coverpicisselected = false;
      }).catchError((error) {
        emit(SocialCoverImageUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialCoverImageUploadErrorState());
    });
  }

  void updateuser({
    required String? name,
    required String? phone,
    required String? bio,
    required String? email,
    String? cover,
    String? profile,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: usermodel!.email,
      uId: uId,
      isEmailVerified: false,
      bio: bio,
      coverimage: cover ?? usermodel!.coverimage!,
      image: profile ?? usermodel!.image!,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      usermodel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

/////////////////////// posts

  File? postimage;
  File? messageimage;

  Future<void> getpostimage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postimage = File(pickedFile.path);
      print(pickedFile.path);

      emit(SocialPostImagePicckedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePicckedErrorState());
    }
  }

  void removepostimage() {
    postimage = null;
    emit(Socialremovepostimagesuccessstate());
  }

  void removemessageimage() {
    messageimage = null;
    emit(Socialremovemessageimagesuccessstate());
  }

  void uploadpostImage({
    required String datetime,
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(datetime: dateTime, text: text, postimage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void uploadmessageImage({
    required String receiverId,
    required String datetime,
    required String text,
  }) {
    emit(SocialCreateMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(messageimage!.path).pathSegments.last}')
        .putFile(messageimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendmessage(
            dateTime: datetime,
            text: text,
            messgeimage: value,
            receiverId: receiverId);
      }).catchError((error) {
        emit(SocialCreateMessageImageErrorState());
      });
    }).catchError((error) {
      emit(SocialCreateMessageImageErrorState());
    });
  }

  void createPost({
    required String datetime,
    required String text,
    String? postimage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: usermodel!.name,
      uId: usermodel!.uId,
      image: usermodel!.image,
      datetime: datetime,
      text: text,
      postimage: postimage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void changeBottomNav(int index) {
    if (index == 4 && firsttime == true) {
      getUserData();
      firsttime = false;
    }
    if (index == 1) {
      // getUserData();
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  void comment(
      {required String postid,
      required String userImage,
      required String userId,
      required String text,
      required String dateTime}) {
    CommentModel model = CommentModel(
      text: text,
      dateTime: dateTime,
      postid: postid,
      userId: userId,
      userImage: usermodel!.image!,
    );
    emit(SocialCommentonPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(SocialCommentonPostsuccessState());
    }).catchError((error) {
      emit(SocialCommentonPostErrorState());
      print(error.toString());
    });
  }

  void likePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('Likes')
        .doc(usermodel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialPostlikesSuccessState());
    }).catchError((error) {
      error.toString();
      emit(SocialPostlikeErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId)
          users.add(SocialUserModel.fromJson(element.data()));
        emit(SocialGetAllUsersSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<CommentModel> postComments = [];

  void getPostComments(String? postId) {
    postComments = [];
    emit(SocialGetPostCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        postComments.add(CommentModel.fromJson(element.data()));
      });

      emit(SocialGetPostCommentsSuccessState());
      print(postComments.length);
    }).catchError((error) {
      emit(SocialGetPostCommentsErrorState());
    });
  }

  void getposts() {
    likes = [];
    posts = [];
    postsId = [];
    comments = [];
    users = [];
    //emit(SocialGetpostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datetime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetpostSuccessState());
        }).catchError(((e) {
          print(e.toString());
        }));
      });
      emit(SocialGetpostSuccessState());
    }).catchError((error) {
      emit(SocialGetpostErrorState(error.toString()));
    });
  }

  void sendmessage({
    required String receiverId,
    required String dateTime,
    String? text,
    String? messgeimage,
  }) {
    MessageModel model = MessageModel(
      text: text ?? '',
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: usermodel!.uId!,
      messageimage: messgeimage ?? '',
    );

    if (model.text == '' && model.messageimage == '') {
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(usermodel!.uId!)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((error) {
        emit(SocialSendMessageErrorState());
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(usermodel!.uId!)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((error) {
        emit(SocialSendMessageErrorState());
      });
    }
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String recieverId,
  }) {
    emit(SocialgetMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId!)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialgetMessageSuccessState());
    });
  }
}
