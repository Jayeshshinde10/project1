import 'package:flutter/material.dart';

class ValidityOptions extends StatefulWidget {
  final double price;
  const ValidityOptions({super.key, required this.price});

  @override
  State<ValidityOptions> createState() => _ValidityOptionsState();
}

class _ValidityOptionsState extends State<ValidityOptions> {
  int selected = 0;
  late TextEditingController disClosedQty;

  @override
  void initState() {
    super.initState();
    disClosedQty = TextEditingController(text: "0");
  }

  int selectedMinutes = 1;

  final List<int> minuteOptions = [1, 2, 3, 5, 10, 15, 30, 45, 60, 90, 120];

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
                      color: selected == 0 ? Colors.blue : Colors.grey.shade200,
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
                      color: selected == 1 ? Colors.blue : Colors.grey.shade200,
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
              Container(
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected == 2
                        ? Colors.blue
                        : Colors.grey.shade200, // Border color
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ButtonTheme(
                  padding: EdgeInsets.all(0),
                  alignedDropdown: true, // Aligns dropdown menu with button
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isDense: true, // Reduces the default height
                      items: minuteOptions.map((e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: Text(e == 1 ? "$e Minute" : "$e Minutes"),
                        );
                      }).toList(),
                      icon: SizedBox(),
                      hint: Text(
                        "Minutes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected == 2 ? Colors.blue : Colors.black,
                        ),
                      ),
                      onChanged: (value) {
                        selectedMinutes = value!;
                        selected = 2;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
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
                    child: TextFormField(
                      readOnly: selected == 1,
                      controller: disClosedQty,
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
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey.shade500,
                        width: 1.5,
                      ),
                    ),
                    height: 45,
                    width: 100,
                    child: selected == 2
                        ? Text(
                            selectedMinutes == 1
                                ? "$selectedMinutes Minute"
                                : "$selectedMinutes Minute",
                            style: TextStyle(color: Colors.black),
                          )
                        : SizedBox(),
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
