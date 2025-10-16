import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.height = 100,
    this.quantity = 0,
    required this.width,
    required this.controller,
    required this.label,
    this.isDisabled = false,
    this.isQuantity = false,
    required this.onToggle,
    required this.onChange,
    this.isLimitSelected = true,
    this.toggleDisabled = false,
    this.editIcon,
  });
  final double height;
  final double width;
  final String label;
  final bool isDisabled;
  final bool isQuantity;
  final int quantity;
  final Function() onToggle;
  final Function(String value) onChange;
  final TextEditingController controller;
  final bool isLimitSelected;
  final bool toggleDisabled;
  final Widget? editIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,

      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.editIcon != null) widget.editIcon!,
              if (widget.isQuantity)
                Text(
                  " ${widget.quantity} QTY.",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChange,
              keyboardType: TextInputType.number,
              enabled: widget.isDisabled,
              onTapOutside: (event) {},
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
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
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
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.grey.shade300, width: 2),
                    ),
                  ),
                  child: IconButton(
                    disabledColor: Colors.grey.shade400,

                    onPressed: widget.toggleDisabled ? null : widget.onToggle,
                    icon: Icon(
                      Icons.swap_horiz,
                      color: widget.toggleDisabled
                          ? Colors.grey.shade400
                          : Colors.blue,
                    ),
                  ),
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
    );
  }
}
