import 'package:flutter/material.dart';
import 'package:multi_store/screens/dashborard_components/delivered_order.dart';
import 'package:multi_store/screens/dashborard_components/preparing_order.dart';
import 'package:multi_store/screens/dashborard_components/shipping_order.dart';
import '../../widgets/appbar_widget.dart';

class SupplierOrderScreen extends StatelessWidget {
  const SupplierOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const TitleAppbar(title: 'Orders'),
          leading: const AppbarBackButton(),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.lightBlue,
            indicatorWeight: 8,
            tabs: [
              RepeatedTab(label: 'preparing'),
              RepeatedTab(label: 'Shipping'),
              RepeatedTab(label: 'Delivered'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PreparingScreen(),
            ShippingScreen(),
            DeliveryScreen(),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
