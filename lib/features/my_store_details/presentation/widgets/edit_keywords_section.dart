import 'package:cityswitch_app/features/my_store_details/presentation/widgets/edit_build_keyword_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/style/app_text_style.dart';
import '../../../add_store/presentation/widgets/build_section_title.dart';
import '../manger/edit_keywords_cubit/edit_keywords_cubit.dart';
import '../manger/edit_my_store_cubit/edit_my_store_cubit.dart';
import '../manger/my_store_cubit/my_store_cubit.dart';

class KeywordsSection extends StatefulWidget {
  const KeywordsSection({super.key});

  @override
  State<KeywordsSection> createState() => _KeywordsSectionState();
}

class _KeywordsSectionState extends State<KeywordsSection> {
  final _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Arial Unicode MS',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addKeyword() {
    final keyword = _keywordController.text.trim();
    if (keyword.isNotEmpty) {
      if (context.read<EditKeywordsCubit>().state.length < 3) {
        context.read<EditKeywordsCubit>().addKeyword(keyword);
        _keywordController.clear();
        _showSnackBar('Keyword added', Colors.green);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditKeywordsCubit, List<String>>(
      listener: (context, keywords) {
        context.read<EditMyStoreCubit>().editMyStoreEntite.tags = keywords;
      },
      child: BlocBuilder<MyStoreCubit, MyStoreState>(
        builder: (context, state) {
          if (state is MyStoreSuccess) {
            final tags = state.myStore.tags ?? [];
            final keywordsCubit = context.read<EditKeywordsCubit>();

            // ترحيل لمرة واحدة فقط
            if (keywordsCubit.state.isEmpty) {
              keywordsCubit.emit(tags);
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildSectionTitle(title: 'Keywords', icon: Icons.tag),
              const SizedBox(height: 10),

              // حقل الإدخال
              BlocBuilder<EditMyStoreCubit, EditMyStoreState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border:
                          state is EditTagsValidator
                              ? Border.all(color: Colors.red, width: 1)
                              : null,
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _keywordController,
                                style: const TextStyle(
                                  fontFamily: 'Arial Unicode MS',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter a keyword',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontFamily: 'Arial Unicode MS',
                                  ),
                                  prefixIcon: Icon(
                                    Icons.tag,
                                    color: Colors.grey.shade600,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue.shade600,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                                onFieldSubmitted: (value) => _addKeyword(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _addKeyword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),

                        // عرض الكلمات المضافة
                        BlocBuilder<EditKeywordsCubit, List<String>>(
                          builder: (context, keywords) {
                            if (keywords.isEmpty) return const SizedBox();
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.blue.shade200,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.label,
                                            color: Colors.blue.shade600,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Added keywords (${keywords.length})',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade700,
                                              fontFamily: 'Arial Unicode MS',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            keywords.asMap().entries.map((
                                              entry,
                                            ) {
                                              return EditBuildKeywordChip(
                                                keyword: entry.value,
                                                index: entry.key,
                                              );
                                            }).toList(),
                                      ),
                                      if (state is EditTagsValidator)
                                        Text(
                                          state.msg,
                                          style: AppTextStyle.h6Medium12(
                                            context,
                                          ).copyWith(color: Colors.red),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
