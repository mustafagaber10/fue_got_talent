
abstract class SocialStates{}
class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates
{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}


class SocialProfileImagePickedSuccessState extends SocialStates {}
class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageLoadingState extends SocialStates {}
class SocialUploadProfileImageSuccessState extends SocialStates {}
class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUpdateUserLoadingState extends SocialStates {}
class SocialUpdateUserSuccessState extends SocialStates {}
class SocialUpdateUserErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}
class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialPostVideoPickedSuccessState extends SocialStates {}
class SocialPostVideoPickedErrorState extends SocialStates {}

class SocialRemovePostVideoState extends SocialStates {}


class SocialGetPostsLoadingState extends SocialStates {}
class SocialGetPostsSuccessState extends SocialStates {}
class SocialGetPostsErrorState extends SocialStates
{
  final String error;
  SocialGetPostsErrorState(this.error);
}
class SocialGetProfilePostsLoadingState extends SocialStates {}
class SocialGetProfilePostsSuccessState extends SocialStates {}
class SocialGetProfilePostsErrorState extends SocialStates
{
  final String error;
  SocialGetProfilePostsErrorState(this.error);
}
class SocialRatePostSuccessState extends SocialStates {}
class SocialRatePostErrorState extends SocialStates
{
  final String error;
  SocialRatePostErrorState(this.error);
}
class SocialCreateCommentLoadingState extends SocialStates {}

class SocialCreateCommentSuccessState extends SocialStates {}

class SocialCreateCommentErrorState extends SocialStates {}
class SocialLogOutState extends SocialStates {}

class SocialLogOutSuccessState extends SocialStates
{
  // final String uId;
  //
  // SocialLogOutSuccessState(this.uId);


}

class SocialLogOutErrorState extends SocialStates
{
  final String error;

  SocialLogOutErrorState(this.error);

}
class SocialGetPostCommentsLoadingState extends SocialStates {}
class SocialGetPostCommentsSuccessState extends SocialStates {}
class SocialGetPostCommentsErrorState extends SocialStates
{
  final String error;
  SocialGetPostCommentsErrorState(this.error);
}
class SocialChangeModeState extends SocialStates {}


class SocialUsersGetSearchLoadingState extends SocialStates{}
class SocialUsersGetSearchSuccessState extends SocialStates{}
class SocialUsersGetSearchErrorState extends SocialStates {
  final String error;
  SocialUsersGetSearchErrorState(this.error);
}