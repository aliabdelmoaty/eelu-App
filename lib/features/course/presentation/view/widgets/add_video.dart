import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';

class AddVideo extends StatelessWidget {
  AddVideo({
    Key? key,
    required this.cubit,
    this.nameCourse,
  }) : super(key: key);

  final CourseCubit cubit;
  final String? nameCourse;

  final TextEditingController urlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  static final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Video'),
      content: Form(
        key: form,
        child: SizedBox(
          width: 450.h,
          height: 158.h,
          child: Column(
            children: [
              TextFieldAdd(nameController: urlController, label: 'Enter url'),
              SizedBox(
                height: 10.h,
              ),
              TextFieldAdd(
                nameController: nameController,
                label: 'Enter the video name',
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ButtonAdd(
          onPressed: () {
            if (form.currentState!.validate()) {
              cubit
                  .add(
                nameCourse: nameCourse,
                nameUpdate: 'videos',
                url: urlController.text,
                title: nameController.text,
              )
                  .then((value) {
                GoRouter.of(context).pop();
              });
            }
          },
          text: 'add video',
        ),
        ButtonAdd(
          text: 'cancel',
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => ColorsApp.blue)),
        onPressed: onPressed,
        child: Text(
          text,
          style: Styles.textStyle18,
        ));
  }
}

class TextFieldAdd extends StatelessWidget {
  const TextFieldAdd({
    super.key,
    this.nameController,
    required this.label,
  });

  final TextEditingController? nameController;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter the $label';
        }
        return null;
      },
      controller: nameController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
      ),
    );
  }
}
