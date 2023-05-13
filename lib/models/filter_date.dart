class FilterDate {
  String placeholder;
  DateTime? fromDate;
  DateTime? toDate;

  FilterDate({required this.placeholder, this.fromDate, this.toDate});
  // : this.toDate = toDateTime ?? DateTime.now();
}
