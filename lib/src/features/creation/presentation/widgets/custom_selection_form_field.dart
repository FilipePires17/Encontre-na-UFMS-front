import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_text_form_field.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';

class CustomSelectionFormField<T> extends StatefulWidget {
  final String? title;
  final String? initialValue;
  final List<T> selectionOptions;
  final TextEditingController? controller;
  final bool isEnabled;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomSelectionFormField({
    super.key,
    this.title,
    required this.selectionOptions,
    this.initialValue,
    this.isEnabled = true,
    this.onSaved,
    this.controller,
    this.validator,
  });

  @override
  State<CustomSelectionFormField> createState() =>
      _CustomSelectionFormFieldState();
}

class _CustomSelectionFormFieldState<T>
    extends State<CustomSelectionFormField<T>> {
  bool isOnFocus = false;
  Widget currentIcon = const Icon(Icons.keyboard_arrow_down);
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue ?? '');
  }

  void _onTap() {
    setState(() {
      isOnFocus = !isOnFocus;
    });
  }

  void _onSelect(T selectedFunction) {
    setState(() {
      controller.text = selectedFunction.toString();
      isOnFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = widget.controller ?? controller;
    return Column(
      children: [
        CustomTextFormField(
          labelText: widget.title,
          isReadOnly: true,
          suffixIcon: widget.isEnabled
              ? isOnFocus
                  ? const Icon(Icons.keyboard_arrow_up)
                  : const Icon(Icons.keyboard_arrow_down)
              : null,
          onTap: _onTap,
          controller: controller,
          onSaved: widget.onSaved,
          validator: widget.validator,
        ),
        if (isOnFocus && widget.selectionOptions.isNotEmpty)
          Material(
            color: AppColors.charcoalGrey,
            borderRadius: const BorderRadius.all(Radius.circular(Sizes.p8)),
            elevation: Sizes.p4,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .25,
                maxWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListItem(
                      onTap: () {
                        _onSelect(widget.selectionOptions[index]);
                      },
                      title: widget.selectionOptions[index]!.toString(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: Sizes.p10,
                      color: AppColors.grey,
                    );
                  },
                  itemCount: widget.selectionOptions.length,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const ListItem({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        height: Sizes.p32,
        child: Text(title, style: const TextStyle(color: AppColors.white)),
      ),
    );
  }
}
