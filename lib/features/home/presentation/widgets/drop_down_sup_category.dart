import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/stores_category_entites.dart';
import '../manger/select_category_cubit/select_category_cubit.dart';

class DropDownSubCategory extends StatelessWidget {
  const DropDownSubCategory({super.key, required this.onCategorySelected});
  final void Function(String?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCategoryCubit, StorsCategoryEntites?>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'الفئة الفرعية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: context.watch<SelectSubCategoryDropDownCubit>().state,
                hint: const Text(
                  'اختر الفئة الفرعية',
                  textDirection: TextDirection.rtl,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                items:
                    state?.subCategories!.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Text(category.name!),
                      );
                    }).toList(),
                onChanged: (value) {
                  onCategorySelected(value);

                  context.read<SelectSubCategoryDropDownCubit>().selectCategory(
                    value!,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
