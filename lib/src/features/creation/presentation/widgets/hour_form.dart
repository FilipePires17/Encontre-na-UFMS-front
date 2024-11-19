import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_text_form_field.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/utils/app_masks.dart';
import '../../../../core/utils/app_validators.dart';

class HourForm extends StatelessWidget {
  const HourForm({
    super.key,
    required this.title,
    this.onSaved,
    required this.controller,
    this.initialValue,
  });

  final String title;
  final Function(String?)? onSaved;
  final TextEditingController controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    String? end;
    if (initialValue != null && initialValue!.contains('-')) {
      final start = initialValue!.split(' - ')[0];
      end = initialValue!.split(' - ')[1];
      controller.text = start;
    }
    return Row(
      children: [
        Text(title),
        gapW12,
        SizedBox(
          width: 92,
          child: CustomTextFormField(
            labelText: 'HH:MM',
            validator: AppValidators.hourValidator,
            controller: controller,
            inputFormatters: [AppMasks.timeMask],
            keyboardType: TextInputType.number,
          ),
        ),
        gapW12,
        const Text('até'),
        gapW12,
        SizedBox(
          width: 92,
          child: CustomTextFormField(
            initialValue: end,
            labelText: 'HH:MM',
            validator: AppValidators.hourValidator,
            onSaved: onSaved,
            inputFormatters: [AppMasks.timeMask],
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
