import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/util/blocs/app/app_cubit.dart';
import 'package:todo_list_app/core/util/widgets/no_tasks_widget.dart';
import 'package:todo_list_app/features/board/presentation/widgets/task_board_item.dart';

class UncompletedTasksPage extends StatelessWidget {
  const UncompletedTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: AppCubit.get(context).uncompletedTasks.isEmpty
                    ? const NoTasksWidget()
                    : RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.separated(
                          itemBuilder: (context, index) => TaskBoardItem(
                            item: AppCubit.get(context).uncompletedTasks[index],
                          ),
                          separatorBuilder: (context, index) => Container(),
                          itemCount:
                              AppCubit.get(context).uncompletedTasks.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
