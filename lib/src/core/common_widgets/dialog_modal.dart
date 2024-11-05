import 'package:flutter/material.dart';

import '../constants/sizes/app_sizes.dart';
import '../constants/theme/app_colors.dart';

class DialogModal extends AlertDialog {
  const DialogModal({
    super.key,
    super.titlePadding,
    super.title,
    super.content,
    super.contentPadding,
    super.actionsAlignment,
    super.actionsOverflowAlignment,
    super.actionsOverflowDirection,
    super.actionsPadding,
    super.actions,
  }) : super(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.p16),
            ),
          ),
          insetPadding: EdgeInsets.zero,
          backgroundColor: AppColors.backgroundWhite,
        );
}
