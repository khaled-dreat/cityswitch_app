// مثال على استخدام ServerImagesDisplayWidget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/models/image_update/image_update.dart';
import '../manger/edit_my_store_cubit/edit_my_store_cubit.dart';
import '../manger/my_store_cubit/my_store_cubit.dart';

class ServerImagesDisplayWidget extends StatefulWidget {
  final int maxImages;
  final String baseUrl; // الرابط الأساسي للسيرفر
  final List<String> initialImages;

  const ServerImagesDisplayWidget({
    Key? key,
    required this.initialImages,

    required this.baseUrl,
    this.maxImages = 5,
  }) : super(key: key);

  @override
  State<ServerImagesDisplayWidget> createState() =>
      _ServerImagesDisplayWidgetState();
}

class _ServerImagesDisplayWidgetState extends State<ServerImagesDisplayWidget>
    with TickerProviderStateMixin {
  late List<String> serverImages;
  // الصور الموجودة على السيرفر
  late List<String> originalServerImages;

  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late ImageUpdateModel imageUpdateModel;

  @override
  void initState() {
    super.initState();
    imageUpdateModel = context.read<EditMyStoreCubit>().imageUpdateModel;
    imageUpdateModel.updateTotal(widget.initialImages.length);
    serverImages = List.from(widget.initialImages);
    originalServerImages = List.from(widget.initialImages);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _removeServerImage(int index) {
    setState(() {
      String imageUrl = serverImages[index];
      imageUpdateModel.deletedImageUrls?.add(imageUrl);
      serverImages.removeAt(index);
      imageUpdateModel.updateTotal(serverImages.length);
    });
    _showSnackBar('Image deleted');
  }

  void _removeNewImage(int index) {
    setState(() {
      imageUpdateModel.newImages?.removeAt(index);
      imageUpdateModel.updateTotal(serverImages.length);
    });
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

  void _showImagePreview(dynamic image, int index, bool isServerImage) {
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
                    child:
                        isServerImage
                            ? CachedNetworkImage(
                              imageUrl: '${widget.baseUrl}$image',
                              fit: BoxFit.contain,
                              placeholder:
                                  (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (context, url, error) => const Icon(
                                    Icons.error,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                            )
                            : Image.file(image as File, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (isServerImage) {
                          _removeServerImage(index);
                        } else {
                          _removeNewImage(index);
                        }
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

  Widget _buildImageTile(dynamic image, int index, bool isServerImage) {
    return GestureDetector(
      onTap: () => _showImagePreview(image, index, isServerImage),
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
              child:
                  isServerImage
                      ? CachedNetworkImage(
                        imageUrl: '${widget.baseUrl}$image',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      )
                      : Image.file(
                        image as File,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
            ),
            // Delete button
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  isServerImage
                      ? _removeServerImage(index)
                      : _removeNewImage(index);
                },

                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
            // Image type indicator
            // Image number
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Icons.photo_library_rounded,
                  color: Colors.blue.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Store Pictures",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Arial Unicode MS',
                      ),
                    ),
                    Text(
                      '$_totalImages/${widget.maxImages} image',
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

          // Statistics

          // Add Images Button
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: ElevatedButton.icon(
                    onPressed:
                        _totalImages < widget.maxImages
                            ? _pickMultipleImages
                            : null,
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ),

                    label: const Text(
                      'Add photos',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Arial Unicode MS',
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _totalImages < widget.maxImages
                              ? Colors.red.shade500
                              : Colors.grey.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed:
                      _totalImages < widget.maxImages
                          ? _pickMultipleImages
                          : null,
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add photos',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arial Unicode MS',
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _totalImages < widget.maxImages
                            ? Colors.green.shade600
                            : Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          BlocBuilder<MyStoreCubit, MyStoreState>(
            builder: (context, state) {
              if (state is MyStoreSuccess) {
                return FadeTransition(
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
                    itemCount: _totalImages,
                    itemBuilder: (context, index) {
                      if (index < serverImages.length) {
                        // Server image
                        return _buildImageTile(
                          serverImages[index],
                          index,
                          true,
                        );
                      } else {
                        // New image
                        int newImageIndex = index - serverImages.length;
                        return _buildImageTile(
                          imageUpdateModel.newImages?[newImageIndex],
                          newImageIndex,
                          false,
                        );
                      }
                    },
                  ),
                );
              }

              return Container(
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
                      Icons.photo_library_outlined,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'No pictures',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontFamily: 'Arial Unicode MS',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Click "Add Photos" to add new photos.',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                        fontFamily: 'Arial Unicode MS',
                      ),
                    ),
                  ],
                ),
              );
              // Images Grid
            },
          ),
          // Progress Indicator
          if (_totalImages > 0) ...[
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'progress',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Arial Unicode MS',
                      ),
                    ),
                    Text(
                      '${((_totalImages / widget.maxImages) * 100).toInt()}%',
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
                  value: _totalImages / widget.maxImages,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _totalImages == widget.maxImages
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
    );
  }

  int get _totalImages =>
      (serverImages?.length ?? 0) + (imageUpdateModel.newImages?.length ?? 0);

  Future<void> _pickMultipleImages() async {
    if (_totalImages >= widget.maxImages) {
      _showSnackBar('You cannot add more than ${widget.maxImages} images.');
      return;
    }

    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (images.isNotEmpty) {
        int remainingSlots = widget.maxImages - _totalImages;
        List<XFile> imagesToAdd = images.take(remainingSlots).toList();
        setState(() {
          imageUpdateModel.newImages.addAll(
            imagesToAdd.map((image) => File(image.path)),
          );
          imageUpdateModel.updateTotal(serverImages.length);
        });

        _showSnackBar("${imagesToAdd.length} image added successfully");

        if (images.length > remainingSlots) {
          _showSnackBar(
            '$remainingSlots added only images. Maximum ${widget.maxImages} images',
          );
        }
      }
    } catch (e) {
      _showSnackBar('An error occurred while selecting images');
    }
  }
}
