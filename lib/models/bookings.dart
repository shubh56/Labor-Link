class Bookings{
  Bookings({
    required this.bookingDate,
    required this.bookingStatus,
    required this.customerId,
    required this.jobType,
    required this.workerId,
  });
  late final String bookingDate;
  late final String bookingStatus;
  late final String customerId;
  late final String jobType;
  late final String workerId;


  Bookings.fromJson(Map<String, dynamic> json){
    bookingDate = json['bookingDate'] ?? '';
    bookingStatus = json['bookingStatus']?? '';
    customerId = json['customerId']?? '';
    jobType = json['jobType'] ?? '';
    workerId = json['workerId']?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bookingDate'] = bookingDate;
    data['bookingStatus'] = bookingStatus;
    data['customerId'] = customerId;
    data['jobType'] = jobType;
    data['workerId'] = workerId;
    return data;
  }
}