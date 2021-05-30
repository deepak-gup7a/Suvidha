
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/database/shopkeeper_database.dart';
import 'package:mad_project/database/user_database.dart';
import 'package:mad_project/modals/items.dart';
import 'package:mad_project/modals/request.dart';
import 'package:mad_project/modals/shopkeeper.dart';
import 'package:mad_project/modals/user.dart';
import 'package:mad_project/shared/constants.dart';

class FinalCart extends StatefulWidget {

  Request tempRequest = Request();
  Map<Item,int>finalCart = Map();
  AppUser appUser = AppUser();
  Shopkeeper shopkeeper = Shopkeeper();
  FinalCart({this.tempRequest,this.finalCart,this.appUser,this.shopkeeper});

  @override
  _FinalCartState createState() => _FinalCartState();
}

class _FinalCartState extends State<FinalCart> {
  
  final _formKey = GlobalKey<FormState>();
  bool closeThisTab = false;
  Request request = Request();
  List<String>itemName = [];
  List<int>quantity = [];
  List<int>price = [];
  int totalPrice=0;
  @override
  void initState() {
    super.initState();
    request = widget.tempRequest;

    widget.finalCart.forEach((key, value) {
      request.items[key.name]=value;
      itemName.add(key.name);
      quantity.add(value);
      price.add(key.price);
      totalPrice += value * (key.price);
    });
    request.totalPrice=totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Cart Summary',
                    style: TextStyle(
                        fontFamily: "CinzelDecorative",
                        fontWeight: FontWeight.w900,
                        fontSize: 25.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Divider(
                      color: Colors.pink[500],
                      height: 10,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) return "please enter your valid name";
                      return null;
                    },
                    initialValue: request.customerName != null
                        ? request.customerName
                        : 'user ',
                    decoration: textInputDecoration.copyWith(
                      // hintText: 'Shop Name',
                      labelText: 'your Name',
                    ),
                    onChanged: (val) {
                      setState(() {
                        request.customerName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) return "please enter your valid Address";
                      return null;
                    },
                    initialValue: request.customerAddress != null
                        ? request.customerAddress
                        : 'Address ',
                    decoration: textInputDecoration.copyWith(
                      // hintText: 'Shop Name',
                      labelText: 'your address',
                    ),
                    onChanged: (val) {
                      setState(() {
                        request.customerAddress = val;
                      });
                    },
                  ),
                  totalPrice!=0?Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Order Detail",
                              style: TextStyle(
                                  fontSize: 20,
                                  // fontFamily: "ReggaeOne",
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.pink[500],
                              height: 10,
                              thickness: 2,
                              indent: 10,
                              endIndent: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                  ):Container(),
                  totalPrice!=0?SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.pink[100]),
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
                            'Item Cost',
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

                        DataColumn(
                          label: Text(
                            'Final Cost',
                            style: TextStyle(
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: List.generate(widget.finalCart.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(
                              Text((itemName[index]).toString())),

                          DataCell(
                              Text((price[index]).toString())),
                          DataCell(
                              Text((quantity[index]).toString())),
                          DataCell(
                              Text((price[index]*quantity[index]).toString())),
                        ]);
                      }),
                    ),
                  ):Container(),
                  totalPrice!=0?Align(alignment: Alignment.centerLeft,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Card(
                          color: Colors.pink[50],
                          elevation:0.6,
                          child: Padding(

                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text('Total:  ${totalPrice} INR ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),),
                          ],
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('* If you want to change order, get back to previous page.', style: TextStyle(color: Colors.red,fontSize: 11.0,fontFamily: "Signika"),),
                      ),
                    ],
                  )):Container(),
                  totalPrice!=0?MaterialButton(
                    color: Colors.pink[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      dynamic res = await showDialog(context: context, builder: (_){
                        return AlertDialog(
                          title: Text('Confirm Order?'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          actions: [
                            MaterialButton(onPressed: (){
                              RequestDatabase().updateRequest(request);
                              List<String>userReqIds = widget.appUser.requestIds;
                              userReqIds.add(request.uid);
                              List<String>shopkeeperReqIds = widget.shopkeeper.requestIds;
                              shopkeeperReqIds.add(request.uid);
                              UserDatabase(uid: widget.appUser.uid).addRequestId(userReqIds);
                              ShopkeeperDatabase(uid: widget.shopkeeper.uid).addRequestId(shopkeeperReqIds);
                              Fluttertoast.showToast(msg: 'Order Place Successfully. Go to shopping History',toastLength: Toast.LENGTH_LONG);
                              Navigator.pop(context,"YES");
                            }, child: Text('Yes'),color: Colors.pink[100],),
                            MaterialButton(onPressed: (){
                              Navigator.pop(context,"NO");
                            }, child: Text('No'),color: Colors.pink[100],)
                          ],
                        );
                      });
                      if(res == "YES"){
                        Navigator.pop(context,"YES");
                      }
                    }
                  }, child: Text("PLACE ORDER",style: TextStyle(letterSpacing: 1.2, fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold,fontFamily: "Signika"),)):Container(),
                  totalPrice==0?Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('* please Add some Item to continue the order ', style: TextStyle(color: Colors.red,fontSize: 11.0,fontFamily: "Signika"),),
                  ):Container()
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
