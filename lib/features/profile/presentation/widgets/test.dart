import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StoreImagesUpload extends StatefulWidget {
  final Function(List<File>) onImagesChanged;
  final String title;
  final int maxImages;

  const StoreImagesUpload({
    Key? key,
    required this.onImagesChanged,
    this.title = 'صور المتجر',
    this.maxImages = 5,
  }) : super(key: key);

  @override
  State<StoreImagesUpload> createState() => _StoreImagesUploadState();
}

class _StoreImagesUploadState extends State<StoreImagesUpload>
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

  Future<void> _pickSingleImage() async {
    if (_selectedImages.length >= widget.maxImages) {
      _showSnackBar('لا يمكن إضافة أكثر من ${widget.maxImages} صور');
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image != null) {
        setState(() {
          _selectedImages.add(File(image.path));
        });
        _animationController.forward();
        widget.onImagesChanged(_selectedImages);
        _showSnackBar('تم إضافة الصورة بنجاح');
      }
    } catch (e) {
      _showSnackBar('حدث خطأ في اختيار الصورة');
    }
  }

  Future<void> _pickMultipleImages() async {
    if (_selectedImages.length >= widget.maxImages) {
      _showSnackBar('لا يمكن إضافة أكثر من ${widget.maxImages} صور');
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
        _showSnackBar('تم إضافة ${imagesToAdd.length} صورة بنجاح');

        if (images.length > remainingSlots) {
          _showSnackBar(
            'تم إضافة $remainingSlots صور فقط. الحد الأقصى ${widget.maxImages} صور',
          );
        }
      }
    } catch (e) {
      _showSnackBar('حدث خطأ في اختيار الصور');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesChanged(_selectedImages);
    _showSnackBar('تم حذف الصورة');
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
                        'حذف',
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
                        'إغلاق',
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
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                        fontFamily: 'Arial Unicode MS',
                      ),
                    ),
                    Text(
                      '${_selectedImages.length}/${widget.maxImages} صور',
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
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pickSingleImage,
                  icon: const Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'إضافة صورة',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arial Unicode MS',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pickMultipleImages,
                  icon: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'إضافة عدة صور',
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
                    'لم يتم اختيار أي صور بعد',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontFamily: 'Arial Unicode MS',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'اضغط على الأزرار أعلاه لإضافة صور المتجر',
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap:
                        () => _showImagePreview(_selectedImages[index], index),
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
                                  borderRadius: BorderRadius.circular(15),
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
                      'التقدم',
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
    );
  }
}

// مثال على كيفية استخدام الـ Widget
class StoreRegistrationPage extends StatefulWidget {
  @override
  State<StoreRegistrationPage> createState() => _StoreRegistrationPageState();
}

class _StoreRegistrationPageState extends State<StoreRegistrationPage> {
  List<File> storeImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسجيل المتجر',
          style: TextStyle(fontFamily: 'Arial Unicode MS'),
        ),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StoreImagesUpload(
              title: 'صور المتجر (مطلوبة)',
              maxImages: 5,
              onImagesChanged: (images) {
                setState(() {
                  storeImages = images;
                });
              },
            ),
            const SizedBox(height: 20),
            if (storeImages.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade600),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'تم اختيار ${storeImages.length} صور للمتجر',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontFamily: 'Arial Unicode MS',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
