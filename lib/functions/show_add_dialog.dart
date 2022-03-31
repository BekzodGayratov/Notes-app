import 'package:flutter/material.dart';
import 'package:notes/components/my_text_form.dart';
import 'package:notes/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/services/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;

showMyDialog(BuildContext ctx, TextEditingController controllerName,
    TextEditingController controllerTask) {
  return showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: const Text("Xabarnoma qo'shing"),
      content: Column(
        children: [
          MyTextForm(controller: controllerName, hintText: "Ismingiz"),
          MyTextForm(controller: controllerTask, hintText: "Vazifangiz"),
        ],
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
           
            ctx.read<HomeCubit>().addToBox({
              "name": controllerName.text,
              "task": controllerTask.text,
              "time": DateTime.now().hour.toString() +
                  ":" +
                  DateTime.now().minute.toString()
            });
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
