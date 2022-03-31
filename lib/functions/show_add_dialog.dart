import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:notes/components/my_text_form.dart';
import 'package:notes/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showMyDialog(BuildContext ctx, TextEditingController controllerTitle,
    TextEditingController controllerTask, GlobalKey<FormState> formKey) {
  return showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: const Text("Xabarnoma qo'shing"),
      content: Form(
        key: formKey,
        child: Column(
          children: [
            MyTextForm(
              controller: controllerTitle,
              hintText: "Sarlavha",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            MyTextForm(
              controller: controllerTask,
              hintText: "Vazifangiz",
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Orqaga")),
        ElevatedButton(
          child: const Text("Tasdiqlash"),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ctx.read<HomeCubit>().addToBox({
                "title": controllerTitle.text,
                "task": controllerTask.text,
                "time": DateTime.now().hour.toString() +
                    ":" +
                    DateTime.now().minute.toString()
              });
              Navigator.pop(context);
              FlutterToastr.show("Eslatma muvoffaqqiyatli o'rnatildi", context,
                  duration: 4);
            }
          },
        ),
      ],
    ),
  );
}
