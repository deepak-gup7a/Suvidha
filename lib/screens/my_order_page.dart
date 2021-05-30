import 'package:flutter/material.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/modals/request.dart';
import 'package:mad_project/modals/user.dart';
import 'package:provider/provider.dart';

class MyPlaceOrderPage extends StatefulWidget {
  AppUser appUser = AppUser();
  MyPlaceOrderPage({this.appUser});

  @override
  _MyPlaceOrderPageState createState() => _MyPlaceOrderPageState();
}

class _MyPlaceOrderPageState extends State<MyPlaceOrderPage> {
  @override
  Widget build(BuildContext context) {
    List<Request> req = Provider.of<List<Request>>(context) ?? [];
    List<Request> userReq = [];
    for (Request r in req) {
      if (widget.appUser.requestIds.contains(r.uid)) {
        userReq.add(r);
      }
    }
    userReq.sort((a,b)=>DateTime.parse(b.requestTime).compareTo(DateTime.parse(a.requestTime)));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("ORDER   HISTORY", style: TextStyle(color: Colors.white, letterSpacing: 1.2,fontWeight: FontWeight.bold, fontFamily: "CinzelDecorative")),
        ),      ),
      body: SafeArea(
        child: userReq.length!=0?Container(
         // color: Colors.pink[50],
          child: SingleChildScrollView(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: userReq.length,
                itemBuilder: (_, index) {
                  List<String> itemName = [];
                  List<int> quantity = [];
                  userReq[index].items.forEach((key, value) {
                    itemName.add(key);
                    quantity.add(value);
                  });
                  DateTime _dateTime = DateTime.parse(userReq[index].requestTime);
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 8,
                                fit: FlexFit.tight,
                                child: Text(
                                  userReq[index].shopName ?? "someOne",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 22.0),
                                ),
                              ),
                              //Spacer(flex: 10),

                              //Spacer(flex: 1),
                              Flexible(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,

                                        children: [
                                          Icon(Icons.timelapse_sharp,size: 15,),
                                          SizedBox(width: 10),
                                          Text(_dateTime == null ? '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}}': '${_dateTime.hour.toString()}:${_dateTime.minute.toString()}',style: TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                      Text(_dateTime == null ? '${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}': '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',style: TextStyle(fontSize: 12),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            userReq[index].shopkeeperName ?? "someOne's Shop",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          ListTileTheme(
                            dense: true,
                            child: ExpansionTile(
                              title: Text(
                                "Order Summary",
                                style: TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.bold),
                              ),
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'S. No.',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Items',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Quantity',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(itemName.length, (index) {
                                      return DataRow(cells: [
                                        DataCell(Text((index + 1).toString())),
                                        DataCell(
                                            Text((itemName[index]).toString())),
                                        DataCell(
                                            Text((quantity[index]).toString())),
                                      ]);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          (userReq[index].status == "STATUS_PENDING")
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Your Order is pending", style: TextStyle(color: Colors.blue),
                                    ),
                                  MaterialButton(onPressed: (){
                                    showDialog(context: context, builder: (_){
                                      return AlertDialog(
                                        title: Text('Cancel Order?'),

                                        actions: [
                                          MaterialButton(onPressed: (){
                                              RequestDatabase().rejectRequest(userReq[index].uid, "S", "I CANCELLED", DateTime.now().toIso8601String());
                                              Navigator.pop(context);
                                          }, child: Text('Yes'),color: Colors.pink[100],),
                                          MaterialButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text('No'),color: Colors.pink[100],)
                                        ],
                                      );
                                    });

                                  }, child: Text("CANCEL ORDER",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
                                ],
                              )
                              : (userReq[index].status == "STATUS_ACCEPTED")
                                  ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text("Your Order has been Accepted ", style: TextStyle(color: Colors.green)),
                                            userReq[index].acceptTime!=null?Text("Expected Arrival Time: ${DateTime.parse(userReq[index].acceptTime).add(Duration(minutes: userReq[index].expectedTime))}"): Container(),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: MaterialButton(onPressed: (){
                                          showDialog(context: context, builder: (_){
                                            return AlertDialog(
                                              title: Text('Order Received?'),

                                              actions: [
                                                MaterialButton(onPressed: (){
                                                  RequestDatabase().orderDelivered(userReq[index].uid, "STATUS_COMPLETED");
                                                  Navigator.pop(context);
                                                }, child: Text('Yes'),color: Colors.pink[100],),
                                                MaterialButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: Text('No'),color: Colors.pink[100],)
                                              ],
                                            );
                                          });

                                        }, child: Text("ORDER RECEIVED?",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                                      ),
                                    ],
                                  )
                                  : (userReq[index].status == "STATUS_REJECTED")
                                      ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Your Order has been rejected ", style: TextStyle(color: Colors.red)),
                                          MaterialButton(
                                            padding: EdgeInsets.zero
                                            ,onPressed: (){
                                            showDialog(context: context, builder: (_){
                                              return AlertDialog(
                                                title: Text('${userReq[index].error}'),
                                                actions: [
                                                  MaterialButton(onPressed: (){
                                                    Navigator.pop(context);
                                                  },child: Text('Ok'),color: Colors.pink[200],)
                                                ],
                                              );
                                            });
                                          },child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Text('Reply from ${userReq[index].shopkeeperName} ', style: TextStyle(color: Colors.blueGrey)),
                                              Icon(Icons.message, color: Colors.blueGrey,),
                                            ],
                                          ),)
                                        ],
                                      )
                                      :  (userReq[index].status == "STATUS_COMPLETED")?Text("Order Successfully Delivered", style: TextStyle(color: Colors.green)):Text("You Cancelled The Order ", style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ):Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history,size: 40,),
              SizedBox(
                height: 10,
              ),
              Text("No History Available ",style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
