import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moneymanagementclone/presentation/category/Expencetabview.dart';
import 'package:moneymanagementclone/presentation/category/IncomeTabView.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabbarcontroller;
  @override
  void initState() {
    _tabbarcontroller = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            controller: _tabbarcontroller,
            tabs: [
              Tab(
                text: "INCOME",
              ),
              Tab(
                text: "EXPENCE",
              )
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabbarcontroller,
          children: [IncomeTabView(), ExpenceTabView()],
        ))
      ],
    );
  }
}
