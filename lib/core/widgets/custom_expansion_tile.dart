import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.items,
    required this.text,
  });
  final List<String>? items;
  final String text;
  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
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
                      // GoRouter.of(context).push(AppRouter.login);
                    },
                    child: const Icon(
                      Icons.visibility_outlined,
                      // size: 24.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      showDialogDownload(context);
                      // GoRouter.of(context).push(AppRouter.login);
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

  Future<dynamic> showDialogDownload(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Download'),
              content: const Text('Do you want to download this file?'),
              actions: [
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text('No')),
              ],
            ));
  }
}
