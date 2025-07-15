// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../manger/select_category_cubit/select_category_cubit.dart';

class DropDownCategory extends StatelessWidget {
  const DropDownCategory({super.key, required this.onCategorySelected});
  final void Function(String?) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresCategoriesCubit, StoresCategoriesState>(
      builder: (context, state) {
        if (state is StoresCategoriesSuccess) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: context.watch<SelectCategoryDropDownCubit>().state,
                  hint: const Text(
                    'Category',
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
                      state.storesCategories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.name!),
                        );
                      }).toList(),
                  onChanged: (value) {
                    onCategorySelected(value);
                    context.read<SelectCategoryDropDownCubit>().selectCategory(
                      value!,
                    );
                    context
                        .read<SelectSubCategoryDropDownCubit>()
                        .selectCategory(null); // مسح قيمة الفئة الفرعية

                    context.read<SelectedCategoryCubit>().findSubCategoryById(
                      state.storesCategories,
                      value,
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
