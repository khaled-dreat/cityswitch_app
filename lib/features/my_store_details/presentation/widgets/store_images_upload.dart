// Store Images Upload Widget (Updated)
import 'dart:developer';
import 'dart:io';

import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/features/add_store/presentation/manger/add_store/add_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/utils/style/app_text_style.dart';

class StoreImagesUploadWidget extends StatefulWidget {
  final Function(List<File>) onImagesChanged;

  final int maxImages;

  const StoreImagesUploadWidget({
    Key? key,
    required this.onImagesChanged,

    this.maxImages = 5,
  }) : super(key: key);

  @override
  State<StoreImagesUploadWidget> createState() =>
      _StoreImagesUploadWidgetState();
}

class _StoreImagesUploadWidgetState extends State<StoreImagesUploadWidget>
    with TickerProviderStateMixin {
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickMultipleImages() async {
    AddStoreCubit cAddStore = BlocProvider.of(context);
    if (_selectedImages.length >= widget.maxImages) {
      _showSnackBar('You cannot add more than ${widget.maxImages} photos.');
      return;
    }

    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (images.isNotEmpty) {
        int remainingSlots = widget.maxImages - _selectedImages.length;
        List<XFile> imagesToAdd = images.take(remainingSlots).toList();

        setState(() {
          _selectedImages.addAll(imagesToAdd.map((image) => File(image.path)));
        });
        _animationController.forward();
        widget.onImagesChanged(_selectedImages);
        _showSnackBar("Image ${imagesToAdd.length} added successfully");

        if (images.length > remainingSlots) {
          _showSnackBar(
            'Only $remainingSlots images added. Maximum ${widget.maxImages} images',
          );
        }
        cAddStore.addStoreEntite.images = _selectedImages;
      }
    } catch (e) {
      _showSnackBar('An error occurred while selecting images');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesChanged(_selectedImages);
    _showSnackBar('Image deleted');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Arial Unicode MS'),
        ),
        backgroundColor: Colors.blue.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showImagePreview(File image, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(image, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _removeImage(index);
                      },
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: const Text(
                        'delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Arial Unicode MS',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: const Text(
                        'closing',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Arial Unicode MS',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddStoreCubit, AddStoreState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,

                border:
                    state is AddImagesValidator
                        ? Border.all(color: Colors.red, width: 1)
                        : null,
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
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.store_rounded,
                          color: Colors.blue.shade600,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Store pictures",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                fontFamily: 'Arial Unicode MS',
                              ),
                            ),
                            Text(
                              '${_selectedImages.length}/${widget.maxImages} photos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontFamily: 'Arial Unicode MS',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Upload Buttons
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickMultipleImages,
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add photos',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arial Unicode MS',
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Images Grid
                  if (_selectedImages.isEmpty)
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'No images have been selected yet.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontFamily: 'Arial Unicode MS',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Click the buttons above to add store images',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                              fontFamily: 'Arial Unicode MS',
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap:
                                () => _showImagePreview(
                                  _selectedImages[index],
                                  index,
                                ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _selectedImages[index],
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // Progress Indicator
                  if (_selectedImages.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'progress',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontFamily: 'Arial Unicode MS',
                              ),
                            ),
                            Text(
                              '${((_selectedImages.length / widget.maxImages) * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade600,
                                fontFamily: 'Arial Unicode MS',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        LinearProgressIndicator(
                          value: _selectedImages.length / widget.maxImages,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _selectedImages.length == widget.maxImages
                                ? Colors.green
                                : Colors.blue.shade600,
                          ),
                          minHeight: 6,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (state is AddImagesValidator)
              Text(
                state.msg,
                style: AppTextStyle.h6Medium12(
                  context,
                ).copyWith(color: Colors.red),
              ),
          ],
        );
      },
    );
  }
}
