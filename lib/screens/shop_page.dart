
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mad_project/database/item_database.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/modals/shopkeeper.dart';
import 'package:mad_project/modals/user.dart';
import 'package:mad_project/screens/item_shopping_page.dart';
import 'package:mad_project/screens/my_order_page.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int type = 0;
  int total = 0;
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    List<Shopkeeper> shopKeepers = Provider.of<List<Shopkeeper>>(context) ?? [];
    final appUser = Provider.of<AppUser>(context) ??
        AppUser(
            uid: "0",
            name: "",
            address: "",
            phoneNumber: "0000000000",
            periodLength: 0,
            menstrualLength: 0,
            lastMenstruation: [],
            requestIds: []);

    //TODO: if no shopkeeper is available
    return Scaffold(
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("NEAREST STORES", style: TextStyle(color: Colors.white, letterSpacing: 1.2,fontWeight: FontWeight.bold, fontFamily: "CinzelDecorative")),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white, size: 35,),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StreamProvider.value(
                          value: RequestDatabase().request,
                          child: MyPlaceOrderPage(appUser: appUser,),
                          initialData: null,
                        ),
                      ));
                },
              ),
            )
          ]),
      body: ListView.builder(
          itemCount: shopKeepers.length,
          itemBuilder: (_, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: ListTile(
                  title: Text(shopKeepers[index].shopName,style: TextStyle(fontWeight: FontWeight.w600),),
                  subtitle: Text(shopKeepers[index].address),
                  enabled: shopKeepers[index].available,
                  onTap: (){
                    if (shopKeepers[index].available == false) {
                      Fluttertoast.showToast(
                          msg: "shopkeeper is not available");
                    } else {
                      if (appUser.uid != "0") {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return MultiProvider(
                            providers: [
                              StreamProvider.value(
                                value: ItemDatabase().items,
                                initialData: null,
                              ),
                              StreamProvider.value(
                                value: RequestDatabase().request,
                                initialData: null,
                              ),
                            ],
                            child: ItemShoppingPage(
                              user: appUser,
                              shopkeeper: shopKeepers[index],
                            ),
                          );
                        }));
                      }
                    }
                  },
                  leading: CircleAvatar(child: Text('${shopKeepers[index].shopName[0]}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white))),
                  trailing: IconButton(
                   // icon: Icon(Icons.add_shopping_cart_rounded),\
                    icon: Icon(Icons.arrow_right),
                    onPressed: () {
                      if (shopKeepers[index].available == false) {
                        Fluttertoast.showToast(
                            msg: "shopkeeper is not available");
                      } else {
                        if (appUser.uid != "0") {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return MultiProvider(
                              providers: [
                                StreamProvider.value(
                                  value: ItemDatabase().items,
                                  initialData: null,
                                ),
                                StreamProvider.value(
                                  value: RequestDatabase().request,
                                  initialData: null,
                                ),
                              ],
                              child: ItemShoppingPage(
                                user: appUser,
                                shopkeeper: shopKeepers[index],
                              ),
                            );
                          }));
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}

