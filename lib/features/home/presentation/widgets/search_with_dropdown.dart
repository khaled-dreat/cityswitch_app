import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/store_cubit/stors_cubit.dart';
import '../manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../manger/select_category_cubit/select_category_cubit.dart';

class SearchWithDropdown extends StatefulWidget {
  const SearchWithDropdown({super.key});

  @override
  _SearchWithDropdownState createState() => _SearchWithDropdownState();
}

class _SearchWithDropdownState extends State<SearchWithDropdown> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {},
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          suffixIcon: BlocBuilder<StoresCategoriesCubit, StoresCategoriesState>(
            builder: (context, state) {
              if (state is StoresCategoriesSuccess) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    value: context.watch<SelectCategoryDropDownCubit>().state,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (value) async {
                      //    //  await context.read<StorsCubit>().fetchStors();

                      context
                          .read<SelectCategoryDropDownCubit>()
                          .selectCategory(value!);
                    },
                    items:
                        state.storesCategories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Text(category.name!),
                          );
                        }).toList(),
                  ),
                );
              } else if (state is StoresCategoriesFailure) {
                //  log(state.errMessage);
                Text(state.errMessage);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }
}
