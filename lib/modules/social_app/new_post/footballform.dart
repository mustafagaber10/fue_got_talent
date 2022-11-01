import 'package:flutter/material.dart';
import 'package:fue_got_talent/layout/social_app/cubit/cubit.dart';
import 'package:fue_got_talent/shared/components/components.dart';

import 'new_post_screen.dart';

class FootballForm extends StatefulWidget {
  const FootballForm({Key? key}) : super(key: key);

  @override
  State<FootballForm> createState() => FootballFormState();
}

class FootballFormState extends State<FootballForm> {
  Map<String,String> form = {};
  List<String> Questions = [
    'Select the position that you like to play :',
    'What’s your preferred leg for shooting ?',
    'Can you sprint with or without the ball ?',
    'Do you prefer playing in the depth or the sides of the pitch ?',
    'Do you prefer offensive ,defensive roles and Both ?',
    'Have you ever joined a club ?',
    'How long have you ever played football?',
    'What is your height ?',
    'What is your weight ?',
    'Select your age out of these ranges',
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
            //Q1
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
                      'ST',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Striker'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Striker',
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
                      'CF',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Center Forward'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Center Forward',
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
                      'LW',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Left Winger'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Left Winger',
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
                      'LM',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Left Midfielder'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Left Midfielder',
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
                      'RW',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Right Winger'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Right Winger',
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
                      'RM',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Right Midfielder'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Right Midfielder',
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
                      'CAM',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Central Attacking Midfielder'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Central Attacking Midfielder',
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
                      'CDM',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Central Defensive Midfielder'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Central Defensive Midfielder',
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
                      'CM',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Center Midfielder'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Center Midfielder',
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
                      'LB',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Left Back'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Left Back',
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
                      'RB',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Right Back'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Right Back',
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
                      'CB',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Center Back'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Center Back',
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
                      'GK',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    subtitle: const Text('Goalkeeper'),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Goalkeeper',
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
            //Q2
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
                      'Right',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Right',
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
                      'Left',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Left',
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
                      'Both',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Both',
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
            //Q3
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
                      'With',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'With',
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
                      'Without',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value:  'Without',
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
                      'Both',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Both',
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
            //Q4
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
                      'Depth',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Depth',
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
                      'Sides',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Sides',
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
                      'Both',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Both',
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
            //Q5
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
                      'Offensive',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Offensive',
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
                      'Defensive',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Defensive',
                    groupValue: selectedValues[4] ,
                    onChanged: (value) {
                      setState(
                            () {
                              selectedValues[4]  = value!;
                        },
                      );
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text(
                      'Both',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Both',
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
            //Q6
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
                      'Yes',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'Yes',
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
                      'No',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: 'No',
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
            //Q7
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
                      '< 1 Year',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '< 1 Year',
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
                      '1 Year',
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
                  RadioListTile<String>(
                    title: const Text(
                      '3 Years',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '3 Years',
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
                      '5 Years',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '5 Years',
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
            //Q8
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
                      '<160',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '<160',
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
                      '160> & <170',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '160> & <170',
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
                      '>170 & <180',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>170 & <180',
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
                      '>180 & <190',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>180 & <190',
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
                      '>190',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>190',
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
            //Q9
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
                      '<60 Kg',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '<60 Kg',
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
                      '>60 & <70 Kg',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>60 & <70 Kg',
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
                      '>70 & <80 Kg',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>70 & <80 Kg',
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
                      '>80 & <90 Kg',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>80 & <90 Kg',
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
                      '>90 & <100 Kg',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>90 & <100 Kg',
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
                      '<100 Kg',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '<100 Kg',
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
            //Q10
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
                      '<18',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '<18',
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
                      '>18 & <20',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '>18 & <20',
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
                      '>20',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    activeColor: Colors.deepPurple,
                    enableFeedback: true,
                    value: '<20',
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
