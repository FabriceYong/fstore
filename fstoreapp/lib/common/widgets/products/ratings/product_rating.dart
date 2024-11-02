import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class FRatingIndicator extends StatelessWidget {
  const FRatingIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: FColors.grey,
      itemBuilder: (_, __) => const Icon(
        Iconsax.star1,
        color: FColors.primary,
      ),
    );
  }
}
