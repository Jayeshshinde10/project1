

import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/AdavancedOptions.dart';

import 'package:zerodha_clone/widgets/StockPriceSelectorWidegt.dart';

class CustomStackWidget extends StatefulWidget {
  const CustomStackWidget({super.key, required this.price});
  final double price;

  @override
  State<CustomStackWidget> createState() => _CustomStackWidgetState();
}

class _CustomStackWidgetState extends State<CustomStackWidget> {
  
  void onMarketChange(String value) {
    selectedValue = value;

    setState(() {});
  }

  String selectedValue = "Intraday";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(height: 50, color: Colors.grey.shade200),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: AdvanncedOption(
                  price: widget.price,
                  selectedMarket: selectedValue,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: StockPricChangerWidget(
              price: widget.price,
              onMarketChnage: onMarketChange,
              selectedMarket: selectedValue,
            ),
          ),
        ],
      ),
    );
  }
}
