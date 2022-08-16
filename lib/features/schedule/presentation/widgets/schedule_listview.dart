import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/constants/strings.dart';
import 'package:todo_list_app/core/util/widgets/no_tasks_widget.dart';
import 'package:todo_list_app/features/schedule/presentation/widgets/task_schedule_item.dart';

class ScheduleListView extends StatelessWidget {
  const ScheduleListView({super.key});

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
                child: AppCubit.get(context).scheduleTasks.isEmpty
                    ? const NoTasksWidget()
                    : RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (AppCubit.get(context).scheduleTasks[index]
                                    ['date'] ==
                                datetime) {
                              return TaskScheduleItem(
                                item:
                                    AppCubit.get(context).scheduleTasks[index],
                              );
                            } else {
                              return Container();
                            }
                          },
                          separatorBuilder: (context, index) => Container(),
                          itemCount: AppCubit.get(context).scheduleTasks.length,
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
