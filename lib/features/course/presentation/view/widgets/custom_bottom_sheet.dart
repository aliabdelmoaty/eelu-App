import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/core/widgets/divider.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:payment/features/course/presentation/view/widgets/grid_view_quality.dart';
import 'package:payment/features/course/presentation/view/widgets/row_download_or_cancel.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.cubit,
  });

  final CourseCubit cubit;

  @override
  Widget build(BuildContext context) {
    String? urlVideo;
    return SizedBox(
      height: 210.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.center, child: DividerBottomSheet()),
            SizedBox(
              height: 5.h,
            ),
            Text(
              cubit.nameVideo!,
              style: Styles.textStyle16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 5.h,
            ),
            const Text(
              'Choose video quality',
              style: Styles.textStyle16,
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: GridViewQuality(
                cubit: cubit,
                urlVideo: (String? v) {
                  urlVideo = v!;
                },
              ),
            ),
            RowDownloadOrCancel(
              onPressed: () {
                if (urlVideo == null) {
                  return;
                } else {
                  cubit.downloadVideo(
                    urlController: urlVideo!,
                  );
                }
                GoRouter.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
