import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/social_layout.dart';
import 'package:fue_got_talent/modules/social_app/social_register/cubit/cubit.dart';
import 'package:fue_got_talent/modules/social_app/social_register/cubit/states.dart';

import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/network/local/cache_helper.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';

import '../../../shared/components/constants.dart';
class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {
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
          }
        },
        builder: (context,state)
        {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              leading:
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  // final navigationState = SocialCubit.get(context).navigationKey.currentState!;
                  // navigationState.setPage(0);
                },
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(

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
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 36.0,horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Text(
                                      'Register ',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline4!.copyWith(
                                        fontSize: 46.0,
                                        color: Colors.white,
                                          fontFamily: 'Jannah',
                                      ),
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Text(
                                      'Register now to Share Your Talent',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 22.0,color: Colors.grey.shade300),
                                    ),



                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.white,borderRadius: BorderRadius.only(
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
                                        controller: nameController,
                                        type: TextInputType.name,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                        },
                                        label: 'User Name',
                                        prefix: Icons.person,
                                      ),
                                      const SizedBox(height: 15.0),
                                      defaultFormField(
                                        controller: emailController,
                                        type: TextInputType.emailAddress,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your email address';
                                          }
                                        },
                                        label: 'Email Address',
                                        prefix: Icons.email_outlined,
                                      ),
                                      const SizedBox(height: 15.0),
                                      defaultFormField(
                                        controller: phoneController,
                                        type: TextInputType.phone,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your phone number';
                                          }
                                        },
                                        label: 'Phone',
                                        prefix: Icons.phone,
                                      ),
                                      const SizedBox(height: 15.0),
                                      defaultFormField(
                                        controller: passwordController,
                                        type: TextInputType.visiblePassword,
                                        isPassword: SocialRegisterCubit.get(context).isPassword,
                                        suffix: SocialRegisterCubit.get(context).suffix,
                                        suffixPressedToggle: () {
                                          SocialRegisterCubit.get(context)
                                              .changePasswordVisibility();
                                        },

                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Password is too short';
                                          }
                                        },
                                        label: 'Password',
                                        prefix: Icons.lock,
                                      ),

                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      ConditionalBuilder(
                                        condition: state is! SocialRegisterLoadingState,
                                        builder: (context) =>
                                            Center(
                                              child: Container(
                                                height: 45,
                                                width: MediaQuery.of(context).size.width/1.5,
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
                                                      SocialRegisterCubit.get(context).userRegister(
                                                        email: emailController.text,
                                                        password: passwordController.text,
                                                        name: nameController.text,
                                                        phone: phoneController.text,
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    true ? 'Register'.toUpperCase():'Register',
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
                                      const SizedBox(height: 15.0,),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       'Register ',
                    //       style: Theme
                    //           .of(context)
                    //           .textTheme
                    //           .headline4!.copyWith(
                    //           color: Colors.deepPurple,
                    //           fontFamily: 'Jannah',
                    //       ),
                    //     ),
                    //     const SizedBox(height: 20.0,),
                    //     Text(
                    //       'Register now to Share Your Talent',
                    //       style: Theme
                    //           .of(context)
                    //           .textTheme
                    //           .bodyText1!
                    //           .copyWith(color: Colors.grey),
                    //     ),
                    //     const SizedBox(
                    //       height: 30.0,
                    //     ),
                    //     defaultFormField(
                    //       controller: nameController,
                    //       type: TextInputType.name,
                    //       validate: (String value) {
                    //         if (value.isEmpty) {
                    //           return 'Please enter your name';
                    //         }
                    //       },
                    //       label: 'User Name',
                    //       prefix: Icons.person,
                    //     ),
                    //     const SizedBox(height: 15.0),
                    //     defaultFormField(
                    //       controller: emailController,
                    //       type: TextInputType.emailAddress,
                    //       validate: (String value) {
                    //         if (value.isEmpty) {
                    //           return 'Please enter your email address';
                    //         }
                    //       },
                    //       label: 'Email Address',
                    //       prefix: Icons.email_outlined,
                    //     ),
                    //     const SizedBox(height: 15.0),
                    //     defaultFormField(
                    //       controller: phoneController,
                    //       type: TextInputType.phone,
                    //       validate: (String value) {
                    //         if (value.isEmpty) {
                    //           return 'Please enter your phone number';
                    //         }
                    //       },
                    //       label: 'Phone',
                    //       prefix: Icons.phone,
                    //     ),
                    //     const SizedBox(height: 15.0),
                    //     defaultFormField(
                    //       controller: passwordController,
                    //       type: TextInputType.visiblePassword,
                    //       isPassword: SocialRegisterCubit.get(context).isPassword,
                    //       suffix: SocialRegisterCubit.get(context).suffix,
                    //       suffixPressedToggle: () {
                    //         SocialRegisterCubit.get(context)
                    //             .changePasswordVisibility();
                    //       },
                    //
                    //       validate: (String value) {
                    //         if (value.isEmpty) {
                    //           return 'Password is too short';
                    //         }
                    //       },
                    //       label: 'Password',
                    //       prefix: Icons.lock,
                    //     ),
                    //
                    //     const SizedBox(
                    //       height: 30.0,
                    //     ),
                    //     ConditionalBuilder(
                    //       condition: state is! SocialRegisterLoadingState,
                    //       builder: (context) => defaultButton(
                    //         radius: 10,
                    //         background: Colors.deepPurple,
                    //         function: () {
                    //           if (formKey.currentState!.validate()) {
                    //             SocialRegisterCubit.get(context).userRegister(
                    //               email: emailController.text,
                    //               password: passwordController.text,
                    //               name: nameController.text,
                    //               phone: phoneController.text,
                    //             );
                    //           }
                    //         },
                    //         text: 'Register',
                    //       ),
                    //       fallback: (context) =>
                    //       const Center(child: CircularProgressIndicator()),
                    //     ),
                    //     const SizedBox(height: 15.0,),
                    //
                    //   ],
                    // ),
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
