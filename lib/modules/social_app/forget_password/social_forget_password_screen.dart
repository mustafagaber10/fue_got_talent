import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fue_got_talent/shared/components/components.dart';

class SocialForgetPasswordScreen extends StatefulWidget {
  @override
  State<SocialForgetPasswordScreen> createState() => _SocialForgetPasswordScreenState();
}

class _SocialForgetPasswordScreenState extends State<SocialForgetPasswordScreen> {
  var emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showToast(msg: 'Sent', state: ToastStates.SUCCESS);

    } on FirebaseAuthException catch (e){
      print(e);
      showToast(msg: e.message.toString(), state: ToastStates.ERROR);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [

          Text('Forget Password',
            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.deepPurple,
                fontFamily: 'Jannah',
            fontSize: 28),
          ),
          const SizedBox(height: 20.0,),
          Text('Enter Your Email and we will send you a password reset link',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 30.0,),
          defaultFormField(
            controller: emailController,
            type: TextInputType.emailAddress,
            validate:(String value){
              if(value.isEmpty)
              {
                return 'please enter your email address';
              }
            },
            label: 'Email Address',
            prefix: Icons.email_outlined,
          ),
          const SizedBox(height: 25.0,),


            defaultButton(
              radius: 10,
              isUpperCase: false,
              background: Colors.deepPurple,
              function:()
              {
                passwordReset();
              },
              text: 'Reset Password',
            )
        ],
      ),
    ),
    );
  }
}
