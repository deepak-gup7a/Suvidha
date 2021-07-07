
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mad_project/database/item_database.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/modals/shopkeeper.dart';
import 'package:mad_project/modals/user.dart';
import 'package:mad_project/screens/item_shopping_page.dart';
import 'package:mad_project/screens/my_order_page.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';


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
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;



  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getdistance(double startlat, double startlong, double endlat, double endlong) async {
    return await Geolocator().distanceBetween(startlat, startlong, endlat, endlong);

  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    print('cordinates');
    // print(_currentPosition.longitude);
    // print(_currentPosition.latitude);
    // tempShopkeeper = widget.shopkeeper;
    // shopAddress = tempShopkeeper.address.split('~')[0];
    // shoplang = tempShopkeeper.address.split('~')[1];
    // shoplat = tempShopkeeper.address.split('~')[2];

  }

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
            // double flat = 2.567893;
            // double flang = 4.345235;
            double flat = (shopKeepers[index].address.split('~').length > 1 ) ? double.parse(shopKeepers[index].address.split('~')[1]) : 0.0;
            double flang = (shopKeepers[index].address.split('~').length > 2 ) ? double.parse(shopKeepers[index].address.split('~')[2]) : 0.0;

            return FutureBuilder(
              future: _getdistance(_currentPosition.latitude, _currentPosition.longitude, flat, flang),
              builder: (context, snapshot) {
                return Container(
                child: Card(

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: ListTile(
                      title: Text(shopKeepers[index].shopName,style: TextStyle(fontWeight: FontWeight.w600),),
                      subtitle: Text(shopKeepers[index].address.split('~')[0]),
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
                      leading: CircleAvatar(child: Text('${(snapshot.data/1000).toStringAsFixed(1)}KM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white))),
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
                ),
              );
            });
          }),
    );
  }
}

