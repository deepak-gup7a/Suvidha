import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.pink[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SUV',
                  style: TextStyle(
                      fontFamily:'Uncial',
                      fontSize: 25,
                      // fontWeight: FontWeight.bold,
                    //color: Colors.white,

                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/feminine.png'),
                  backgroundColor: Color.fromRGBO(120, 120, 120, 0),
                ),
                Text(
                  'DHA',
                  style: TextStyle(
                    fontFamily:'Uncial',
                    fontSize: 25,
                    //color: Colors.white,

                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Center(
              child: SpinKitChasingDots(
                color: Colors.pinkAccent,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
