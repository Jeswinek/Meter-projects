import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:flutter_picker/flutter_picker.dart';
//import 'PickerData.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
class timer extends StatefulWidget {
  @override
  _timerState createState() => _timerState();
}

class _timerState extends State<timer> {
  final fb = FirebaseDatabase.instance.reference();
  bool switchControl = false;
  var textHolder = 'Timer is OFF';
  String Switchh='';
  String stateText;
  var settime;
  var time;

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Timer is ON';
        Switchh='on';
      });
      print('Switch is ON');
      final ref=fb.reference().child("plugTimer");
      {
        ref.child("status").set(Switchh);
      }
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Timer is OFF';
        Switchh='off';
      });
      print('Switch is OFF');
      final ref=fb.reference().child("plugTimer");
      {
        ref.child("status").set(Switchh);
      }
      // Put your code here which you want to execute on Switch OFF event.
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: Container(
          child: Column(
            children: [
              Time(),
              Time1()
            ],
          ),
        ),
      ),
    );
  }

  Widget Time(){
    return Container(
      height: MediaQuery.of(context).size.height / 6.5,
      margin: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        color: Colors.greenAccent[400],
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: 10, bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      child: Text(
                        'Timer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "Broadway",
                        ),
                      ),
                      padding: EdgeInsets.only(top: 8, right: 20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                            scale: 1.5,
                            child: Switch(
                              onChanged: toggleSwitch,
                              value: switchControl,
                              activeColor: Colors.green[800],
                              activeTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.red,
                              inactiveTrackColor: Colors.grey,
                            )),
                        Text(
                          '$textHolder',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
   Widget Time1(){
  return Container(

        height: MediaQuery.of(context).size.height / 6.5,
      margin: EdgeInsets.all(10),
     child: ListView(
         children: <Widget>[
         (stateText !=null) ? Text(stateText) : Container(),
     RaisedButton(
     child: Text('Picker Show Number'),
     onPressed: () {
     showPickerNumber(context);
     },
     ),
  //   child: Card(
  //   shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(8.0))),
  //   color: Colors.greenAccent[400],
  //   child: Column(
  //   children: <Widget>[
  //   ClipRRect(
  //   borderRadius: BorderRadius.only(
  //   topLeft: Radius.circular(8.0),
  //   topRight: Radius.circular(8.0),
  //   ),
  //   child: Padding(
  //   padding: EdgeInsets.only(top: 8, left: 10, bottom: 3),
  //   child: Row(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //   Padding(
  //   child: Text(
  //   'Timer',
  //   style: TextStyle(
  //   fontWeight: FontWeight.bold,
  //   fontStyle: FontStyle.normal,
  //   color: Colors.white,
  //   fontSize: 30,
  //   fontFamily: "Broadway",
  //   ),
  //   ),
  //
  //   padding: EdgeInsets.only(top: 8, right: 20),
  //   ),
  //   ],
  //   ),
  //
  //   ),
  //   ),
  //
  // ],
  //   ),
  //
  //
  //
  //   ),
  //   );
  // }

  ],
     ),
     );

}
  showPickerNumber(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 60, postfix: Text("hr  ")),
          NumberPickerColumn(begin: 0, end: 60,postfix: Text("min  ")),
        ]
        ),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: Text("Please Select"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
          time = picker.getSelectedValues();
          print(time[0]);
          settime = (time[0]*60)+time[1];
          print(settime);
          final ref=fb.reference().child("plugTimer");
          {
            ref.child("Plug1").set(settime);
          }
        }
    ).showDialog(context);

  }

}
