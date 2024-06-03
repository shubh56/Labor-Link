import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laborlink/core/app_export.dart';

import '../../../../models/bookings.dart';


class BookingCard extends StatelessWidget {
  final Bookings booking;
  const BookingCard({required this.booking});
  @override
  Widget build(BuildContext context) {
    RegExp regExp = RegExp(r"(\d{2})-(\d{2})-(\d{4})");
    Match match = regExp.firstMatch(booking.bookingDate)!;
    int day = int.parse(match.group(1)!);
    int month = int.parse(match.group(2)!);
    int year = int.parse(match.group(3)!);
    DateTime date = DateTime(year,month,day);
    print(date);

    // print(booking.workerId);
    return Container(
      width: Get.width*0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.height*0.02),
        color: darkPurple,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Customer ID: "+booking.customerId,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: Get.height*0.015,
            ),
          ),
          Text(
            textAlign: TextAlign.left,
            "Job Date: "+booking.bookingDate,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: Get.height*0.015,
            ),
          ),
           Text(
            textAlign: TextAlign.left,
            "Booking Status: "+booking.bookingStatus,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: Get.height*0.015,
            ),
          ),
          Text(
            textAlign: TextAlign.left,
            "Job Type: "+booking.jobType,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: Get.height*0.015,
            ),
          ),
          Divider(height: Get.height*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(Get.height*0.02)),
                ),
                onPressed: (){},
                child: Text(
                  'More Details',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: darkPurple,
                    fontSize: Get.height*0.015,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(Get.height*0.02)),
                ),
                onPressed: (){},
                child: Text(
                  'Add to Calendar',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: darkPurple,
                    fontSize: Get.height*0.015,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
