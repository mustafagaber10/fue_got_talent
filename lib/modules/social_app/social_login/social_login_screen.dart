import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/social_layout.dart';
import 'package:fue_got_talent/modules/social_app/forget_password/social_forget_password_screen.dart';
import 'package:fue_got_talent/modules/social_app/social_login/cubit/cubit.dart';
import 'package:fue_got_talent/modules/social_app/social_login/cubit/states.dart';
import 'package:fue_got_talent/modules/social_app/social_register/social_register_screen.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/components/constants.dart';
import 'package:fue_got_talent/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {

            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) async {
              SocialCubit.get(context).getUserData();
              token ??= await FirebaseMessaging.instance.getToken();
              FirebaseFirestore.instance.collection('users')
                  .doc(state.uid)
                  .set({'token':token!},SetOptions(merge: true));
              navigateAndFinish(context, SocialLayout());
            });

            // CacheHelper.saveData(
            //   key: 'uid',
            //   value: state.uid,
            // ).then((value) async {
            //   token ??= await FirebaseMessaging.instance.getToken();
            //   FirebaseFirestore.instance.collection('users')
            //       .doc(state.uid)
            //       .set({'token':token!},SetOptions(merge: true));
            //   navigateAndFinish(context, SocialLayout());
            // });
          }
          if (state is SocialLoginErrorState) {
            showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                        begin: Alignment.topLeft,
                        end:Alignment.centerRight,
                    ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36.0,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        fontSize: 46.0,
                                        color: Colors.white,
                                        fontFamily: 'Jannah'),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Enter now to Share Your Talent',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 22.0,color: Colors.grey.shade300),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),

                          )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10.0),

                                defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'please enter your email address';
                                    }
                                  },
                                  label: 'Email Address',
                                  prefix: Icons.email_rounded,
                                ),
                                const SizedBox(height: 20.0),
                                defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  isPassword: SocialLoginCubit.get(context).isPassword,
                                  suffix: SocialLoginCubit.get(context).suffix,
                                  suffixPressedToggle: () {
                                    SocialLoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  onSubmit: (value) {
                                    // if(formKey.currentState!.validate())
                                    // {
                                    //   SocialLoginCubit.get(context).userLogin(
                                    //     email: emailController.text,
                                    //     password: passwordController.text,
                                    //   );
                                    // }
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'password is too short';
                                    }
                                  },
                                  label: 'Password',
                                  prefix: Icons.lock,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          navigateTo(
                                              context, SocialForgetPasswordScreen());
                                        },
                                        child: Text(
                                          'forget password?'.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 15.0, color: Colors.deepPurple),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                ConditionalBuilder(
                                  condition: state is! SocialLoginLoadingState,
                                  builder: (context) =>
                                  //     defaultButton(
                                  //   width: MediaQuery.of(context).size.width/1.6,
                                  //   height: 55,
                                  //   radius: 40,
                                  //   background: ,
                                  //   function: () {
                                  //
                                  //   },
                                  //   text: 'Login',
                                  // ),
                                  Center(
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width/1.6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end:Alignment.centerRight,
                                            colors: [
                                          Colors.deepPurple, Colors.deepPurpleAccent
                                        ])
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            SocialLoginCubit.get(context).userLogin(
                                              email: emailController.text.trim(),
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        child: Text(
                                          true ? 'Login'.toUpperCase():'Login',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  fallback: (context) =>
                                      const Center(child: CircularProgressIndicator()),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Don\'t have an account?'),
                                    TextButton(
                                        onPressed: () {
                                          navigateTo(context, SocialRegisterScreen());
                                        },
                                        child: Text(
                                          'Register'.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 15.0, color: Colors.deepPurple),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
