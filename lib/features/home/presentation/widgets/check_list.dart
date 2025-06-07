import 'dart:developer';

import 'package:cityswitch_app/features/home/presentation/manger/fetch_home_cubit/home_cubit.dart';
import 'package:cityswitch_app/features/home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/select_category_cubit/select_category_cubit.dart';

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({super.key});

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.indigo, width: 1.5),
        ),
        child: BlocBuilder<StoresCategoriesCubit, StoresCategoriesState>(
          builder: (context, state) {
            if (state is StoresCategoriesSuccess) {
              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('اختر نوع المتجر'),

                  value: context.watch<StoreFilterCubit>().state,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.indigo),
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                  items:
                      state.storesCategories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.name!),
                        );
                      }).toList(),
                  onChanged: (value) async {
                    await context.read<HomeCubit>().fetchStors();
                    context.read<StoreFilterCubit>().selectCategory(value!);
                  },
                ),
              );

              //      DropdownButton<String>(
              //        hint: Text('اختر نوع المتجر'),
              //        items:
              //            state.storesCategories.map((category) {
              //              return DropdownMenuItem<String>(
              //                value: category.id,
              //                child: Text(category.name!),
              //              );
              //            }).toList(),
              //        onChanged: (value) async {
              //          await context.read<HomeCubit>().fetchStors();
              //          context.read<StoreFilterCubit>().selectCategory(value!);
              //        },
              //      );
            } else if (state is StoresCategoriesFailure) {
              log(state.errMessage);
              Text(state.errMessage);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
