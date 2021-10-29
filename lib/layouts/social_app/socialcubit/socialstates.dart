abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePicckedSuccessState extends SocialStates {}

class SocialProfileImagePicckedErrorState extends SocialStates {}
class SocialMessageImagePicckedSuccessState extends SocialStates {}

class SocialMessageImagePicckedErrorState extends SocialStates {}

class SocialCoverImagePicckedSuccessState extends SocialStates {}

class SocialCoverImagePicckedErrorState extends SocialStates {}

class SocialProfileImageUploadSuccessState extends SocialStates {}

class SocialProfileImageUploadErrorState extends SocialStates {}

class SocialCoverImageUploadSuccessState extends SocialStates {}

class SocialCoverImageUploadErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateSuccessState extends SocialStates {}

class SocialuploadingLoadingState extends SocialStates {}

//create post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreateMessageImageLoadingState extends SocialStates {}

class SocialCreateMessageImageErrorState extends SocialStates {}

class SocialCreateMessageImageSuccessState extends SocialStates {}

class SocialPostImagePicckedSuccessState extends SocialStates {}

class SocialPostImagePicckedErrorState extends SocialStates {}

class Socialremovepostimagesuccessstate extends SocialStates {}
class Socialremovemessageimagesuccessstate extends SocialStates {}


class Socialremovepostimageerrorstate extends SocialStates {}

///posts
class SocialGetpostLoadingState extends SocialStates {}

class SocialGetpostSuccessState extends SocialStates {}

class SocialGetpostErrorState extends SocialStates {
  final String error;
  SocialGetpostErrorState(this.error);
}

///// post likes
///
class SocialPostlikeErrorState extends SocialStates {
  final String error;
  SocialPostlikeErrorState(this.error);
}


class SocialPostCommentErrorState extends SocialStates {
  final String error;
  SocialPostCommentErrorState(this.error);
}
class SocialPostlikesSuccessState extends SocialStates {}

class SocialPostlikeloadingState extends SocialStates {}

class SocialPostcommentSuccessState extends SocialStates {}

class SocialPostcommentloadingState extends SocialStates {}


class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialgetMessageSuccessState extends SocialStates{}

class SocialgetMessageLoadingState extends SocialStates{}

class SocialgetMessageErrorState extends SocialStates{}

//// postcomments
class SocialGetPostCommentsLoadingState extends SocialStates{}
class SocialGetPostCommentsSuccessState extends SocialStates{}
class SocialGetPostCommentsErrorState extends SocialStates{}

class SocialCommentonPostLoadingState extends SocialStates{

}
class SocialCommentonPostsuccessState extends SocialStates{
  
}
class SocialCommentonPostErrorState extends SocialStates{
  
}