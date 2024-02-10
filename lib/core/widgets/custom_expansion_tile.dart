import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/constant.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/course/presentation/view/widgets/gesture_detector_download.dart';
import 'package:payment/features/course/presentation/view/widgets/gesture_detector_show.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.items,
    required this.text,
    this.url,
    this.title,
    this.cubit,
    this.onTap,
    this.nameCourse,
  });
  final List<String>? items;
  final String text;
  final List<String>? url;
  final List<String>? title;
  final CourseCubit? cubit;
  final Function()? onTap;
  final String? nameCourse;

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
      trailing: SizedBox(
        width: 60.w,
        child: Row(
          children: [
            if (admin == true)
              GestureDetector(
                onTap: widget.onTap,
                child: Icon(Icons.add_circle_outline_outlined,
                    color: _customTileExpanded ? ColorsApp.blue : Colors.white),
              ),
            Spacer(),
            Icon(
              _customTileExpanded
                  ? Icons.expand_less_outlined
                  : Icons.expand_more_outlined,
              color: _customTileExpanded ? ColorsApp.blue : Colors.white,
            ),
          ],
        ),
      ),
      children: <Widget>[
        for (var item in widget.items!)
          ListTile(
            title: Text(item,
                style: Styles.textStyle16.copyWith(color: ColorsApp.blue)),
            trailing: SizedBox(
              width: 80.w,
              child: Row(
                children: [
                  GestureDetectorShow(widget: widget, item: item, cubit: cubit),
                  Spacer(),
                  GestureDetectorDownload(
                      widget: widget, item: item, cubit: cubit),
                  Spacer(),
                  if (admin == true)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.text == 'Lectures')
                              cubit!.delete(
                                  title: item,
                                  pdf: true,
                                  nameCourse: widget.nameCourse,
                                  nameDelete: 'lectures');
                            else if (widget.text == 'Videos')
                              cubit!.delete(
                                  title: item,
                                  nameCourse: widget.nameCourse,
                                  nameDelete: 'videos');
                            print(item);
                            print(widget.nameCourse);
                          },
                          child: Icon(Icons.delete_outline_outlined,
                              color: ColorsApp.blue),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
}
