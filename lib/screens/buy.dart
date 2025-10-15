import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/CustomDefaultTabController.dart';
import 'package:zerodha_clone/widgets/StockExchangeSelectorWidget.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  bool isNse = true;
  double nsePrice = 3007.20;
  double bsePrice = 3007.50;

  void onChange(value) {
    setState(() {
      isNse = value == "NSE" ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        title: Text(
          "TCS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios, size: 20),
        actions: [Icon(Icons.more_vert, color: Colors.grey.shade700)],
        bottom: StockExchangeSelectorWidget(
          selectedExchange: isNse ? "NSE" : "BSE",
          onChange: onChange,
          nsePrice: nsePrice,
          bsePrice: bsePrice,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomDefaultTabController(
              isNse: isNse,
              price: isNse ? nsePrice : bsePrice,
            ),
          ),

          Container(
            margin: EdgeInsets.all(0),
            color: Colors.red,
            height: 100,
            child: Row(),
          ),
        ],
      ),
    );
  }
}
