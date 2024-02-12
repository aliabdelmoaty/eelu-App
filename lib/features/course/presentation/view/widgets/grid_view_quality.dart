import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:payment/features/course/presentation/view/widgets/custom_radio_list_title.dart';

class GridViewQuality extends StatefulWidget {
  const GridViewQuality(
      {super.key, required this.cubit, required this.urlVideo});
  final CourseCubit cubit;
  final Function(String?) urlVideo;

  @override
  State<GridViewQuality> createState() => _GridViewQualityState();
}

class _GridViewQualityState extends State<GridViewQuality> {
  String? _selectedQuality = '';
  @override
  Widget build(BuildContext context) {
    var cubit = widget.cubit;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2.5.r,
      crossAxisSpacing: 5.0.h,
      mainAxisSpacing: 5.0.w,
      children: List.generate(cubit.videoQualities.length, (index) {
        List<String> text = cubit.videoQualities[index].toString().split(" | ");
        String qualityText = text.length > 1 ? text[1].trim() : "";

        return CustomRadioListTitle(
          qualityText: qualityText,
          index: index,
          cubit: cubit,
          onChanged: (v) {
            setState(() {
              _selectedQuality = v;
            });
          },
          selectedQuality: _selectedQuality,
          url: (url) {
            setState(() {
              widget.urlVideo(url);
            });
          },
          size: cubit.sizes[index],
        );
      }),
    );
  }
}
