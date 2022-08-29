class PaginatedModel<T> {
  int nhits;
  List<T> records;

  PaginatedModel({required this.nhits, required this.records});

  factory PaginatedModel.fromJson(
      Map<String, dynamic> json, Function fromJsonModel) {
    final dynamic records = json['records'].cast<Map<String, dynamic>>();

    return PaginatedModel<T>(
        nhits: json['nhits'],
        records: List<T>.from(records.map((record) => fromJsonModel(record))));
  }
}
