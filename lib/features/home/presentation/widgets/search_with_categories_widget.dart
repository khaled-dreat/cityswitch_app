import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/search_store/m_search_parmeter.dart';
import '../manger/store_cubit/stors_cubit.dart';
import 'drop_down_category.dart';
import 'drop_down_sup_category.dart';

class SearchWithCategoriesWidget extends StatefulWidget {
  final Function(String searchText, String? category, String? subCategory)?
  onSearch;

  const SearchWithCategoriesWidget({Key? key, this.onSearch}) : super(key: key);

  @override
  State<SearchWithCategoriesWidget> createState() =>
      _SearchWithCategoriesWidgetState();
}

class _SearchWithCategoriesWidgetState
    extends State<SearchWithCategoriesWidget> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedSubCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // حقل البحث
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _searchController,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    hintTextDirection: TextDirection.rtl,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  // onSubmitted: (_) => _performSearch(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  context.read<StorsCubit>().fetchSearchStores(
                    searchParmeterModel: SearchParmeterModel(
                      keyword: _searchController.text,
                      category: _selectedCategory,
                      subCategory: _selectedSubCategory,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('search'),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              // Dropdown للفئة الرئيسية
              DropDownCategory(
                onCategorySelected: (value) {
                  _selectedCategory = value;
                },
              ),
              const SizedBox(width: 12),
              // Dropdown للفئة الفرعية
              DropDownSubCategory(
                onCategorySelected: (value) {
                  _selectedSubCategory = value;
                },
              ),
            ],
          ),
          // صف الـ Dropdown Lists
        ],
      ),
    );
  }
}
