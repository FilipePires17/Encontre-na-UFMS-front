import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/sizes/app_sizes.dart';
import '../constants/theme/app_colors.dart';
import '../utils/app_converter.dart';

class CustomFormField extends StatefulWidget {
  final String? hintText;
  final String? initialValue;
  final bool isReadOnly;
  final bool isEnabled;
  final bool isDatePicker;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final bool hasSuffixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final double? height;
  final String? title;
  final String? suffixText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const CustomFormField({
    super.key,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.hasSuffixIcon = false,
    this.isDatePicker = false,
    this.keyboardType,
    this.initialValue,
    this.formatters,
    this.suffixIcon,
    this.onTap,
    this.onSaved,
    this.validator,
    this.title,
    this.suffixText,
    this.height = Sizes.p60,
    this.controller,
    this.hintText,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget? getSuffixIcon() {
    if (widget.isDatePicker) {
      return InkWell(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
            lastDate: DateTime(2101),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.primary,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            String formattedDate = AppConverter.dateFormatter(pickedDate);
            setState(() {
              _controller.text = formattedDate;
            });
          }
        },
        child: const Icon(
          Icons.calendar_month,
        ),
      );
    } else {
      if (widget.hasSuffixIcon) return widget.suffixIcon;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _controller = widget.controller ?? _controller;
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        controller: _controller,
        onTap: widget.onTap,
        onSaved: widget.onSaved,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.formatters,
        readOnly: widget.isReadOnly,
        enabled: widget.isEnabled,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(Sizes.p8),
          hintText: widget.hintText,
          suffixIcon: getSuffixIcon(),
          fillColor:
              widget.isEnabled ? AppColors.white : AppColors.backgroundGrey,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.p4),
            ),
          ),
        ),
      ),
    );
  }
}
