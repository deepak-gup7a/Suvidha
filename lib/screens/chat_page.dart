import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/modals/chat.dart';
import 'package:mad_project/shared/loading.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  @override
  Widget build(BuildContext context) {
    final reference = FirebaseDatabase.instance.reference().child('chat');
    TextEditingController ques = TextEditingController();
    return Scaffold(
      body: Container(
         color: Colors.pink[50],
        child: Stack(
          children: [
            StreamBuilder(
              stream: reference.onValue,
              builder: (context,AsyncSnapshot snap){
            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
              Map<dynamic, dynamic> data = snap.data.snapshot.value;
              List<Chat>item = [];
              data.forEach((key, value) => item.add(Chat(ques: value["ques"],ans:value["ans"])));
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.0,
                      margin: EdgeInsets.all(8.0),
                      // color: Colors.pink.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0
                                ),
                                children: [
                                  TextSpan(text: "Question : ",style: TextStyle(color:Colors.red,fontSize: 20.0,fontWeight: FontWeight.w900)),
                                  TextSpan(text: item[index].ques,style: TextStyle(fontWeight: FontWeight.w900))
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.blueGrey[600],
                                      fontSize: 15.0
                                  ),
                                  children: [
                                    TextSpan(text: "Answer : ",style: TextStyle(color:Colors.green,fontSize: 20.0,fontWeight: FontWeight.w900)),
                                    TextSpan(text: item[index].ans,style: TextStyle(wordSpacing: 4.0,fontWeight: FontWeight.w400))
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                  }

                  );
            }
         else{
              return Loading();
            }
              },
            ),
          ],
        ),
      ),
    );
  }
}