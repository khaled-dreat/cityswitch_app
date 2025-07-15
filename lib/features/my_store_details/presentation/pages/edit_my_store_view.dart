import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/core/utils/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../../../core/validators/app_validators.dart';
import '../manger/edit_my_store_cubit/edit_my_store_cubit.dart';
import '../manger/my_store_cubit/my_store_cubit.dart';
import '../widgets/build_section_title.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field_add_store.dart';
import '../widgets/edit_custom_select_categories.dart';
import '../widgets/header_card_widget.dart';
import '../widgets/edit_keywords_section.dart';
import '../widgets/edit_store_images_upload.dart';

class EditMyStoreViewBody extends StatefulWidget {
  const EditMyStoreViewBody({super.key});

  @override
  State<EditMyStoreViewBody> createState() => _EditMyStoreViewBodyState();
}

class _EditMyStoreViewBodyState extends State<EditMyStoreViewBody> {
  final _formKey = GlobalKey<FormState>();
  List<File> storeImages = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditMyStoreCubit cEditStore = BlocProvider.of<EditMyStoreCubit>(context);
    return BlocBuilder<MyStoreCubit, MyStoreState>(
      builder: (context, state) {
        if (state is MyStoreSuccess) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  HeaderCardWidget(),
                  const SizedBox(height: 30),

                  // Store Name
                  CustomTextFieldAddStore(
                    initialValue: "${state.myStore.name}",
                    onSaved: cEditStore.editMyStoreEntite.setName,
                    validator: AppValidators.isNotEmpty,
                    hintText: 'Enter store name',
                    prefixIcon: Icons.store_outlined,
                  ),
                  // const SizedBox(height: 25),
                  // // Address
                  // CustomTextFieldAddStore(
                  //   // onSaved: cAddStore.addStoreEntite.set,
                  //   hintText: 'Add zip code',
                  //   prefixIcon: Icons.location_on_outlined,
                  //   maxLines: 2,
                  // ),
                  // const SizedBox(height: 10),

                  // Text(
                  //   "* Or you can leave it blank to record your location.",
                  //   style: AppTextStyle.h6Medium12(
                  //     context,
                  //   ).copyWith(color: AppColors.grey800),
                  // ),
                  const SizedBox(height: 25),
                  // Phone Number
                  CustomTextFieldAddStore(
                    initialValue: "${state.myStore.phoneNum}",
                    validator: AppValidators.isNotEmpty,
                    onSaved: cEditStore.editMyStoreEntite.setPhoneNum,
                    hintText: "Enter phone number ",
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 25),
                  // Description
                  CustomTextFieldAddStore(
                    initialValue: "${state.myStore.description}",
                    validator: AppValidators.isNotEmpty,
                    onSaved: cEditStore.editMyStoreEntite.setDescription,
                    hintText: 'Enter store description',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<MyStoreCubit, MyStoreState>(
                    builder: (context, state) {
                      if (state is MyStoreSuccess) {
                        return ServerImagesDisplayWidget(
                          baseUrl: "http://192.168.0.80:3000/",
                          maxImages: 5,
                          initialImages: state.myStore.images ?? [],
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 25),
                  EditBuildSectionTitle(
                    title: 'Choose category',
                    icon: Icons.tag,
                  ),
                  const SizedBox(height: 15),
                  EditCustomSelectCategories(),
                  const SizedBox(height: 25),
                  KeywordsSection(),
                  const SizedBox(height: 40),
                  // Submit Button
                  InkWell(
                    onTap: () async {
                      _formKey.currentState?.save();
                      await cEditStore.editMyStore(context: context);
                      if (_formKey.currentState?.validate() ?? false) {
                        // ✅
                        //  if ( != null) {
                        //  } else {
                        //    AppToast.toast(cAuth.errorMessage);
                        //  }
                      }
                    },

                    child: CustomSubmitButton(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class EditMyStoreView extends StatefulWidget {
  static const String nameRoute = "EditMyStoreView";

  const EditMyStoreView({super.key});
  @override
  State<EditMyStoreView> createState() => _EditMyStoreViewState();
}

class _EditMyStoreViewState extends State<EditMyStoreView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: EditMyStoreViewBody(),
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
