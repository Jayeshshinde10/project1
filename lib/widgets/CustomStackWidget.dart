import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/StockPriceSelectorWidegt.dart';

class CustomStackWidget extends StatefulWidget {
  const CustomStackWidget({super.key, required this.price});
  final double price;

  @override
  State<CustomStackWidget> createState() => _CustomStackWidgetState();
}

class _CustomStackWidgetState extends State<CustomStackWidget> {
  void onMarketChange(String value) {
    selectedMarket = value;
    setState(() {});
  }

  String selectedMarket = "Intraday";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Container(height: 50, color: Colors.grey.shade200),
                Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: StockPricChangerWidget(
              price: widget.price,
              onMarketChnage: onMarketChange,
              selectedMarket: selectedMarket,
            ),
          ),
        ],
      ),
    );
  }
}
