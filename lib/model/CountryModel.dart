class CountryModel {
  String name;
  String code;
  String flag;

  CountryModel({
    required this.name,
    required this.code,
    required this.flag,
  });

  @override
  String toString() {
    return 'CountryModel{name: $name, code: $code, flag: $flag}';
  }
}
