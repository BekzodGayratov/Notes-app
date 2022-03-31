import 'package:flutter/material.dart';
import 'package:notes/components/my_text_form.dart';
import 'package:notes/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/services/notification_service.dart';

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
          onPressed: () async{
              await NotificationService().showNotification(
                id: 1,
                title: controllerName.text,
                body: "siz ${controllerTask.text} qilishingiz kerak",
              );
            ctx.read<HomeCubit>().addToBox(
                {"name": controllerName.text, "task": controllerTask.text});
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
