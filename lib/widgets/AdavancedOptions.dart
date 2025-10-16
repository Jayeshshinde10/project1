import 'package:flutter/material.dart';
import 'package:zerodha_clone/widgets/CustomTextField.dart';
import 'package:zerodha_clone/widgets/ValidityOptions.dart';
import 'package:zerodha_clone/widgets/gttfields.dart';

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
    super.initState();
    triggerPriceController = TextEditingController(text: "${widget.price}");
    limitPriceController = TextEditingController(text: "${widget.price}");
    stopLossPercentController = TextEditingController(text: "${5}");
    targetPercentController = TextEditingController(text: "${5}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.33),
        CustomSwitchTile(
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
                    showSuffixicon: false,
                    controller: triggerPriceController,
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
                    controller: limitPriceController,
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
          CustomSwitchTile(
            label: "GTT",
            onChange: (value) {
              gtt = value;
              setState(() {});
            },
            value: gtt,
          ),

        if (gtt && widget.selectedMarket != "Intraday")
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
                  child: GttFields(
                    width: 150,
                    controller: stopLossPercentController,
                    label: "Stoploss %",

                    onToggle: () {},
                    onChange: (value) {},
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: GttFields(
                    width: 150,
                    controller: targetPercentController,
                    label: "Target %",

                    onToggle: () {},
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
          ),

        SizedBox(height: 20),

        CustomSwitchTile(
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
            InkWell(
              onTap: () {
                setState(() {
                  isAdvancedOptionVisible = !isAdvancedOptionVisible;
                });
              },
              child: Row(
                children: [
                  Text("Adanced Options", style: TextStyle(color: Colors.blue)),
                  SizedBox(height: 10),
                  Icon(
                    isAdvancedOptionVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        if (isAdvancedOptionVisible) ValidityOptions(price: widget.price),
        SizedBox(height: 50),
      ],
    );
  }
}

class CustomSwitchTile extends StatelessWidget {
  const CustomSwitchTile({
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
