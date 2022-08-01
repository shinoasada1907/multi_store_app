import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/views/widgets/search_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const SearchWidget(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorWeight: 5,
            tabs: [
              RepeatedTab(
                label: 'Men',
              ),
              RepeatedTab(
                label: 'Women',
              ),
              RepeatedTab(
                label: 'Shoes',
              ),
              RepeatedTab(
                label: 'Bags',
              ),
              RepeatedTab(
                label: 'Electronics',
              ),
              RepeatedTab(
                label: 'Accessories',
              ),
              RepeatedTab(
                label: 'Home & Garden',
              ),
              RepeatedTab(
                label: 'Kids',
              ),
              RepeatedTab(
                label: 'Beauty',
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          Center(child: Text('Men screen')),
          Center(child: Text('Women screen')),
          Center(child: Text('Shoes screen')),
          Center(child: Text('Bags screen')),
          Center(child: Text('Electronics screen')),
          Center(child: Text('Accessories screen')),
          Center(child: Text('Home & Garden screen')),
          Center(child: Text('Kids screen')),
          Center(child: Text('Beauty screen')),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
