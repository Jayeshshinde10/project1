import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StockExchangeSelectorWidget extends StatelessWidget
    implements PreferredSizeWidget {
  StockExchangeSelectorWidget({
    super.key,
    required this.selectedExchange,
    required this.onChange,
    required this.nsePrice,
    required this.bsePrice,
  });
  final String selectedExchange;
  Function(String value) onChange;
  final double nsePrice;
  final double bsePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: Colors.grey.shade200,
      height: 60, // Recommended for app bar height
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.grey.shade50,
        child: Row(
          children: [
            _stockExchangeRadio("NSE", nsePrice),
            _stockExchangeRadio("BSE", bsePrice),
          ],
        ),
      ),
    );
  }

  Widget _stockExchangeRadio(String value, double price) {
    return SizedBox(
      width: 150,
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          RadioTheme(
            data: RadioThemeData(),
            child: Radio(
              activeColor: Colors.blue,
              value: value,

              groupValue: selectedExchange,
              onChanged: (value) {
                onChange(value!);
              },
              splashRadius: 1,
            ),
          ),
          Text(value, style: TextStyle(color: Colors.grey.shade500)),
          SizedBox(width: 5),
          Text(
            price.toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
