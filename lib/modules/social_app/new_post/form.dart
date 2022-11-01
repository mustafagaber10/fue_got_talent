import 'package:flutter/material.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/shared/components/components.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({Key? key}) : super(key: key);

  @override
  State<Inquiry> createState() => InquiryState();
}

class InquiryState extends State<Inquiry> {
  Map<String,String> form = {};
  List<String> Questions = [
    'Which vocal tone are you most comfortable with?',
    'Which instrument do you prefer using?',
    'At which Age did you start singing?',
    'Do you always have a song in mind when you’re about to perform/rehearse?',
    'Are you comfortable with crowds?',
    'Which genre do you cater towards?',
    'have you always wanted to make a living out of singing?',
    'Do you like singing in pairs?',
    'Does your mood hinder your ability in singing?',
    'Have you taken any singing lessons in the past?',
  ];
  List<String> selectedValues = ['','','','','','','','','','','','',];
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton:FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: const Icon(Icons.save),
      //   label: const Text("Save"),
      // ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(25),
            //     bottomRight: Radius.circular(25),
            // ),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:Alignment.centerRight,
                colors: [Colors.deepPurpleAccent,
                  Colors.deepPurple,
                ]),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Inquiry Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stepper(
          // margin: EdgeInsets.only(left: 90),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children: <Widget>[
                // if(selectedValues[_currentStep]!='')
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: _currentStep == 9 ? Text(' Submit '.toUpperCase()) : const Text(' NEXT '),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                if(_currentStep != 0)
                  OutlinedButton(

                    onPressed: details.onStepCancel,
                    child: const Text('CANCEL'),
                  ),
              ],
            );
          },
          onStepContinue: () {
            if (_currentStep != 9)
            {
              if(selectedValues[_currentStep]!='')
                {
                    setState(() {
                      _currentStep++;
                    });
                }else
                {
                  showToast(msg: "Please Select Answer", state: ToastStates.ERROR);
                }
            }else{
              if(selectedValues[_currentStep]!='')
              {
                for(var i = 0; i < Questions.length; i++)
                {
                  form[Questions[i]] = selectedValues[i];
                }
                SocialCubit.get(context).form = form;
                Navigator.of(context).pop();
                // navigateTo(context, NewPostScreen(form:form));

              }else
              {
                showToast(msg: "Please Select Answer", state: ToastStates.ERROR);
              }
            }
          },
          onStepCancel: () {
            if (_currentStep != 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          type: StepperType.vertical,
          physics: const BouncingScrollPhysics(),

          // onStepTapped: (index) {
          //   setState(() {
          //     _currentStep = index;
          //   });
          // },
          currentStep: _currentStep,
          steps: [
            Step(
              isActive: _currentStep >= 0,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 1',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(

                    title: const Text(
                      'Low',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Low',
                    groupValue: selectedValues[0],
                    onChanged: (val) {
                      setState(
                        () {
                          selectedValues[0] = val!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Mid',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    // subtitle: const Text('rightwing'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Mid',
                    groupValue: selectedValues[0],
                    onChanged: (val) {
                      setState(
                        () {
                          selectedValues[0] = val!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'High',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    // subtitle: const Text('center'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'High',
                    groupValue: selectedValues[0],
                    onChanged: (val) {
                      setState(
                        () {
                          selectedValues[0] = val!;
                        },
                      );
                    },
                  ),

                ],
              ),
              subtitle:  Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[0],
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 2',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'I Do not use instruments',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'I Do not use instruments',
                    groupValue: selectedValues[1],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[1] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Strings',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    // subtitle: const Text('rightwing'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Strings',
                    groupValue: selectedValues[1],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[1] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Woodwind',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    // subtitle: const Text('center'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Woodwind',
                    groupValue: selectedValues[1],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[1] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Brass',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Brass',
                    groupValue: selectedValues[1],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[1] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Keyboards',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Keyboards',
                    groupValue: selectedValues[1],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[1] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Percussion',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Percussion',
                    groupValue: selectedValues[1],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[1] = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle:  Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[1],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 2,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 3',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      '<10',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '<10',
                    groupValue: selectedValues[2],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[2] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      '<18',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value:  '<18',
                    groupValue: selectedValues[2],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[2] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Above 20',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Above 20',
                    groupValue: selectedValues[2],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[2] = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle:  Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[2],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 3,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 4',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
                    groupValue: selectedValues[3],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[3] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
                    groupValue: selectedValues[3],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[3] = value!;
                        },
                      );
                    },
                  ),

                ],
              ),
              subtitle:  Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[3],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 4,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 5',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [

                  RadioListTile<String>(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
                    groupValue: selectedValues[4],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[4] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
                    groupValue: selectedValues[4] ,
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[4]  = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[4],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 5,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 6',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [

                  RadioListTile<String>(
                    title: const Text(
                      'opera',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'opera',
                    groupValue: selectedValues[5],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[5] = value!;
                        },
                      );
                    },

                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'rock',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'rock',
                    groupValue: selectedValues[5],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[5] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'pop',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'pop',
                    groupValue: selectedValues[5],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[5] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'folk',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'folk',
                    groupValue: selectedValues[5],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[5] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'jazz',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'jazz',
                    groupValue: selectedValues[5],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[5] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'country',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'country',
                    groupValue: selectedValues[5],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[5] = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[5],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 6,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 7',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
                    groupValue: selectedValues[6],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[6] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
                    groupValue: selectedValues[6],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[6] = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[6],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 7,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 8',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
                    groupValue: selectedValues[7],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[7] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
                    groupValue: selectedValues[7],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[7] = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[7],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 8,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 9',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
                    groupValue: selectedValues[8],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[8] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
                    groupValue: selectedValues[8],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[8] = value!;
                        },
                      );
                    },
                  ),

                ],
              ),
              subtitle:  Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[8],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Step(
              isActive: _currentStep >= 9,
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Question 10',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              content: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
                    groupValue: selectedValues[9],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[9] = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
                    groupValue: selectedValues[9],
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[9] = value!;
                        },
                      );
                    },
                  ),
                ],
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  Questions[9],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
      // body: ListView.separated(
      //   physics: const BouncingScrollPhysics(),
      //   itemBuilder: (BuildContext context, int index) =>Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: Colors.grey[100],
      //         borderRadius: BorderRadius.circular(12),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.grey.shade500,
      //             offset: const Offset(4, 4),
      //             blurRadius: 15,
      //             spreadRadius: 1,
      //           ),
      //           const BoxShadow(
      //             color: Colors.white60,
      //             offset: const Offset(-4, -4),
      //             blurRadius: 15,
      //             spreadRadius: 1,
      //           ),
      //         ],
      //       ),
      //       width: double.infinity,
      //       child: Column(
      //         children: [
      //           Row(
      //             children: const [
      //               Padding(
      //                 padding: EdgeInsets.only(
      //                   left: 20.0,
      //                   top: 13,
      //                 ),
      //                 child: Text(
      //                   'what is your favorite position?',
      //                   style: TextStyle(
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w500,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //             mainAxisAlignment: MainAxisAlignment.start,
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           RadioListTile<int>(
      //             title: const Text('Leftwing'),
      //             subtitle: const Text('leftwing'),
      //             activeColor: Colors.deepPurple,
      //             enableFeedback: true,
      //             value: 0,
      //             groupValue: _character,
      //             onChanged: (value) {
      //               setState(
      //                     () {
      //                   _character = 0;
      //                 },
      //               );
      //             },
      //           ),
      //           RadioListTile<int>(
      //             title: const Text('Rightwing'),
      //             subtitle: const Text('rightwing'),
      //             activeColor: Colors.deepPurple,
      //             enableFeedback: true,
      //             value: 1,
      //             groupValue: _character,
      //             onChanged: (value) {
      //               setState(
      //                     () {
      //                   _character = 1;
      //                 },
      //               );
      //             },
      //           ),
      //           RadioListTile<int>(
      //             title: const Text('Center'),
      //             subtitle: const Text('center'),
      //             activeColor: Colors.deepPurple,
      //             enableFeedback: true,
      //             value: 2,
      //             groupValue: _character,
      //             onChanged: (value) {
      //               setState(
      //                     () {
      //                   _character = 2;
      //                 },
      //               );
      //             },
      //           ),
      //           RadioListTile<int>(
      //             title: const Text('Goalie'),
      //             subtitle: const Text(
      //               'goalie',
      //             ),
      //             activeColor: Colors.deepPurple,
      //             enableFeedback: true,
      //             value: 3,
      //             groupValue: _character,
      //             onChanged: (value) {
      //               setState(
      //                     () {
      //                   _character = 3;
      //                 },
      //               );
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   separatorBuilder: (BuildContext context, int index) =>const Padding(
      //     padding: EdgeInsets.all(0.0),
      //   ),
      //   itemCount: 3,
      //
      // ),
    );
  }
}
