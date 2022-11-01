
import 'package:flutter/material.dart';

class Bottomkey extends StatefulWidget {
  const Bottomkey({Key? key}) : super(key: key);

  @override
  State<Bottomkey> createState() => _BottomkeyState();
}

class _BottomkeyState extends State<Bottomkey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            height: 61,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[

                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  border: InputBorder.none,),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.photo_camera_outlined,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.attach_file_outlined,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
