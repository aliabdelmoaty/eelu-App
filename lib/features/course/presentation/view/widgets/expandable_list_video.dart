import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/course/presentation/view/widgets/item_expanded_list.dart';

class ExpandableListVideos extends StatefulWidget {
  const ExpandableListVideos({super.key});

  @override
  State<ExpandableListVideos> createState() => _ExpandableListVideosState();
}

class _ExpandableListVideosState extends State<ExpandableListVideos> {
  bool isExpanded = false;
  List<String> videoNames = [
    'Video 1',
    'Video 2',
    'Video 3',
    'Video 4',
    'Video 5',
    'Video 6',
    'Video 7',
    'Video 8',
    'Video 9',
    'Video 10',
    'Video 1',
    'Video 2',
    'Video 3',
    'Video 4',
    'Video 5',
    'Video 6',
    'Video 7',
    'Video 8',
    'Video 9',
    'Video 10',
    'Video 1',
    'Video 2',
    'Video 3',
    'Video 4',
    'Video 5',
    'Video 6',
    'Video 7',
    'Video 8',
    'Video 9',
    'Video 10',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: ColorsApp.blue,
          child: ListTile(
            title: const Text(
              'Videos',
              style: Styles.textStyle18,
            ),
            trailing: IconButton(
              icon: Icon(isExpanded
                  ? Icons.expand_less_outlined
                  : Icons.expand_more_outlined),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
        ),
        if (isExpanded)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ItemExpandedList(text: videoNames[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: videoNames.length),
            ),
          ),
      ],
    );
  }
}
