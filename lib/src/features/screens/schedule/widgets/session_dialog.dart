

// lib/features/planner/presentation/widgets/session_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../bloc/planner_bloc.dart';
import '../bloc/planner_event.dart';
import '../bloc/planner_state.dart';
import '../controller/session_dialog_controller.dart';
import '../models/study_session_entity.dart';




void showSessionDialog(BuildContext context, StudySessionEntity? existingSession) {
  final SessionDialogController dialogController = Get.put(SessionDialogController());
  dialogController.initialize(existingSession);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(existingSession == null ? 'Add Study Session' : 'Edit Study Session'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dialogController.titleController,
              decoration: InputDecoration(
                labelText: 'Session Title',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dialogController.subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            // Date Picker
            Obx(() => GestureDetector(
              onTap: () => dialogController.pickDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Session Date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  '${dialogController.selectedSessionDate.value.day}/${dialogController.selectedSessionDate.value.month}/${dialogController.selectedSessionDate.value.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )),
            const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => dialogController.pickStartTime(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dialogController.startTimeController,
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: const Icon(Icons.access_time),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () => dialogController.pickEndTime(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dialogController.endTimeController,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: const Icon(Icons.access_time),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
            const SizedBox(height: 16),
            // Color selection
            Obx(() => Row(
              children: [
                const Text('Color: '),
                const SizedBox(width: 8),
                ...dialogController.colors.map((color) => GestureDetector(
                  onTap: () => dialogController.selectedColor.value = color,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: dialogController.selectedColor.value == color
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                )).toList(),
              ],
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
           // Navigator.pop(context);
            Get.delete<SessionDialogController>(); // Clean up controller
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (dialogController.titleController.text.isNotEmpty) {
              final plannerBloc = Get.find<PlannerBloc>();
              final currentState = plannerBloc.state;

              if (currentState is PlannerLoaded) {
                final session = StudySessionEntity(
                  id: existingSession?.id ?? Uuid().v4(),
                  title: dialogController.titleController.text,
                  subject: dialogController.subjectController.text,
                  startTime: dialogController.startTimeController.text,
                  endTime: dialogController.endTimeController.text,
                  color: dialogController.selectedColor.value,
                  type: 'Study Session',
                  sessionDate: dialogController.selectedSessionDate.value, // <--- PASS THE SELECTED DATE
                );

                if (existingSession == null) {
                  plannerBloc.add(AddSessionEvent(session));
                } else {
                  plannerBloc.add(UpdateSessionEvent(session));
                }
              }
              Navigator.pop(context);
              Get.delete<SessionDialogController>(); // Clean up controller
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(existingSession == null ? 'Add' : 'Update'),
        ),
      ],
    ),
  );
}

