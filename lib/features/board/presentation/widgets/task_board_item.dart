import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/blocs/app/cubit.dart';
import 'package:todo_list_app/core/util/constants/colors.dart';
import 'package:todo_list_app/core/util/widgets/check_box_widget.dart';
import 'package:todo_list_app/features/edit_task/presentation/widgets/edit_task_widget.dart';

enum PopUpMenu { favorite, edit, delete }

class TaskBoardItem extends StatelessWidget {
  final Map item;

  const TaskBoardItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        color:
            AppCubit.get(context).isDark ? Colors.white : Colors.grey.shade800,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(4),
          leading: CheckBoxWidget(
            status: item['status'],
            id: item['id'],
            radius: 5,
            activeColor: item['color'] == '0'
                ? redColor
                : item['color'] == '1'
                    ? orangeColor
                    : item['color'] == '2'
                        ? yellowColor
                        : item['color'] == '3'
                            ? blueColor
                            : redColor,
            unselectedWidgetColor: item['color'] == '0'
                ? redColor
                : item['color'] == '1'
                    ? orangeColor
                    : item['color'] == '2'
                        ? yellowColor
                        : item['color'] == '3'
                            ? blueColor
                            : redColor,
          ),
          title: Text(
            '${item['title']}',
            style: TextStyle(
              fontSize: 20,
              decoration: item['status'] == 'completed'
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: AppCubit.get(context).isDark
                  ? Colors.grey.shade600
                  : Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Text(
            '${item['description']}',
            style: TextStyle(
              fontSize: 16,
              decoration: item['status'] == 'completed'
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: AppCubit.get(context).isDark
                  ? Colors.grey.shade500
                  : Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: popupMenu(context),
        ),
      ),
    );
  }

  Widget popupMenu(BuildContext context) {
    return PopupMenuButton<PopUpMenu>(
      color: AppCubit.get(context).isDark ? Colors.white : Colors.grey.shade800,
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.favorite,
            child: Row(
              children: [
                item['status'] == 'favorite'
                    ? Icon(
                        Icons.favorite,
                        color: AppCubit.get(context).isDark
                            ? Colors.grey.shade500
                            : Colors.white,
                      )
                    : Icon(
                        Icons.favorite_border_outlined,
                        color: AppCubit.get(context).isDark
                            ? Colors.grey.shade500
                            : Colors.white,
                      ),
                const SizedBox(width: 10),
                Text(
                  'Favorite',
                  style: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey.shade500
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.edit,
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: AppCubit.get(context).isDark
                      ? Colors.grey.shade500
                      : Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey.shade500
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.delete,
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: AppCubit.get(context).isDark
                      ? Colors.grey.shade500
                      : Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey.shade500
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      onSelected: (PopUpMenu menu) {
        switch (menu) {
          case PopUpMenu.favorite:
            if (item['status'] != 'favorite') {
              AppCubit.get(context).updateTaskStatus(
                status: 'favorite',
                id: item['id'],
              );
            } else {
              AppCubit.get(context).updateTaskStatus(
                status: 'new',
                id: item['id'],
              );
            }
            break;
          case PopUpMenu.edit:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskWidget(
                  id: item['id'],
                  title: item['title'],
                  description: item['description'],
                  date: item['date'],
                  startTime: item['start_time'],
                  endTime: item['end_time'],
                  remind: item['remind'],
                  color: item['color'],
                ),
              ),
            );
            break;
          case PopUpMenu.delete:
            AppCubit.get(context).deleteTaskData(id: item['id']);
            break;
        }
      },
      icon: Icon(
        Icons.more_vert,
        color:
            AppCubit.get(context).isDark ? Colors.grey.shade500 : Colors.white,
      ),
    );
  }
}
