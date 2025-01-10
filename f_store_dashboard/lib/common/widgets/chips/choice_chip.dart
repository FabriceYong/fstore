import 'package:f_store_dashboard/common/widgets/containers/circular_container.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FChoiceChip extends StatelessWidget {
  const FChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = FHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? FColors.white : null),
        avatar: isColor
            ? FCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: FHelperFunctions.getColor(text)!,
              )
            : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        selectedColor: isColor ? FHelperFunctions.getColor(text) : null,
        // Make Icon in the center
        shape: isColor ? const CircleBorder() : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor ? FHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
