import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/CustomStackWidget.dart';

class CustomDefaultTabController extends StatelessWidget {
  const CustomDefaultTabController({
    super.key,
    required this.isNse,
    required this.price,
  });
  final bool isNse;
  final double price;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: isNse ? 5 : 3,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.grey.shade200,
        child: Column(
          children: [
            TabBar(
              labelPadding: EdgeInsetsGeometry.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Colors.blue),
                ),
              ),
              tabAlignment: TabAlignment.start,
              isScrollable: true,

              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsetsGeometry.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
              labelStyle: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              dividerColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Colors.blue,
              indicatorAnimation: TabIndicatorAnimation.linear,
              tabs: isNse
                  ? const [
                      Tab(text: "Regular"),
                      Tab(text: "MTF"),
                      Tab(text: "AMO"),
                      Tab(text: "Iceberg"),
                      Tab(text: "Cover"),
                    ]
                  : const [
                      Tab(text: "Regular"),

                      Tab(text: "AMO"),
                      Tab(text: "Iceberg"),
                    ],
            ),

            Expanded(child: CustomStackWidget(price: price, )),
          ],
        ),
      ),
    );
  }
}
