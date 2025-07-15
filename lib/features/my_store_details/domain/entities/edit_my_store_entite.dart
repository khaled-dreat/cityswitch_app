class EditMyStoreEntite {
  String? name;
  String? ownerId;
  String? description;
  String? category;
  String? subCategory;
  List<String>? tags;
  String? phoneNum;

  EditMyStoreEntite({
    this.name,
    this.description,
    this.category,
    this.subCategory,
    this.tags,
    this.ownerId,
  });

  void setName(String? value) => name = value!;
  void setPhoneNum(String? value) => phoneNum = value!;
  void setDescription(String? value) => description = value;
  void setCategory(String? value) => category = value!;
  void setSubCategory(String? value) => subCategory = value;
  void setOwnerId(String? value) => ownerId = value;
  void setTags(List<String> value) => tags = value;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'Tags': tags,
      'phoneNum': phoneNum,
    };
  }
}
