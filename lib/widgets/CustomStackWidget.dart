import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/CustomTextField.dart';
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

class AdvanncedOption extends StatefulWidget {
  const AdvanncedOption({
    super.key,
    required this.price,
    required this.selectedMarket,
  });
  final double price;
  final String selectedMarket;

  @override
  State<AdvanncedOption> createState() => _AdvanncedOptionState();
}

class _AdvanncedOptionState extends State<AdvanncedOption> {
  bool isStoploss = false;
  bool gtt = false;
  bool marketProtection = false;
  bool isAdvancedOptionVisible = false;
  bool isShowLess = false;
  late TextEditingController triggerPriceController;
  late TextEditingController limitPriceController;
  late TextEditingController stopLossPercentController;
  late TextEditingController targetPercentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    triggerPriceController = TextEditingController(text: "${widget.price}");
    limitPriceController = TextEditingController(text: "${widget.price}");
    stopLossPercentController = TextEditingController(text: "${-5}%");
    targetPercentController = TextEditingController(text: "${5}%");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 270),
        _SwitchTile(
          label: "StopLoss",
          onChange: (value) {
            isStoploss = value;
            setState(() {});
          },
          value: isStoploss,
        ),
        if (isStoploss)
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300.withOpacity(0.6), // soft shadow
                  blurRadius: 8, // how soft the shadow looks
                  offset: const Offset(0, 3), // move downward a bit
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  child: CustomTextField(
                    width: 150,
                    controller: stopLossPercentController,
                    label: "Trigger Price",
                    editIcon: Icon(Icons.colorize_outlined, color: Colors.blue),

                    onToggle: () {},
                    onChange: (value) {},
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: CustomTextField(
                    width: 150,
                    controller: targetPercentController,
                    label: "Limit",
                    editIcon: Icon(Icons.colorize_outlined, color: Colors.blue),
                    onToggle: () {},
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
          ),
        if (widget.selectedMarket != "Intraday") SizedBox(height: 20),
        if (widget.selectedMarket != "Intraday")
          _SwitchTile(
            label: "GTT",
            onChange: (value) {
              gtt = value;
              setState(() {});
            },
            value: gtt,
          ),

        if (gtt && !(widget.selectedMarket == "Intraday"))
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300.withOpacity(0.6), // soft shadow
                  blurRadius: 8, // how soft the shadow looks
                  offset: const Offset(0, 3), // move downward a bit
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  child: CustomTextField(
                    width: 150,
                    controller: triggerPriceController,
                    label: "Stoploss %",

                    onToggle: () {},
                    onChange: (value) {},
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: CustomTextField(
                    width: 150,
                    controller: limitPriceController,
                    label: "Target %",

                    onToggle: () {},
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
          ),

        SizedBox(height: 20),

        _SwitchTile(
          label: "Market Protection",
          onChange: (value) {
            marketProtection = value;
            setState(() {});
          },
          value: marketProtection,
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Text("Help", style: TextStyle(color: Colors.blue)),
            Spacer(),
            Text("Adanced Options", style: TextStyle(color: Colors.blue)),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                setState(() {
                  isAdvancedOptionVisible = !isAdvancedOptionVisible;
                });
              },
              child: Icon(
                isAdvancedOptionVisible
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        if (isAdvancedOptionVisible) ValidityOptions(),
        SizedBox(height: 50),
      ],
    );
  }
}

// class _SwitchTile extends StatelessWidget {
//   const _SwitchTile({
//     super.key,
//     required this.label,
//     required this.onChange,
//     required this.value,
//   });
//   final String label;
//   final bool value;
//   final Function(bool value) onChange;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(width: 5),
//             Icon(Icons.info_outline, color: Colors.blue, size: 20),
//           ],
//         ),
//         Spacer(),
//         SizedBox(
//           height: 50,
//           width: 30,
//           child: Switch(
//             // trackColor: Colors.white,
//             value: value,
//             onChanged: onChange,
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           ),
//         ),
//       ],
//     );
//   }
// }

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
  });

  final String label;
  final bool value;
  final Function(bool value) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.info_outline, color: Colors.blue, size: 18),
            ],
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChange,
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

class ValidityOptions extends StatefulWidget {
  const ValidityOptions({super.key});

  @override
  State<ValidityOptions> createState() => _ValidityOptionsState();
}

class _ValidityOptionsState extends State<ValidityOptions> {
  int selected = 0;
  late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withOpacity(0.6), // soft shadow
            blurRadius: 8, // how soft the shadow looks
            offset: const Offset(0, 3), // move downward a bit
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Validity",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selected = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected == 0 ? Colors.blue : Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 0,
                    right: 10,
                    bottom: 10,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Day",
                    style: TextStyle(
                      color: selected == 0 ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected == 1 ? Colors.blue : Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "IOC",
                    style: TextStyle(
                      color: selected == 1 ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  setState(() {
                    selected = 2;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected == 2 ? Colors.blue : Colors.grey.shade500,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Minutes",
                    style: TextStyle(
                      color: selected == 2 ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Disclosed Qty.",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        // Enabled border (default state)
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        // Focused border (when typing)
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        // Error border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                        ),
                        // Focused error border
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),

                        // Remove default border if you want only custom borders
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Minutes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // if()
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
