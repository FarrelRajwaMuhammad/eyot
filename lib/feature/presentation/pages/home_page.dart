import 'dart:async';

import 'package:eyot/core/material/color_material.dart';
import 'package:eyot/feature/dashboard/data/datasource/remote_datasource.dart';
import 'package:eyot/feature/dashboard/data/repository/remote_repository.dart';
import 'package:eyot/feature/dashboard/domain/entities/category_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/usecase/remote_repository.dart';
import 'package:eyot/feature/presentation/controller/home_controller.dart';
import 'package:eyot/feature/presentation/widget/Task/task_card_widget.dart';
import 'package:eyot/feature/presentation/widget/background_widget.dart';
import 'package:eyot/feature/presentation/widget/TASK/modal_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formattedServerDate = '';
  Timer? _countdownTimer;
  int? selectedTaskIndex;

  @override
  void initState() {
    super.initState();
    fetchServerDate();
    final remoteDatasource =
        RemoteDatasourceImpl(client: Supabase.instance.client);
    final repository = TaskRepositoryImpl(remoteDatasource);
    final usecase = taskUseCase(repository: repository);

    Get.put(HomeController(TaskUseCase: usecase));
    startCountdownUpdater();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchServerDate() async {
    final response =
        await Supabase.instance.client.rpc('get_server_time').execute();
    if (response.status == 200 && response.data != null) {
      final serverDate = DateTime.parse(response.data);
      final formatted = DateFormat('dd MMMM yyyy - EEEE').format(serverDate);

      setState(() {
        formattedServerDate = formatted;
      });
    } else {
      setState(() {
        formattedServerDate = 'Failed to load date';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'E.Y.O.T',
                        style: GoogleFonts.kayPhoDu(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_active),
                    )
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  formattedServerDate.isEmpty
                      ? 'Loading...'
                      : formattedServerDate,
                  style: GoogleFonts.kayPhoDu(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Search',
                        style: GoogleFonts.kayPhoDu(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterChip('Task', () {
                      print('Progress clicked');
                    }),
                    _buildFilterChip('Meetings', () {
                      print('Meetings clicked');
                    }),
                    _buildFilterChip('Goals', () {
                      print('Goals clicked');
                    }),
                  ],
                ),
                SizedBox(height: 24),
                Expanded(
                  child: Obx(() {
                    final controller = Get.find<HomeController>();

                    return ListView.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.tasks[index];
                        if (controller.category.isEmpty)
                          return CircularProgressIndicator();

                        final taskCategory = controller.category.firstWhere(
                          (c) => c.CategoryId == task.CategoryId,
                          orElse: () => CategoryEntity(
                              CategoryId: 0, namaCategory: 'Unknown'),
                        );

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedTaskIndex == index) {
                                selectedTaskIndex = null;
                              } else {
                                selectedTaskIndex = index;
                              }
                            });
                          },
                          child: TaskCard(
                            key: ValueKey("${task.title}_$index"),
                            task: task,
                            category: taskCategory,
                            isExpanded: selectedTaskIndex == index,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {
            controller.clearFields();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  child: FractionallySizedBox(
                    heightFactor: 0.7,
                    child: ModalBottomSheet(),
                  ),
                );
              },
            );
          },
          backgroundColor: blueBird,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 4,
            )
          ],
        ),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void startCountdownUpdater() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
  }
}
