class Address {
  String? allotments;
  String? suburb;
  String? cityDistrict;
  String? city;
  String? iso31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address({
    this.allotments,
    this.suburb,
    this.cityDistrict,
    this.city,
    this.iso31662Lvl4,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    allotments: json['allotments'] as String?,
    suburb: json['suburb'] as String?,
    cityDistrict: json['city_district'] as String?,
    city: json['city'] as String?,
    iso31662Lvl4: json['ISO3166-2-lvl4'] as String?,
    postcode: json['postcode'] as String?,
    country: json['country'] as String?,
    countryCode: json['country_code'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'allotments': allotments,
    'suburb': suburb,
    'city_district': cityDistrict,
    'city': city,
    'ISO3166-2-lvl4': iso31662Lvl4,
    'postcode': postcode,
    'country': country,
    'country_code': countryCode,
  };
}
