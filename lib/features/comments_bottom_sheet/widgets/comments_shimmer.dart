import 'package:flutter/material.dart';
import 'package:todoist/core/widgets/shimmer_widget.dart';

class CommentsShimmer extends StatelessWidget {
  const CommentsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 7,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => const ShimmerWidget(),
    );
  }
}
