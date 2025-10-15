import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/CustomTextField.dart';

class StockPricChangerWidget extends StatefulWidget {
  const StockPricChangerWidget({
    super.key,
    required this.price,
    required this.selectedMarket,
    required this.onMarketChnage,
  });
  final double price;
  final String selectedMarket;
  final Function(String value) onMarketChnage;

  @override
  State<StockPricChangerWidget> createState() => _StockPricChangerWidgetState();
}

class _StockPricChangerWidgetState extends State<StockPricChangerWidget> {
  bool isQuantitySelected = true;

  // void onQantToMarketChange() {
  //   // isQuantitySelected = !isQuantitySelected;
  //   // setState(() {});
  //   if (isQuantitySelected) {
  //     int quntity = int.parse(qController.text);
  //     String price = "${widget.price * quntity}";
  //     qController.text = "${int.parse(price)}";
  //   } else {
  //     double price = double.parse(qController.text);
  //     qController.text = "${price / widget.price}";
  //   }
  //   setState(() {
  //     isQuantitySelected = !isQuantitySelected;
  //   });
  // }
  int quantity = 1;

  void onQantToMarketChange() {
    setState(() {
      if (isQuantitySelected) {
        // Convert Quantity to Market Price
        int quantity = int.parse(qController.text);
        double totalPrice = widget.price * quantity;
        qController.text = totalPrice.toStringAsFixed(2);
      } else {
        // Convert Market Price to Quantity
        double totalPrice = double.parse(qController.text);
        quantity = (totalPrice / widget.price).round();

        qController.text = quantity.toString();
      }

      isQuantitySelected = !isQuantitySelected;
    });
  }

  late TextEditingController qController;
  late TextEditingController limitMarketroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qController = TextEditingController(text: "1");
    limitMarketroller = TextEditingController();
  }

  @override
  void dispose() {
    qController.dispose();
    limitMarketroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // shadow color
            spreadRadius: 2, // how wide the shadow spreads
            blurRadius: 8, // how soft the shadow looks
            offset: Offset(0, 4), // position of shadow (x, y)
          ),
        ],

        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      height: MediaQuery.of(context).size.height * 0.37,
      width:
          MediaQuery.of(context).size.width -
          MediaQuery.of(context).size.width * 0.1,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: qController,
                    quantity: quantity,
                    isQuantity: isQuantitySelected,
                    isDisabled: true,
                    label: isQuantitySelected ? "Quantity" : "Amount",
                    width: MediaQuery.of(context).size.width,
                    onToggle: onQantToMarketChange,
                    onChange: (value) {},
                  ),

                  SizedBox(height: 10),
                  CustomTextField(
                    onChange: (value) {},
                    controller: limitMarketroller,
                    onToggle: onQantToMarketChange,
                    isDisabled: true,
                    label: "Market",

                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 10),
                  // Row(
                  //   children:
                  // [_stockExchangeRadio(), _stockExchangeRadio()]),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey.shade100,

            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _stockExchangeRadio("Intraday"),
                _stockExchangeRadio("Longterm"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stockExchangeRadio(String value) {
    return Row(
      children: [
        RadioTheme(
          data: RadioThemeData(),
          child: Radio(
            activeColor: Colors.blue,
            value: value,
            groupValue: widget.selectedMarket,
            onChanged: (value) {
              widget.onMarketChnage(value!);
            },
            splashRadius: 1,
          ),
        ),
        Text(value, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
