import 'package:flutter/material.dart';
import 'package:todo_list_app/core/util/constants/colors.dart';
import 'package:todo_list_app/core/util/widgets/check_box_widget.dart';

class TaskScheduleItem extends StatelessWidget {
  final Map item;
  const TaskScheduleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: item['color'] == '0'
              ? redColor
              : item['color'] == '1'
                  ? orangeColor
                  : item['color'] == '2'
                      ? yellowColor
                      : item['color'] == '3'
                          ? blueColor
                          : redColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        '${item['start_time']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        ' - ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${item['end_time']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${item['title']}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            CheckBoxWidget(
              status: item['status'],
              id: item['id'],
              radius: 16.0,
              unselectedWidgetColor: Colors.white,
              activeColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
