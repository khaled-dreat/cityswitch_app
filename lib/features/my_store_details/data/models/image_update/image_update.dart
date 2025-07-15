import 'dart:io';

class ImageUpdateModel {
  List<File> newImages;
  List<String> deletedImageUrls;
  int totalDisplayedImages;

  ImageUpdateModel({List<File>? newImages, List<String>? deletedImageUrls})
    : newImages = newImages ?? [],
      deletedImageUrls = deletedImageUrls ?? [],
      totalDisplayedImages = 0;

  /// ✅ تحديث قيمة totalDisplayedImages يدوياً
  void updateTotal(int serverImagesCount) {
    totalDisplayedImages = newImages.length + serverImagesCount;
  }
}
