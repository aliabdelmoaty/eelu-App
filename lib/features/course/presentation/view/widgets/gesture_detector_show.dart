import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/widgets/custom_expansion_tile.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';

class GestureDetectorShow extends StatelessWidget {
  const GestureDetectorShow({
    super.key,
    required this.widget,
    required this.item,
    required this.cubit,
  });

  final CustomExpansionTile widget;
  final String item;
  final CourseCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.text == 'Videos') {
          GoRouter.of(context).push(AppRouter.video, extra: {
            'title': widget.title?[widget.items!.indexOf(item)],
            'urlVideo': widget.url?[widget.items!.indexOf(item)],
            'cubit': cubit
          });
        } else {
          GoRouter.of(context).push(AppRouter.pdfView, extra: {
            'title': widget.title?[widget.items!.indexOf(item)],
            'linkPdf': widget.url?[widget.items!.indexOf(item)],
            'cubit': cubit
          });
        }
      },
      child: const Icon(Icons.visibility_outlined, color: ColorsApp.blue
          ),
    );
  }
}
