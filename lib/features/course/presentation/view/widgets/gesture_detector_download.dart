import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/widgets/custom_expansion_tile.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:payment/features/course/presentation/view/widgets/custom_bottom_sheet.dart';

class GestureDetectorDownload extends StatelessWidget {
  const GestureDetectorDownload(
      {super.key, required this.widget, required this.item, this.cubit});
  final CustomExpansionTile widget;
  final String item;
  final CourseCubit? cubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.text == 'Videos') {
          showDialogDownload(
              context, widget.title![widget.items!.indexOf(item)].toString(),
              () {
            GoRouter.of(context).pop();
            cubit!
                .analyzeVideo(
                    urlController: widget.url![widget.items!.indexOf(item)])
                .then((value) {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      cubit: cubit!,
                    );
                  });
            });
          });
        } else {
          showDialogDownload(
            context,
            widget.title![widget.items!.indexOf(item)].toString(),
            () {
              GoRouter.of(context).pop();
              cubit
                  ?.getPdfNameFromUrl(
                widget.url![widget.items!.indexOf(item)],
              )
                  .then((value) {
                cubit?.downloadPdf(
                  urlController: widget.url![widget.items!.indexOf(item)],
                );
              });
            },
          );
        }
      },
      child: const Icon(
        Icons.file_download_outlined,
         color: ColorsApp.blue
        // size: 24.r,
      ),
    );
  }

  Future<dynamic> showDialogDownload(
      BuildContext context, String name, Function()? onPressed) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Download'),
              content: Text('Do you want to download this $name?'),
              actions: [
                TextButton(onPressed: onPressed, child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text('No')),
              ],
            ));
  }
}
