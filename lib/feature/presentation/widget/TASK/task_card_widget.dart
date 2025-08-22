import 'package:eyot/feature/dashboard/domain/entities/category_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final CategoryEntity category;
  final bool isExpanded;

  const TaskCard({
    super.key,
    required this.task,
    required this.category,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: ClipRect(
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 10),
                blurRadius: 4,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title,
                  style: GoogleFonts.kayPhoDu(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(
                'Category: ${category.namaCategory}',
                style: GoogleFonts.kayPhoDu(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 4),
              Text(
                'Remind at: ${DateFormat("dd-MM-yyyy").format(task.remindAt)}',
                style: GoogleFonts.kayPhoDu(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              if (isExpanded) ...[
                SizedBox(height: 4),
                Text(
                  'Priority: ${task.priority}',
                  style: GoogleFonts.kayPhoDu(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Time: ${DateFormat("HH:mm").format(task.remindAt)}',
                  style: GoogleFonts.kayPhoDu(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Note : ${task.note}',
                  style: GoogleFonts.kayPhoDu(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
