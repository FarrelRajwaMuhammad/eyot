import 'package:eyot/feature/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalBottomSheet extends StatelessWidget {
  ModalBottomSheet({super.key});

  final controller = Get.find<HomeController>();
  final priorities = ['Low', 'Medium', 'High'];
  final categories = ['Skripsi', 'Tugas Kuliah', 'Inframe', 'Main Job'];

  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title Field
            const Text(
              "What do you need to do?",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter your task title",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.title.value = value,
            ),

            const SizedBox(height: 24),

            const Text("Category", style: TextStyle(color: Colors.black)),
            const SizedBox(height: 8),

            Obx(() => Wrap(
                  spacing: 8,
                  children: categories.map((cat) {
                    final selected = controller.category.value == cat;
                    return ChoiceChip(
                      label: Text(cat),
                      selected: selected,
                      onSelected: (_) => controller.category.value = cat,
                    );
                  }).toList(),
                )),

            const SizedBox(height: 24),
            const Text("Priority", style: TextStyle(color: Colors.black)),
            Obx(() => Column(
                  children: priorities.map((label) {
                    return Row(
                      children: [
                        Radio<String>(
                          value: label,
                          groupValue: controller.priority.value,
                          onChanged: (value) {
                            controller.priority.value = value!;
                          },
                        ),
                        Text(label),
                      ],
                    );
                  }).toList(),
                )),

            const SizedBox(height: 32),
            const Text("Set Date", style: TextStyle(color: Colors.black)),
            TextButton.icon(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.remindAt.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(controller.remindAt.value),
                  );

                  if (pickedTime != null) {
                    final combined = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    controller.remindAt.value = combined;
                  }
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Obx(() => Text(
                    "${controller.remindAt.value.toLocal()}".split('.')[0],
                  )),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recurring", style: TextStyle(color: Colors.black)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    final userId =
                        await controller.addTask(controller.userId.value);
                    controller.clearFields();
                  },
                  child: const Text("Save"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
