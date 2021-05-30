import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mad_project/modals/items.dart';
import 'package:mad_project/modals/request.dart';
import 'package:mad_project/modals/shopkeeper.dart';
import 'package:mad_project/modals/user.dart';
import 'package:mad_project/screens/finalCart.dart';
import 'package:mad_project/shared/loading.dart';
import 'package:provider/provider.dart';

class ItemShoppingPage extends StatefulWidget {
  AppUser user = AppUser();
  Shopkeeper shopkeeper = Shopkeeper();

  ItemShoppingPage({this.user, this.shopkeeper});

  @override
  _ItemShoppingPageState createState() => _ItemShoppingPageState();
}

class _ItemShoppingPageState extends State<ItemShoppingPage> {
  Map<Item, int> finalCart = Map();
  Request request = Request();
  final _formKey = GlobalKey<FormState>();
  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
    request = Request(
        uid: widget.user.uid + DateTime.now().toIso8601String(),
        shopName: widget.shopkeeper.shopName,
        shopkeeperName: widget.shopkeeper.shopkeeperName,
        status: "STATUS_PENDING",
        expectedTime: 0,
        error: "",
        customerName: widget.user.name,
        customerAddress: widget.user.address,
        requestTime: DateTime.now().toIso8601String(),
        totalPrice: 0,
        acceptTime: "",
        items: Map());
  }

  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<List<Item>>(context) ?? [];
    // map Item ->
    return items.length == 0
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.pink[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child:MaterialButton(
                                      elevation: 6.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: Colors.white,
                                      onPressed: () async{
                                        dynamic res = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => FinalCart(
                                                      tempRequest: request,
                                                      finalCart: finalCart,
                                                      appUser: widget.user,
                                                      shopkeeper:
                                                          widget.shopkeeper,
                                                    )));
                                        if(res=="YES"){
                                          Navigator.pop(context);
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('$totalAmount INR  ', style: TextStyle(fontSize: 15), ),
                                            Icon(
                                              Icons.shopping_cart,
                                              size: 35,
                                            //  color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),),
                                Row(
                                  children: [
                                    Icon(Icons.shop,color: Colors.white),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.shopkeeper.shopName,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person,color: Colors.white),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.shopkeeper.shopkeeperName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: Colors.white),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                        flex: 2,
                                        child: Text(
                                          widget.shopkeeper.address,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                          ),
                                        ))

                                  ],
                                ),
                                SizedBox(height: 6,)
                              ],
                            ),
                          ),
                       ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Available Items",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Merienda",
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.pink,
                                  height: 10,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.pink[100],
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (_, index) {
                                return Card(
                                  //color: Colors.pink[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                                flex: 4,
                                                child: Text(
                                                  items[index].name,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )),
                                            Flexible(
                                                flex: 2,
                                                child: Text(
                                                    " " +
                                                        items[index]
                                                            .price
                                                            .toString() +
                                                        " INR",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold)))
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        ExpansionTile(
                                            initiallyExpanded: false,
                                            childrenPadding: EdgeInsets.all(8.0),
                                            title: Text('Item Detail'),
                                            children: [
                                              ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                  itemBuilder: (_,i){
                                                return Text("${i+1}. ${items[index].description.split('%')[i]}");
                                              },
                                              itemCount: items[index].description.split('%').length,
                                              ),
                                              // Text("${items[index].description}")
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40.0,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: items[index].tags.length,
                                              itemBuilder: (_, i) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                                  child: Chip(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                    // elevation: 2.0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    label: Text("#" +
                                                        items[index]
                                                            .tags[i]
                                                            .toString(),style: TextStyle(fontFamily: "Signika"),),
                                                  ),
                                                );
                                              }),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                color: Colors.pink[200],
                                                onPressed: () {
                                                  if (finalCart.containsKey(
                                                          items[index]) ==
                                                      true) {
                                                    setState(() {
                                                      finalCart[items[index]]++;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      finalCart[items[index]] = 1;
                                                    });
                                                  }
                                                  setState(() {
                                                    totalAmount +=
                                                        items[index].price;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text('Add to cart   ',style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Signika")),
                                                    Icon(Icons.add_shopping_cart_outlined, color: Colors.white),
                                                  ],
                                                )),
                                            Spacer(flex: 1),
                                            (finalCart.containsKey(
                                                        items[index]) ==
                                                    true)
                                                ? Row(
                                              children: [

                                                Column(
                                                  //crossAxisAlignment:CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${finalCart[items[index]]} Added',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.green,

                                                          fontSize: 20,
                                                      ),
                                                      softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 4,
                                                    ),
                                                    Text(
                                                      '${finalCart[items[index]] * items[index].price} INR',textAlign: TextAlign.end,maxLines: 2,),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      finalCart[items[index]]--;
                                                      totalAmount -=
                                                          items[index].price;
                                                    });
                                                    if (finalCart[
                                                    items[index]] ==
                                                        0)
                                                      setState(() {
                                                        finalCart.remove(
                                                            items[index]);
                                                      });
                                                  },
                                                  icon: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Container(),
                                            // Spacer(flex: 5),
                                            // (finalCart.containsKey(
                                            //             items[index]) ==
                                            //         true)
                                            //     ?  Column(
                                            //           //crossAxisAlignment:CrossAxisAlignment.end,
                                            //           children: [
                                            //             Text(
                                            //               '${finalCart[items[index]]} Added',
                                            //               style: TextStyle(
                                            //                   fontWeight:
                                            //                       FontWeight.bold,
                                            //                   color: Colors.green,
                                            //                   fontSize: 20),
                                            //             ),
                                            //             Text(
                                            //                 'Amount: ${finalCart[items[index]] * items[index].price} INR',textAlign: TextAlign.end,maxLines: 2,),
                                            //           ],
                                            //         )
                                            //     : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
