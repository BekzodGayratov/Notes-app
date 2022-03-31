import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/routes/my_router.dart';
import 'package:notes/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Hive.initFlutter();
  await Hive.openBox<Map>("box");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _myRouter = MyRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: _myRouter.onGenerate,
    );
  }
}
