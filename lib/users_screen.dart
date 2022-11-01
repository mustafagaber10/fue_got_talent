
import 'package:flutter/material.dart';
class UserModel {
final int id;
final String name;
final String phone;

  UserModel(
    {
      required this.id,
      required this.name, 
      required this.phone
    });

}
class usersScreen extends StatelessWidget {
  //const usersScreen({ Key? key }) : super(key: key);
  List<UserModel> Users= [ 
    UserModel(
    id:1,
    name: 'Ahmed',
    phone: '01154633930',
    ),
  ];
  @override
  Widget  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25.0,
        title: const Text('Users'),
        
      ),
      body: ListView.separated(
        itemBuilder: (context,index)=> BuildUserItem(Users[index]), 
        separatorBuilder: (context,index)=>Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ), 
        itemCount: Users.length,),     
    );
  }
  Widget BuildUserItem(UserModel user)=>(Padding(
      padding: const EdgeInsetsDirectional.all(20),
      child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(user.id.toString()
                ,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight : FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name.toString(),
                  style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )
                ),
                Text(user.phone,
                  style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )
                )
              ],
            ),
          ],
        ),
      )
  );
}
