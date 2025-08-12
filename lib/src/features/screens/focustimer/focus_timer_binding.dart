import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'bloc/focus_timer_bloc.dart';

class FocusTimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FocusTimerBloc>(() => FocusTimerBloc(Get.find<Dio>()));
  }
}



