import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/widgets/default_button_widget.dart';
import 'package:todo_list_app/features/board/presentation/widgets/all_tasks.dart';
import 'package:todo_list_app/features/board/presentation/widgets/completed_tasks.dart';
import 'package:todo_list_app/features/board/presentation/widgets/favorite_tasks.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/features/board/presentation/widgets/uncompleted_tasks.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Board",
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.calendar_month_outlined,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/schedule_page');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.brightness_4_outlined,
              ),
              onPressed: () {
                AppCubit.get(context).changeThemeMode();
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            onTap: (index) {},
            tabs: const [
              Tab(
                child: Text(
                  'All',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Uncompleted',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Favorite',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 500,
              child: TabBarView(
                children: [
                  AllTasksPage(),
                  CompletedTasksPage(),
                  UncompletedTasksPage(),
                  FavoriteTasksPage(),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DefaultButtonWidget(
                  text: 'Add a task',
                  onTap: () {
                    Navigator.pushNamed(context, '/add_task_page');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
