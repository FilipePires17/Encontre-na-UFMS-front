import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes/app_sizes.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../multimedia/domain/entities/multimedia.dart';
import '../cubit/photos_cubit.dart';
import 'image_picker_modal.dart';
import 'multimedia_card.dart';

class ImagePickerField extends StatefulWidget {
  const ImagePickerField({super.key});

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  late final PhotosCubit photosCubit;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    photosCubit = BlocProvider.of<PhotosCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final pickedFile = await showDialog<Multimedia>(
              context: context,
              builder: (context) => const ImagePickerModal(),
            );
            if (pickedFile != null) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              photosCubit.addPhoto(pickedFile);
            }
          },
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: AppColors.lightGray,
              radius: const Radius.circular(Sizes.p10),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: Sizes.p32,
                      color: AppColors.lightGray,
                    ),
                    Text(
                      'Envie fotos do local aqui',
                      style: TextStyle(color: AppColors.lightGray),
                    ),
                    Text(
                      'Prefira fotos com o celular deitado (horizontal)',
                      style: TextStyle(
                        color: AppColors.lightGray,
                        fontSize: Sizes.p10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        gapH16,
        BlocBuilder<PhotosCubit, List<Multimedia>>(
          builder: (context, state) {
            return Text(
              'Enviando ${state.length} arquivos',
              style: const TextStyle(
                color: AppColors.backgroundWhite,
                fontSize: Sizes.p10,
              ),
            );
          },
        ),
        gapH8,
        SizedBox(
          height: Sizes.p60,
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Sizes.p8),
              child: BlocBuilder<PhotosCubit, List<Multimedia>>(
                builder: (context, state) {
                  return ListView.separated(
                    controller: scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => MultimediaCard(
                      multimedia: state[index].media!,
                      onTap: () {
                        photosCubit.removePhoto(index);
                      },
                    ),
                    separatorBuilder: (context, index) => gapW8,
                    itemCount: state.length,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
