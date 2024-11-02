import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/products/ratings/product_rating.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

class FUserReviewCard extends StatelessWidget {
  const FUserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(FImages.userProfileImage1),
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text('James Bond',
                    style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2),

        /// Review
        Row(
          children: [
            const FRatingIndicator(rating: 4.3),
            const Gap(FSizes.spaceBtwItems / 2),
            Text(
              '02 Nov, 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Gap(FSizes.spaceBtwItems / 2),
        const ReadMoreText(
          'The User interface of the app is quite intuitive. I was able to navigate and make purchages seamlesly. Great job!',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show more',
          trimCollapsedText: ' show less',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const Gap(FSizes.spaceBtwItems / 2),

        /// Company Reply
        Padding(
          padding: const EdgeInsets.only(left: FSizes.defaultSpace / 2),
          child: FRoundedContainer(
            backgroundColor: dark ? FColors.darkerGrey : FColors.grey,
            child: Padding(
              padding: const EdgeInsets.all(FSizes.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'F\'s Store',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '02 Nov, 2023',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  const ReadMoreText(
                    'The User interface of the app is quite intuitive. I was able to navigate and make purchages seamlesly. Great job!',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' show more',
                    trimCollapsedText: ' show less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections / 2)
      ],
    );
  }
}
