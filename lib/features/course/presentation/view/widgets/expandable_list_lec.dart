import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/course/presentation/view/widgets/item_expanded_list.dart';

class ExpandableListLec extends StatefulWidget {
  const ExpandableListLec({super.key, required this.isExpandedLec});
  final bool isExpandedLec;

  @override
  _ExpandableListLecState createState() => _ExpandableListLecState();
}

class _ExpandableListLecState extends State<ExpandableListLec> {
  bool? isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpandedLec;
  }

  List<String> lectureNames = [
    'Lecture 1',
    'Lecture 2',
    'Lecture 3',
    'Lecture 4',
    'Lecture 5',
    'Lecture 6',
    'Lecture 7',
    'Lecture 8',
    'Lecture 9',
    'Lecture 10',
    'Lecture 1',
    'Lecture 2',
    'Lecture 3',
    'Lecture 4',
    'Lecture 5',
    'Lecture 6',
    'Lecture 7',
    'Lecture 8',
    'Lecture 9',
    'Lecture 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            color: ColorsApp.blue,
            child: ListTile(
              title: const Text(
                'Lectures',
                style: Styles.textStyle18,
              ),
              trailing: IconButton(
                icon: Icon(widget.isExpandedLec
                    ? Icons.expand_less_outlined
                    : Icons.expand_more_outlined),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    isExpanded = !widget.isExpandedLec; // Corrected line
                  });
                },
              ),
            )),
        if (widget.isExpandedLec)
          SizedBox(
            height: 400.h,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ItemExpandedList(text: lectureNames[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: lectureNames.length)),
          ),
      ],
    );
  }
}
