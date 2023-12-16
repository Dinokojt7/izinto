class SubscriptionModel {
  final int status;
  final String? lastDate;
  final String? nextDate;
  final int? capacity;

  SubscriptionModel(
      {required this.status, this.lastDate, this.nextDate, this.capacity});
}
