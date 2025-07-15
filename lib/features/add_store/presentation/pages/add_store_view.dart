import 'dart:developer';

import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/core/utils/style/app_text_style.dart';
import 'package:cityswitch_app/features/add_store/presentation/widgets/custom_select_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../../core/validators/app_validators.dart';
import '../manger/add_store/add_store_cubit.dart';
import '../widgets/build_section_title.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field_add_store.dart';
import '../widgets/header_card_widget.dart';
import '../widgets/keywords_section.dart';
import '../widgets/store_images_upload.dart';

class AddStoreViewBody extends StatefulWidget {
  const AddStoreViewBody({super.key});

  @override
  State<AddStoreViewBody> createState() => _AddStoreViewBodyState();
}

class _AddStoreViewBodyState extends State<AddStoreViewBody> {
  final _formKey = GlobalKey<FormState>();
  List<File> storeImages = [];

  @override
  Widget build(BuildContext context) {
    final cAddStore = BlocProvider.of<AddStoreCubit>(context);

    return BlocListener<AddStoreCubit, AddStoreState>(
      listener: (context, state) {
        if (state is AddStoreSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('✅ تم الحفظ بنجاح'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );

          // يمكنك إعادة تعيين النموذج أو التنقل لصفحة أخرى إن أحببت:
          // Navigator.pop(context);
        }

        if (state is AddStoreFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('حدث خطأ: ${state.errMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderCardWidget(),
              const SizedBox(height: 30),
              CustomTextFieldAddStore(
                onSaved: cAddStore.addStoreEntite.setName,
                validator: AppValidators.isNotEmpty,
                hintText: 'Enter store name',
                prefixIcon: Icons.store_outlined,
              ),
              const SizedBox(height: 25),
              CustomTextFieldAddStore(
                hintText: 'Add zip code',
                prefixIcon: Icons.location_on_outlined,
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Text(
                "* Or you can leave it blank to record your location.",
                style: AppTextStyle.h6Medium12(
                  context,
                ).copyWith(color: AppColors.grey800),
              ),
              const SizedBox(height: 25),
              CustomTextFieldAddStore(
                validator: AppValidators.isNotEmpty,
                onSaved: cAddStore.addStoreEntite.setPhoneNum,
                hintText: "Enter phone number",
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 25),
              CustomTextFieldAddStore(
                validator: AppValidators.isNotEmpty,
                onSaved: cAddStore.addStoreEntite.setDescription,
                hintText: 'Enter store description',
                maxLines: 4,
              ),
              const SizedBox(height: 25),
              StoreImagesUploadWidget(
                maxImages: 5,
                onImagesChanged: (images) {
                  setState(() {
                    storeImages = images;
                  });
                },
              ),
              const SizedBox(height: 25),
              CustomSelectCategories(),
              const SizedBox(height: 25),
              KeywordsSection(),
              const SizedBox(height: 40),
              InkWell(
                onTap: () async {
                  _formKey.currentState?.save();
                  await cAddStore.addStore(context: context);
                  if (_formKey.currentState?.validate() ?? false) {}
                },
                child: CustomSubmitButton(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AddStoreView extends StatefulWidget {
  static const String nameRoute = "AddMarketView";

  const AddStoreView({super.key});
  @override
  State<AddStoreView> createState() => _AddStoreViewState();
}

class _AddStoreViewState extends State<AddStoreView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: AddStoreViewBody(),
      ),
    );
  }
}

/*
class KeywordsSection extends StatefulWidget {
  const KeywordsSection({super.key});

  @override
  State<KeywordsSection> createState() => _KeywordsSectionState();
}

class _KeywordsSectionState extends State<KeywordsSection> {
  final _keywordController = TextEditingController();
  List<String> keywords = [];

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _addKeyword() {
    if (_keywordController.text.trim().isNotEmpty) {
      setState(() {
        keywords.add(_keywordController.text.trim());
        _keywordController.clear();
      });
      _showSnackBar('تم إضافة الكلمة المفتاحية', Colors.green);
    }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Keywords Section
        BuildSectionTitle(title: 'Keywords', icon: Icons.tag),
        const SizedBox(height: 10),

        // Keyword Input
        Container(
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _keywordController,
                      style: const TextStyle(fontFamily: 'Arial Unicode MS'),
                      decoration: InputDecoration(
                        hintText: 'أدخل كلمة مفتاحية',
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
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
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
                    child: const Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ],
              ),

              // Keywords Display
              if (keywords.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            'الكلمات المضافة (${keywords.length})',
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
                            keywords
                                .asMap()
                                .entries
                                .map(
                                  (entry) => BuildKeywordChip(
                                    keyword: entry.value,
                                    index: entry.key,
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class BuildKeywordChip extends StatefulWidget {
  const BuildKeywordChip({
    super.key,
    required this.keyword,
    required this.index,
  });

  final String keyword;
  final int index;

  @override
  State<BuildKeywordChip> createState() => _BuildKeywordChipState();
}

class _BuildKeywordChipState extends State<BuildKeywordChip> {
  List<String> keywords = [];

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

  void _removeKeyword(int index) {
    setState(() {
      keywords.removeAt(index);
    });
    _showSnackBar('تم حذف الكلمة المفتاحية', Colors.orange);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.keyword,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
              fontFamily: 'Arial Unicode MS',
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _removeKeyword(widget.index),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.close, size: 14, color: Colors.red.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
*/
