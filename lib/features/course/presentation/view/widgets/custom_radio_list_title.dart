import 'package:flutter/material.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';

class CustomRadioListTitle extends StatelessWidget {
  const CustomRadioListTitle({
    super.key,
    required this.qualityText,
    required this.cubit,
    required this.index,
    required this.selectedQuality,
    required this.onChanged, required this.url,
  });

  final String qualityText;
  final CourseCubit cubit;
  final int index;
  final String? selectedQuality;
  final Function(String?) onChanged;
  final Function(String?) url;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: qualityText,
      activeColor: ColorsApp.blue,
      groupValue: selectedQuality,
      title: Text(
        qualityText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onChanged: (value) {
        String urlVideo= cubit.videoQualities[index].url.toString();
        onChanged(value);
        url(urlVideo);
        
      },
    );
  }
}
