import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/entities/stores_category_entites.dart';
import '../../../home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../../../home/presentation/manger/select_category_cubit/select_category_cubit.dart';
import '../manger/edit_my_store_cubit/edit_my_store_cubit.dart';
import '../manger/edit_select_category_cubit/edit_select_category_cubit.dart';
import '../manger/my_store_cubit/my_store_cubit.dart';

class EditCustomSelectCategories extends StatefulWidget {
  @override
  _EdiCustomSelectCategoriesState createState() =>
      _EdiCustomSelectCategoriesState();
}

class _EdiCustomSelectCategoriesState
    extends State<EditCustomSelectCategories> {
  @override
  Widget build(BuildContext context) {
    EditMyStoreCubit cEditStore = BlocProvider.of(context);

    return BlocBuilder<MyStoreCubit, MyStoreState>(
      builder: (context, state) {
        if (state is MyStoreSuccess) {
          final category = state.myStore.category;
          final supCategory = state.myStore.subCategory;
          final editSelectCategoryDropDownCubit =
              context.read<EditSelectCategoryDropDownCubit>();
          final editSelectSubCategoryDropDownCubit =
              context.read<EditSelectSubCategoryDropDownCubit>();

          // ترحيل البيانات مرة واحدة فقط
          Future.microtask(
            () => editSelectCategoryDropDownCubit.emit(category),
          );
          List<StorsCategoryEntites>? storesCategories =
              context.read<StoresCategoriesCubit>().getstoresCategories;

          Future.microtask(
            () => editSelectSubCategoryDropDownCubit.emit(supCategory),
          );

          var editMyStoreEntite =
              context.read<EditMyStoreCubit>().editMyStoreEntite;
          editMyStoreEntite.category = category;
          editMyStoreEntite.subCategory = supCategory;

          context.read<EditSelectedCategoryCubit>().findSubCategoryById(
            storesCategories!,
            category!,
          );
        }
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Dropdown
                SizedBox(height: 10),
                BlocBuilder<StoresCategoriesCubit, StoresCategoriesState>(
                  builder: (context, state) {
                    if (state is StoresCategoriesSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Main category',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value:
                                context
                                    .watch<EditSelectCategoryDropDownCubit>()
                                    .state,
                            hint: const Text(
                              'اختر الفئة الفرعية',
                              textDirection: TextDirection.rtl,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
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
                              cEditStore.editMyStoreEntite.category =
                                  value.toString();
                              cEditStore.editMyStoreEntite.subCategory = null;

                              //   onCategorySelected(value);
                              context
                                  .read<EditSelectCategoryDropDownCubit>()
                                  .selectCategory(value!);
                              context
                                  .read<EditSelectSubCategoryDropDownCubit>()
                                  .selectCategory(
                                    null,
                                  ); // مسح قيمة الفئة الفرعية

                              context
                                  .read<EditSelectedCategoryCubit>()
                                  .findSubCategoryById(
                                    state.storesCategories,
                                    value,
                                  );
                            },
                          ),
                        ],
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),

                SizedBox(height: 30),

                // SubCategory Dropdown
                Text(
                  'Select subcategory:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                BlocBuilder<EditSelectedCategoryCubit, StorsCategoryEntites?>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Subcategory',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value:
                              context
                                  .watch<EditSelectSubCategoryDropDownCubit>()
                                  .state,
                          hint: const Text(
                            'Select subcategory',
                            textDirection: TextDirection.rtl,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
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
                            //         onCategorySelected(value);
                            cEditStore.editMyStoreEntite.subCategory =
                                value.toString();
                            context
                                .read<EditSelectSubCategoryDropDownCubit>()
                                .selectCategory(value!);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*
showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('القيم المحفوظة'),
                                  content: Text(
                                    'Category ID: $selectedCategoryId\n'
                                    'SubCategory ID: $selectedSubCategoryId\n\n'
                                    'Category: ${selectedCategory?.name}\n'
                                    'SubCategory: ${selectedSubCategory?.name}',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('موافق'),
                                    ),
                                  ],
                                ),
                          )*/

/*
Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'القيم المختارة:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Category ID: ${selectedCategoryId ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Category Name: ${selectedCategory?.name ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'SubCategory ID: ${selectedSubCategoryId ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'SubCategory Name: ${selectedSubCategory?.name ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )*/

/*




import 'package:cityswitch_app/features/home/data/models/stors_category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/style/app_text_style.dart';
import '../../../home/domain/entities/stores_category_entites.dart';
import '../../../home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../manger/add_store/add_store_cubit.dart';


class EdiCustomSelectCategories extends StatefulWidget {
  @override
  _EdiCustomSelectCategoriesState createState() => _EdiCustomSelectCategoriesState();
}

class _EdiCustomSelectCategoriesState extends State<EdiCustomSelectCategories> {
  // المتغيرات لتخزين الاختيارات
  String? selectedCategoryId;
  String? selectedSubCategoryId;
  StorsCategoryEntites? selectedCategory;
 
  // قائمة SubCategories المفلترة حسب Category المختار
 
  @override
  Widget build(BuildContext context) {
    AddStoreCubit cAddStore = BlocProvider.of(context);
    StoresCategoriesCubit cCategory = BlocProvider.of(context);

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Dropdown
            Text(
              'Choose category:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            BlocBuilder<AddStoreCubit, AddStoreState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border:
                        state is AddCategoryValidator
                            ? Border.all(color: Colors.red)
                            : Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<StorsCategoryEntites>(
                    value: selectedCategory,
                    hint: Text('Choose a category'),
                    isExpanded: true,
                    underline: SizedBox(),
                    items:
                        cCategory.storesCategories!.map((
                          StorsCategoryEntites category,
                        ) {
                          return DropdownMenuItem<StorsCategoryEntites>(
                            value: category,
                            child: Text(category.name!),
                          );
                        }).toList(),
                    onChanged: (StorsCategoryEntites? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                        selectedCategoryId = newValue?.id;
                        cAddStore.addStoreEntite.category =
                            selectedCategoryId.toString();

                        // إعادة تعيين SubCategory عند تغيير Category
                         selectedSubCategoryId = null;

                        // فلترة SubCategories حسب Category المختار
                //        if (newValue != null) {
                //          filteredSubCategories =
                //              allSubCategories
                //                  .where((sub) => sub.categoryId == newValue.id)
                //                  .toList();
                //        } else {
                //          filteredSubCategories = [];
                //        }
                      });
                    },
                  ),
                );
              },
            ),

            SizedBox(height: 30),

            // SubCategory Dropdown
            Text(
              'Select subcategory:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            BlocBuilder<AddStoreCubit, AddStoreState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border:
                            state is AddSubCategoryValidator
                                ? Border.all(color: Colors.red)
                                : Border.all(
                                  color:
                                      selectedCategory == null
                                          ? Colors.grey.shade300
                                          : Colors.grey,
                                ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<StorsCategoryEntites>(
                        value: selectedCategory,
                        hint: Text(
                          selectedCategory == null
                              ? 'Choose a category first'
                              : 'Select a subcategory',
                          style: TextStyle(
                            color:
                                selectedCategory == null
                                    ? Colors.grey.shade400
                                    : Colors.black54,
                          ),
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
                        items: selectedCategory?.subCategories?.map((SubCategoryModel category) {
                           return DropdownMenuItem<StorsCategoryEntites>(
                                    value: category,
                                    child: Text(category.name!),
                                  );
                        },).toList()


                            selectedCategory == null
                                ? []
                                : filteredSubCategories.map((
                                  SubCategory subCategory,
                                ) {
                                  return DropdownMenuItem<SubCategory>(
                                    value: subCategory,
                                    child: Text(subCategory.name),
                                  );
                                }).toList(),
                        onChanged:
                            selectedCategory == null
                                ? null
                                : (SubCategory? newValue) {
                                  setState(() {
                                    selectedSubCategory = newValue;
                                    selectedSubCategoryId = newValue?.id;
                                    cAddStore.addStoreEntite.subCategory =
                                        selectedSubCategoryId.toString();
                                  });
                                },
                      ),
                    ),
                    SizedBox(height: 10),
                    if (state is AddCategoryValidator)
                      Text(
                        state.msg,
                        style: AppTextStyle.h6Medium12(
                          context,
                        ).copyWith(color: Colors.red),
                      ),
                    if (state is AddSubCategoryValidator)
                      Text(
                        state.msg,
                        style: AppTextStyle.h6Medium12(
                          context,
                        ).copyWith(color: Colors.red),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // دالة للحصول على Category ID المختار
  int? getCategoryId() {
    return selectedCategoryId;
  }

  // دالة للحصول على SubCategory ID المختار
  int? getSubCategoryId() {
    return selectedSubCategoryId;
  }
}

/*
showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('القيم المحفوظة'),
                                  content: Text(
                                    'Category ID: $selectedCategoryId\n'
                                    'SubCategory ID: $selectedSubCategoryId\n\n'
                                    'Category: ${selectedCategory?.name}\n'
                                    'SubCategory: ${selectedSubCategory?.name}',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('موافق'),
                                    ),
                                  ],
                                ),
                          )*/

/*
Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'القيم المختارة:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Category ID: ${selectedCategoryId ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Category Name: ${selectedCategory?.name ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'SubCategory ID: ${selectedSubCategoryId ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'SubCategory Name: ${selectedSubCategory?.name ?? 'غير محدد'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )*/
*/
