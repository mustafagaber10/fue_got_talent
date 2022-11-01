import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/layout/social_app/cubit/states.dart';
import 'package:fue_got_talent/models/social_app/social_user_model.dart';
import 'package:fue_got_talent/modules/social_app/feeds/custom_image.dart';
import 'package:fue_got_talent/shared/components/components.dart';
import 'package:fue_got_talent/shared/styles/icon_broken.dart';
class EditProfileScreen extends StatelessWidget
{
  // var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  var profileFormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        SocialUserModel? userModel = SocialCubit.get(context).userModel;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        dynamic upProfileImage = SocialCubit.get(context).profileImage;
        dynamic profilePic;
        if (upProfileImage == null) {
          profilePic = NetworkImage(userModel.image.toString());
              // NetworkImage('${userModel.image}');
        } else {
          profilePic = FileImage(upProfileImage);
        }
        return Scaffold(
          appBar: defaultAppBar(
            leadingWidget: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            context: context,
            title: 'Edit Profile',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: MaterialButton(

                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                    );
                    if(SocialCubit.get(context).profileImage!=null)
                    {
                       SocialCubit.get(context).uploadProfileImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                       );
                    }
                  },
                  child: Text('Update'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Jannah',
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children:
              [
                if(state is SocialUpdateUserLoadingState)
                  const LinearProgressIndicator(),
                SizedBox(
                  height: 210.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 100.0,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft:  Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end:Alignment.centerRight,
                                colors: [Colors.deepPurpleAccent,
                                  Colors.deepPurple,
                                ]),                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children:
                        [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            radius: 90.0,
                            // backgroundImage: profileImage == null ? NetworkImage('${userModel!.image}'):FileImage(profileImage),
                            // backgroundImage:  NetworkImage('${userModel!.image}'),
                              backgroundImage: profilePic,
                          ),
                          IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                radius: 30.0,
                                child: const Icon(
                                  IconBroken.Camera,
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children:
                    [

                      const SizedBox(height: 20.0),
                      defaultFormField(

                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: IconBroken.User,
                      ),
                      const SizedBox(height: 15.0),

                      defaultFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'Bio must not be empty';
                          }
                          return null;
                        },
                        label: 'Bio',
                        prefix: IconBroken.Info_Square,
                      ),
                      const SizedBox(height: 15.0),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: IconBroken.Call,
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
