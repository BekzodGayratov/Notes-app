import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/home_cubit.dart';
import 'package:notes/cubit/home_state.dart';
import 'package:notes/functions/show_add_dialog.dart';
import 'package:notes/services/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controllerTitle = TextEditingController();
  final _controllerTask = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit(), child: myScaffold(context));
  }

  myScaffold(context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, stae) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Notice app"),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      child: ListTile(
                        leading: Text(index.toString()),
                        title: Text(context
                            .watch<HomeCubit>()
                            .myBox!
                            .getAt(index)!["title"]),
                        subtitle: Text(
                          context
                              .watch<HomeCubit>()
                              .myBox!
                              .getAt(index)!["task"],
                        ),
                        trailing: Text(context
                            .watch<HomeCubit>()
                            .myBox!
                            .getAt(index)!["time"]),
                      ),
                      onDismissed: (v) async {
                        context.read<HomeCubit>().deleteDataFromBox(index);
                        await NotificationService().showNotification(
                          id: index,
                          title: "Bildirishnoma: $index",
                          body: "Eslatma o'chirib tashlandi",
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.delete),
                              Icon(Icons.delete)
                            ]),
                      ),
                    );
                  },
                  itemCount: context.watch<HomeCubit>().myBox!.length,
                ),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              showMyDialog(context, _controllerTitle, _controllerTask,_formKey);
            },
          ),
        );
      },
    );
  }
}
