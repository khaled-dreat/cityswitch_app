class ErrorModel {
  String? type;
  String? value;
  String? msg;
  String? path;
  String? location;

  ErrorModel({this.type, this.value, this.msg, this.path, this.location});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    type: json['type'] as String?,
    value: json['value'] as String?,
    msg: json['msg'] as String?,
    path: json['path'] as String?,
    location: json['location'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'value': value,
    'msg': msg,
    'path': path,
    'location': location,
  };

  // ✅ دالة من String يدويًا
  static List<ErrorModel> fromRawString(String raw) {
    final regex = RegExp(r'ErrorModel\((.*?)\)');
    final matches = regex.allMatches(raw);

    return matches.map((match) {
      final group = match.group(1)!;

      final fields = Map.fromEntries(
        group.split(', ').map((part) {
          final split = part.split(': ');
          return MapEntry(split[0], split.length > 1 ? split[1] : '');
        }),
      );

      return ErrorModel(
        type: fields['type'] ?? '',
        value: fields['value'] == 'null' ? null : fields['value'],
        msg: fields['msg'] ?? '',
        path: fields['path'] ?? '',
        location: fields['location'] ?? '',
      );
    }).toList();
  }
}
