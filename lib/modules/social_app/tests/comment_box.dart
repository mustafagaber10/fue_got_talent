import 'package:flutter/material.dart';

class Comment_box extends StatefulWidget {
  const Comment_box({Key? key}) : super(key: key);

  @override
  State<Comment_box> createState() => _Comment_boxState();
}

class _Comment_boxState extends State<Comment_box> {
  @override
  Widget build(BuildContext context) {
    int likeCount = 4;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottomOpacity: 8.0,
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 8.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 23.0, horizontal: 18.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(2, 2),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white60,
                    offset: Offset(-2, -2),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              width: double.infinity,
              height: 105,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            'https://www.looper.com/img/gallery/the-bruce-wayne-scene-in-the-batman-that-went-too-far/intro-1646327826.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Ibrahim Safwat',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Best Movie Ever!!',
                                    style: TextStyle(fontSize: 16.0),
                                    maxLines: 5,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            children: [
                              Text(
                                TimeOfDay.hoursPerDay.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 40.0,
                              ),
                              const Text(
                                'Like',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 40.0,
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Reply',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 40.0,
                              ),
                              InkWell(
                                onTap: () {
                                  // _incrementCommentLikeCount();
                                },
                                child: Text(
                                  '$likeCount',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class chat extends StatelessWidget {
//   const chat({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Bottomkey(),
//     );
//   }
// }
