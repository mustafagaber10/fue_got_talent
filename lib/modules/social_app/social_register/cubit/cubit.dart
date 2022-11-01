import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/models/social_app/social_user_model.dart';
import 'package:fue_got_talent/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get (context) => BlocProvider.of(context);

  void userRegister({
    required String name ,
    required String email ,
    required String password,
    required String phone,

  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          name: name,
          phone: phone,
          email: value.user!.email!,
          uid: value.user!.uid,
      );

      emit(SocialRegisterSuccessState());
    }).catchError((error)
    {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }
  void userCreate({
    required String name ,
    required String email ,
    required String phone,
    required String uid,
  })
  {
    SocialUserModel model= SocialUserModel(
      name:name,
      email:email,
      phone:phone,
      uid:uid,
      image: 'https://img.freepik.com/free-photo/singer-performing-stage-live-show-double-color-exposure-effect_53876-104901.jpg?w=1480&t=st=1648132397~exp=1648132997~hmac=7f27742fd95a38b155c204274e937d5b5bfcebbf43f66f8ccbd8f0697a7121cb',
      bio: 'Write your bio ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState(uid));
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_off_outlined;
  bool  isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(SocialRegChangePasswordVisibilityState());
  }
}