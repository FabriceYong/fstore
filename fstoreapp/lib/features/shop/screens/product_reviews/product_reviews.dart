import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/products/ratings/product_rating.dart';
import 'package:fstoreapp/features/shop/screens/product_reviews/widgets/overall_product_rating.dart';
import 'package:fstoreapp/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FAppBar(
        title: Text('Reviews & Ratings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that you use'),
              const Gap(FSizes.spaceBtwItems),

              /// Overall Product Ratings
              const FOverallProductRating(),

              const FRatingIndicator(
                rating: 4.5,
              ),
              const Gap(FSizes.sm * 0.7),
              Text(
                '12,456',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Gap(FSizes.spaceBtwSections / 2),

              /// User Reviews List
              const FUserReviewCard(),
              const FUserReviewCard(),
              const FUserReviewCard(),
              const FUserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
