import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todoist/core/model/task.dart';
import 'package:todoist/core/widgets/task_card/comment_button.dart';
import 'package:todoist/core/widgets/task_card/edit_button.dart';
import 'package:todoist/core/widgets/task_card/move_button.dart';
import 'package:todoist/core/widgets/task_card/paly_pause_button.dart';
import 'package:todoist/utils/enum/task_status.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    required this.onEdit,
    required this.onComment,
    this.onMoveBackward,
    this.onMoveForward,
    this.onPlayPause,
    this.isPlay = false,
    super.key,
  });

  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onComment;
  final VoidCallback? onMoveBackward;
  final VoidCallback? onMoveForward;
  final VoidCallback? onPlayPause;
  final bool isPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.content,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (task.description.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      task.description,
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
              SizedBox(width: 10.w),
              if (task.status == TaskStatus.inProgress) ...[
                PlayPauseButton(
                  onTap: onPlayPause,
                  isPlay: isPlay,
                ),
              ],
            ],
          ),
          if (task.duration.amount > 0) ...[
            SizedBox(height: 10.h),
            Text(
              "Time spent: ${task.duration}",
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
          if (task.status == TaskStatus.completed) ...[
            SizedBox(height: 10.h),
            Text(
              "Completed on: ${DateFormat('dd MMM yyyy').format(DateTime.parse(task.due.datetime))}",
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
          SizedBox(height: 10.h),
          const Divider(),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EditButton(onTap: onEdit),
              const Spacer(),
              CommentButton(commentCount: task.commentCount, onTap: onComment),
              const Spacer(),
              if (onMoveBackward != null)
                MoveButton(onTap: onMoveBackward, isForward: false),
              if (onMoveForward != null) ...[
                SizedBox(width: 10.w),
                MoveButton(onTap: onMoveForward),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
