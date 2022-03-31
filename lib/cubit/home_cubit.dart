import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Box<Map>? myBox = Hive.box("box");
  HomeCubit() : super(HomeInitialState());

  void addToBox(Map<dynamic, dynamic> data) async {
    await myBox!.add(data);
    emit(HomeCompleteState());
  }

  void updateData(
    int index,
    Map<dynamic, dynamic> data,
  ) {
    myBox!.putAt(index, data);
    emit(HomeCompleteState());
  }

  void deleteDataFromBox(int index) {
    myBox!.deleteAt(index);
    emit(HomeCompleteState());
  }

  void clearBox() {
    myBox!.clear();
    emit(HomeCompleteState());
  }
}
