import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:flutter/material.dart';

class SortChips extends StatelessWidget{

  const SortChips({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ProductSort selected;
  final ValueChanged<ProductSort> onSelected;


@override
Widget build(BuildContext context) {
  const sorts = ProductSort.values;
  return SizedBox(
    height:  44,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: sorts.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8,),

      itemBuilder: (context,index){
        final sort = sorts[index];
        return ChoiceChip(label: Text(sort.label), selected: sort == selected,
          onSelected: (_)=> onSelected(sort),);
      }, ),
  );

}
}