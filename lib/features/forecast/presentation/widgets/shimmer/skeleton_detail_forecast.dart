import 'package:flutter/material.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/shimmer/skeleton_widget.dart';

class SkeletonDetailForecast extends StatelessWidget {
  const SkeletonDetailForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        const SkeletonWidget(
          child: BannerPlaceholder(),
        ),
        SkeletonWidget(
          child: Container(
            width: 120.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
        ),
        SkeletonWidget(
          child: TitlePlaceholder(
            width: MediaQuery.of(context).size.width * 0.2,
          ),
        ),
        SkeletonWidget(
          child: TitlePlaceholder(
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
        const SkeletonWidget(
          child: ContentPlaceholder(
            lineType: ContentLineType.threeLines,
          ),
        ),
        const SkeletonWidget(
          child: BannerPlaceholder(),
        ),
        const SkeletonWidget(
          child: ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
        ),
      ],
    );
  }
}
