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
    this.showSuffixicon = true,
    this.editIcon,
    this.validator,
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
  final bool showSuffixicon;
  final Function(String value)? validator;

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
            child: TextFormField(
              validator: widget.validator == null
                  ? (value) {
                      if (value!.trim().isEmpty) {
                        return "Value Connot be less than zero";
                      }

                      if ((double.tryParse(value.trim()!) ?? 0) <= 0) {
                        return "Value Connot be less than zero";
                      }
                      return null;
                    }
                  : (value) {
                      return widget.validator!(value!);
                    },
              autovalidateMode: AutovalidateMode.always,

              controller: widget.controller,
              onChanged: widget.onChange,
              keyboardType: TextInputType.number,
              readOnly: widget.isDisabled,

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
                suffixIcon: widget.showSuffixicon
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                        ),
                        child: IconButton(
                          disabledColor: Colors.grey.shade400,

                          onPressed: widget.toggleDisabled
                              ? null
                              : widget.onToggle,
                          icon: Icon(
                            Icons.swap_horiz,
                            color: widget.toggleDisabled
                                ? Colors.grey.shade400
                                : Colors.blue,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
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
