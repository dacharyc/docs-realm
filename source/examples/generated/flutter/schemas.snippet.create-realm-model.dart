@RealmModel()
class _Car {
  @PrimaryKey()
  late String make;

  late String? model;
  late int? miles;
}