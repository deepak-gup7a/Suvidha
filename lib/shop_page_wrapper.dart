import 'package:flutter/material.dart';
import 'package:mad_project/database/request_database.dart';
import 'package:mad_project/database/shopkeeper_database.dart';
import 'package:mad_project/screens/shop_page.dart';
import 'package:provider/provider.dart';

class ShopPageWrapper extends StatefulWidget {
  @override
  _ShopPageWrapperState createState() => _ShopPageWrapperState();
}

class _ShopPageWrapperState extends State<ShopPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
    value: ShopkeeperDatabase().shopkeepersList,
      initialData: null,
    child: ShopPage()
    );
  }
}
