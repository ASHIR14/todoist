import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/core/widgets/shimmer_widget.dart';

class KanbanBoardShimmer extends StatelessWidget {
  const KanbanBoardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => const TaskShimmer(),
    );
  }
}

class TaskShimmer extends StatelessWidget {
  const TaskShimmer({super.key});

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(height: 20.h, width: 100.w),
              SizedBox(height: 8.h),
              ShimmerWidget(height: 15.h, width: 200.w),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget(width: 60.w),
              ShimmerWidget(width: 60.w),
              ShimmerWidget(width: 60.w),
            ],
          ),
        ],
      ),
    );
  }
}
