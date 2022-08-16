import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/widgets/no_tasks_widget.dart';
import 'package:todo_list_app/features/board/presentation/widgets/task_board_item.dart';

class FavoriteTasksPage extends StatelessWidget {
  const FavoriteTasksPage({super.key});

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
                child: AppCubit.get(context).favoriteTasks.isEmpty
                    ? const NoTasksWidget()
                    : RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.separated(
                          itemBuilder: (context, index) => TaskBoardItem(
                            item: AppCubit.get(context).favoriteTasks[index],
                          ),
                          separatorBuilder: (context, index) => Container(),
                          itemCount: AppCubit.get(context).favoriteTasks.length,
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
