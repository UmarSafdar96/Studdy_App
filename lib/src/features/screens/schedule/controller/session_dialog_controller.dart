// lib/features/planner/presentation/controllers/session_dialog_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/study_session_entity.dart';

class SessionDialogController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  var selectedSubject = ''.obs;
  // Change this line: Explicitly declare as Rx<Color>
  Rx<Color> selectedColor = Colors.blue.obs; // Or use Rx<Color>(Colors.blue);

  var selectedSessionDate = DateTime.now().obs;

  final List<Color> colors = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.teal
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with default color
    // This assignment is now valid because selectedColor is Rx<Color>
    selectedColor.value = colors.first;
    // Initialize with today's date, normalized to start of day
    selectedSessionDate.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  void initialize(StudySessionEntity? existingSession) {
    if (existingSession != null) {
      titleController.text = existingSession.title;
      subjectController.text = existingSession.subject;
      startTimeController.text = existingSession.startTime;
      endTimeController.text = existingSession.endTime;
      selectedSubject.value = existingSession.subject;
      // This assignment is now valid because existingSession.color is Color
      selectedColor.value = Color(existingSession.color.value);
      selectedSessionDate.value = existingSession.sessionDate;
    } else {
      clearFields();
    }
  }

  void clearFields() {
    titleController.clear();
    subjectController.clear();
    startTimeController.clear();
    endTimeController.clear();
    selectedSubject.value = '';
    // This assignment is now valid
    selectedColor.value = colors.first;
    selectedSessionDate.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedSessionDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedSessionDate.value) {
      selectedSessionDate.value = DateTime(picked.year, picked.month, picked.day);
    }
  }

  void pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final String formatted = picked.format(context);
      final endText = endTimeController.text;

      if (endText.isNotEmpty) {
        final endTime = _parseTime(endText);
        final startTime = _parseTime(formatted);

        if (startTime.isAfter(endTime)) {
          Get.snackbar("Invalid Time", "Start time must be before end time",
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }
      }

      startTimeController.text = formatted;
    }
  }


  void pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final String formatted = picked.format(context);
      final startText = startTimeController.text;

      if (startText.isNotEmpty) {
        final startTime = _parseTime(startText);
        final endTime = _parseTime(formatted);

        if (endTime.isBefore(startTime)) {
          Get.snackbar(
            'Timing Mismatch',
            'Your start time mismatch with end time',
            backgroundColor: Colors.red.shade100,
            colorText: Colors.red.shade800,
            snackPosition: SnackPosition.TOP, // This will give you the top position
          );
          return;
        }
      }

      endTimeController.text = formatted;
    }
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final format = TimeOfDayFormat.H_colon_mm; // Adaptable to locale
    final timeOfDay = TimeOfDay(
      hour: int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1].split(' ')[0]),
    );

    // Adjust for AM/PM if present
    if (time.toLowerCase().contains('pm') && timeOfDay.hour < 12) {
      return DateTime(now.year, now.month, now.day, timeOfDay.hour + 12, timeOfDay.minute);
    } else if (time.toLowerCase().contains('am') && timeOfDay.hour == 12) {
      return DateTime(now.year, now.month, now.day, 0, timeOfDay.minute);
    } else {
      return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    }
  }


}