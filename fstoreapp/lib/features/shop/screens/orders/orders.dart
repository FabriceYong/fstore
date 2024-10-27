
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/shop/screens/orders/widgets/order_list_items.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        title: Text('Orders', style: Theme.of(context).textTheme.headlineSmall,),
        showBackArrow: true,
      ),
      body: Padding(padding: EdgeInsets.all(FSizes.defaultSpace/2), child: FOrderListItems(),),
    );
  }
}