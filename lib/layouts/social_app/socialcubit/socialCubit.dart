import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialstates.dart';
import 'package:messenger/models/socialModels/commentModel.dart';
import 'package:messenger/models/socialModels/messageModel.dart';
import 'package:messenger/models/socialModels/postModel%20.dart';
import 'package:messenger/models/socialModels/postfeedsusermodel.dart';
import 'package:messenger/models/socialModels/socialUserModel.dart';
import 'package:messenger/models/socialModels/storyModel.dart';
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
  bool StoryimageSelected = false;
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
  File? storyimage;
  Future<void> getStoryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      storyimage = File(pickedFile.path);

      print(' the Storyimage path is  $storyimage');
      emit(SocialStoryImagePicckedSuccessState());
      StoryimageSelected = true;
    } else {
      print('No image selected.');
      emit(SocialStoryImagePicckedErrorState());
    }
  }

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

  void uploadStorylImage({
    required String name,
    required String uId,
    required String datetime,
    required String image,
  }) {
    emit(SocialuploadingLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stories/${Uri.file(storyimage!.path).pathSegments.last}')
        .putFile(storyimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialStoryImageUploadSuccessState());
        createStory(
          name: name,
          uId: uId,
          image: image,
          datetime: datetime,
          storyimage: value,
        );

        StoryimageSelected = false;
      }).catchError((error) {
        emit(SocialStoryImageUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialStoryImageUploadErrorState());
    });
  }

  void createStory({
    required String datetime,
    required String name,
    required String storyimage,
    required String image,
    required String uId,
  }) {
    emit(SocialCreateStoryLoadingState());
    StoryModel model = StoryModel(
      name: usermodel!.name,
      uId: usermodel!.uId,
      image: usermodel!.image,
      datetime: datetime,
      storyimage: storyimage,
    );
    FirebaseFirestore.instance
        .collection('stories')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreateStorySuccessState());
    }).catchError((error) {
      emit(SocialCreateStoryErrorState());
    });
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
      updatepostsdata();
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
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
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
      getpostsnumber();
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

  void unlikePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('Likes')
        .doc(usermodel!.uId)
        .delete()
        .then((value) {
      emit(SocialPostUNlikesSuccessState());
      getposts();
    }).catchError((error) {
      error.toString();
      emit(SocialPostlikeErrorState(error.toString()));
    });
  }

  void likePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('Likes')
        .doc(usermodel!.uId)
        .set({
      'uId': usermodel!.uId,
      'like': true,
    }).then((value) {
      emit(SocialPostlikesSuccessState());
      getposts();
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
  List<CommentModel> postComments = [];
  List<String> postlikes = [];

// void updatecommentsavatar()
// {
// FirebaseFirestore.instance.collection('posts').get().then((value) {
//       value.docs.forEach((element) {
//         element.reference.collection('comments').get()
//         if (element.data()['uId'] == FirebaseAuth.instance.currentUser!.uid) {
//           element.reference
//               .update({'name': usermodel!.name, 'image': usermodel!.image})
//               .then((_) {})
//               .catchError((e) {
//                 e.toString();
//               });
//         }
//       });
//     }).catchError((e) {
//       print(e.toString());
//     });

// }

  void updatepostsdata() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] == FirebaseAuth.instance.currentUser!.uid) {
          element.reference
              .update({'name': usermodel!.name, 'image': usermodel!.image})
              .then((_) {})
              .catchError((e) {
                e.toString();
              });
        }
      });
      emit(SocialUpdatepostsdataSucessState());
    }).catchError((e) {
      emit(SocialUpdatepostsdataErrorState());
      print(e.toString());
    });
  }

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
    }).catchError((error) {
      emit(SocialGetPostCommentsErrorState());
    });
  }

  ///////////////waiting
  void getPostLikes(String? postId) {
    postlikes = [];
    emit(SocialGetPostCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        postlikes.add((element.data()['name']));
      });
      emit(SocialGetPostCommentsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostCommentsErrorState());
    });
  }

  List<String> postuId = [];
  List<LikesModel> likedpost = [];
  List<dynamic> postsnumber = [];
  void getpostsnumber() {
    postsnumber = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] == uId) postsnumber.add(element.data());
      });
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

  void getpostfeeduserdatasingle(String user, String postId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((value) {
      postownerdetails.addAll({
        postId: PostfeedUserData.fromJson(value.data()!),
      });
      //  print(value.data());
    }).catchError((e) {});
  }

  void deletepost(String postid) {
    emit(SocialDeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .delete()
        .then((value) {
      emit(SocialDeletePostSuccessState());
      getposts();
      getpostsnumber();
    }).catchError((e) {
      emit(SocialDeletePostErrorState());
      print(e.toString());
    });
  }

  Map<String, int> postsLikesbymap = ({});
  Map<String, int> postsCommentsbymap = ({});
  List<String> mylikedpostslist = [];
  Map<String, PostfeedUserData> postownerdetails = ({});
  List<PostModel> myposts = [];
  List<StoryModel> stories = [];
  List<StoryModel> storiesperperson = [];

void getStoriesperperson(String id) {
    storiesperperson = [];
    emit(SocialGetStoriesperpersonLoadingState());
    FirebaseFirestore.instance.collection('stories').get().then((value) {
      value.docs.forEach((element) {
       if(element.data()['uId']== id){
           storiesperperson.add(StoryModel.fromJson(element.data()));
        }       
       
        emit(SocialGetStoriesperpersonSuccessState());
      });
    }).catchError((e) {
      emit(SocialGetStoriesperpersonErrorState());
      print(e.toString());
    });
  }

List<StoryModel>  sotriesedited= [];
void sumstories (){
  sotriesedited= [];
stories.forEach((element) { 

if( sotriesedited.every((e) => e.uId != element.uId))
{
  sotriesedited.add(element);
}
});


}


  void getStories() {
    stories = [];
    emit(SocialGetStoriesLoadingState());
    FirebaseFirestore.instance.collection('stories').get().then((value) {
      value.docs.forEach((element) {    
           stories.add(StoryModel.fromJson(element.data()));       
        emit(SocialGetStoriesSuccessState());
      });
    }).
    catchError((e) {
      emit(SocialGetStoriesErrorState());
      print(e.toString());
    });
  }

  Future<void> getposts() async {
    postownerdetails = ({});
    postsLikesbymap = ({});
    postsCommentsbymap = ({});
    mylikedpostslist = [];
    posts = [];
    postsId = [];
    users = [];
    myposts = [];
    stories =[];
    emit(SocialGetpostLoadingState());
    getStories();
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] == FirebaseAuth.instance.currentUser!.uid) {
          myposts.add(PostModel.fromJson(element.data()));
        }
        // getpostfeeduserdatasingle(element.data()['uId'], element.id);
        element.reference.collection('comments').get().then((value) {
          postsCommentsbymap.addAll({element.id: value.docs.length});
        }).catchError((e) {
          print(e.toString());
        });

        element.reference.collection('Likes').get().then((value) {
          postsLikesbymap.addAll({element.id: value.docs.length});
          postsId.add(element.id);
          value.docs.forEach((e) {
            if (e.id == usermodel!.uId!) {
              mylikedpostslist.add(element.id);
            }
          });
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialgetlikesNumberSuccessState());

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
}
