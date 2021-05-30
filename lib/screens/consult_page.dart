import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


class ConsultPage extends StatefulWidget {
  @override
  _ConsultPageState createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fluttertoast.showToast(msg: "The service is not available yet",toastLength: Toast.LENGTH_SHORT,);
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[200],
        onPressed: (){
          _makePhoneCall("+91 - 1111111111");
        },
        child: Icon(Icons.phone),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Consult with doctor on video Or voice call",style: TextStyle(fontFamily: 'dsc',fontSize: 30),textAlign: TextAlign.center,),
              Text("24 * 7 hr",style: TextStyle(fontFamily: 'dsc',fontSize: 30),),
              Image(image: AssetImage('assets/doctor.png'),)
            ],
          ),
        ),
      )
    );
  }
}
