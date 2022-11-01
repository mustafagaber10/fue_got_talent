
abstract class SocialRegisterStates {}
class SocialRegisterInitialState extends SocialRegisterStates {}
class SocialRegisterLoadingState extends SocialRegisterStates {}
class SocialRegisterSuccessState extends SocialRegisterStates
{
  // final SocialLoginModel loginModel;
  // SocialRegisterSuccessState(this.loginModel);
}
class SocialRegisterErrorState extends SocialRegisterStates
{
  final String error;
  SocialRegisterErrorState(this.error);
}
// class SocialCreateUserSuccessState extends SocialRegisterStates
// {
//   // final SocialLoginModel loginModel;
//   // SocialRegisterSuccessState(this.loginModel);
// }
class SocialCreateUserSuccessState extends SocialRegisterStates {
  final String uid;
  SocialCreateUserSuccessState(this.uid);
}
class SocialCreateUserErrorState extends SocialRegisterStates
{
  final String error;
  SocialCreateUserErrorState(this.error);
}
class SocialRegChangePasswordVisibilityState extends SocialRegisterStates {}




