import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/common_widgets/dialog_modal.dart';
import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../multimedia/data/dtos/multimedia_dto.dart';

class ImagePickerModal extends StatelessWidget {
  const ImagePickerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogModal(
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.p16),
            topRight: Radius.circular(Sizes.p16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.backgroundWhite,
              ),
            ),
            const Text(
              'Adicionar Imagem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundWhite,
              ),
              textAlign: TextAlign.center,
            ),
            gapW24,
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _openImage(context, ImageSource.gallery);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Galeria',
                  style: TextStyle(
                    color: AppColors.defaultBorder,
                  ),
                ),
                Icon(
                  Icons.photo,
                  color: AppColors.defaultBorder,
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.primary,
            thickness: 2,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _openImage(context, ImageSource.camera);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Câmera',
                  style: TextStyle(
                    color: AppColors.defaultBorder,
                  ),
                ),
                Icon(
                  Icons.camera_alt,
                  color: AppColors.defaultBorder,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openImage(BuildContext context, ImageSource source) async {
    final ctx = Navigator.of(context);
    try {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
      );

      if (context.mounted && pickedFile != null) {
        final file = File(pickedFile.path);
        final uintlist = await file.readAsBytes();
        final byteArray = base64Encode(uintlist);

        ctx.pop(
          MultimediaDto.fromMap({
            'data': base64.decode(byteArray),
            'name': pickedFile.name.isEmpty
                ? DateTime.now().toIso8601String()
                : pickedFile.name,
          }),
        );
        return;
      }
    } catch (e) {
      debugPrint('Error opening image: $e');
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    ctx.pop();
  }
}
