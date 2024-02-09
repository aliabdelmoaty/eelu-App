import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:payment/features/course/presentation/view/widgets/custom_bottom_sheet.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.items,
    required this.text,
    this.url,
    this.title,
    this.cubit,
  });
  final List<String>? items;
  final String text;
  final List<String>? url;
  final List<String>? title;
  final CourseCubit? cubit;

  @override
  // ignore: library_private_types_in_public_api
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    var cubit = widget.cubit;
    return ExpansionTile(
      collapsedBackgroundColor: ColorsApp.blue,
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      childrenPadding: EdgeInsets.all(8.r),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      title: Text(widget.text,
          style: Styles.textStyle18.copyWith(
              color: _customTileExpanded ? ColorsApp.blue : Colors.white)),
      subtitle: Text('${widget.items!.length} ${widget.text} available',
          style: Styles.textStyle13.copyWith(
              color: _customTileExpanded ? ColorsApp.blue : Colors.white)),
      trailing: Icon(
        _customTileExpanded
            ? Icons.expand_less_outlined
            : Icons.expand_more_outlined,
        color: _customTileExpanded ? ColorsApp.blue : Colors.white,
      ),
      children: <Widget>[
        for (var item in widget.items!)
          ListTile(
            title: Text(item,
                style: Styles.textStyle16.copyWith(color: ColorsApp.blue)),
            trailing: SizedBox(
              width: 55.w,
              child: Row(
                children: [
                  GestureDetector(
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
                    child: const Icon(
                      Icons.visibility_outlined,
                      // size: 24.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      if (widget.text == 'Videos') {
                        showDialogDownload(
                            context,
                            widget.title![widget.items!.indexOf(item)]
                                .toString(), () {
                          GoRouter.of(context).pop();
                          cubit!
                              .analyzeVideo(
                                  urlController:
                                      widget.url![widget.items!.indexOf(item)])
                              .then((value) {
                            showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return CustomBottomSheet(
                                    cubit: cubit,
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
                              cubit.downloadPdf(
                                urlController:
                                    widget.url![widget.items!.indexOf(item)],
                              );
                            });
                          },
                        );
                      }
                    },
                    child: const Icon(
                      Icons.file_download_outlined,
                      // size: 24.r,
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
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
