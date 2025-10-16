import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

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
  bool isFinished = false;
  UniqueKey _swipeKey = UniqueKey();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
            child: Form(
              key: _key,
              child: CustomDefaultTabController(
                isNse: isNse,
                price: isNse ? nsePrice : bsePrice,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Amount  ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "₹984.15",
                          style: TextStyle(
                            color: Colors.blue,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " + ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "₹1.03",
                          style: TextStyle(
                            color: Colors.blue,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "  Avail.  ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "₹0.00",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.blue),
                  onPressed: () {
                    // Refresh action
                  },
                ),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(0),
            color: Colors.grey.shade100,
            height: 100,
            padding: EdgeInsets.all(15),
            child: SwipeableButtonView(
              key: _swipeKey,
              buttonText: 'Swipe To Buy',
              buttonWidget: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
              ),

              activeColor: Colors.blue,
              isFinished: isFinished,
              onWaitingProcess: () {
                if (_key.currentState != null &&
                    _key.currentState!.validate()) {
                  // Form is valid, proceed with the action
                  Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      isFinished = true;
                    });
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please fill all required fields correctly',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );

                  // Reset the swipe button
                  setState(() {
                    isFinished = false;
                    _swipeKey = UniqueKey();
                  });
                }
              },
              onFinish: () async {
                setState(() {
                  isFinished = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
