import 'package:flutter/material.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';

class RowDownloadOrCancel extends StatelessWidget {
  const RowDownloadOrCancel({
    super.key, this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: onPressed,
            child: Text('Download',
                style: Styles.textStyle16.copyWith(color: ColorsApp.blue))),
        const Spacer(),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('cancel',
                style: Styles.textStyle16.copyWith(color: ColorsApp.blue)))
      ],
    );
  }
}
