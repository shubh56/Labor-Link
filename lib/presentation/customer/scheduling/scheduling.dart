import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';



class Scheduling extends StatefulWidget {
  const Scheduling({super.key});

  @override
  State<Scheduling> createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {

  final Razorpay _razorpay = Razorpay();
  String apiKey = 'rzp_test_gmYEMaZQHURIXl';
  String apiSecret = 'Q4Fr2vOMOlO6TtIpNTQFrIX2';

  Map<String, dynamic> paymentData = {
    'amount': 50000, // amount in paise (e.g., 1000 paise = Rs. 10)
    'currency': 'INR',
    'receipt': 'order_receipt',
    'payment_capture': '1',
  };

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }


  bool hasBeenPressed = false;
  int index = 1;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 2),
    ),
  );
  DateTime date = DateTime.now();
  String selectedDate = 'Click Here';
  Map<String, String> request = {
    'duration': 'Permanent',
  };
  @override
  Widget build(BuildContext context) {
    String workerName = Get.arguments[0];
    String email = Get.arguments[1];
    String profilePhoto = Get.arguments[2];
    final start = dateRange.start;
    final end = dateRange.end;
    final mediaQuery = MediaQuery.of(context);
    print('Worker Name: $workerName');
    print('Email: $email');
    print('Profile Photo: $profilePhoto');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: mediaQuery.size.height * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: mediaQuery.size.width * 0.04),
                child: Text(
                  'Select job duration for $workerName',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mediaQuery.size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
                width: double.maxFinite,
              ),
              ListTile(
                title: Text(
                  'Permanent',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mediaQuery.size.width * 0.05,
                  ),
                ),
                subtitle: Text(
                  'One-time job',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mediaQuery.size.width * 0.03,
                  ),
                ),
                trailing: index==1 ? const Icon(Icons.check, color: Colors.green) : const Icon(CupertinoIcons.multiply, color: Colors.red,),
                onTap: () {
                  setState(
                        () {
                      hasBeenPressed = !hasBeenPressed;
                      index = 1;
                      request["duration"] = 'Permanent';
                    },
                  );
                },
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
                width: double.maxFinite,
              ),
              ListTile(
                title: Text(
                  'Temporary',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mediaQuery.size.width * 0.05,
                  ),
                ),
                subtitle: Text(
                  'Recurring Job',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mediaQuery.size.width * 0.03,
                  ),
                ),
                trailing: index==2 ? const Icon(Icons.check, color: Colors.green) : const Icon(CupertinoIcons.multiply, color: Colors.red,),
                onTap: () {
                  setState(() {
                    hasBeenPressed = !hasBeenPressed;
                    index = 2;
                    request["duration"] = 'Temporary';
                  });
                },
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.03,
              ),
              ListTile(
                title: Text(
                  'Select Dates',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: mediaQuery.size.width * 0.05,
                  ),
                ),
                subtitle: TextButton(
                  onPressed: () async {
                    if (index == 2) {
                      DateTimeRange? newDateRange = await showDateRangePicker(
                        builder: (context, child){
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: darkPurple,
                                onPrimary: Colors.white,
                              ),
                            ), child: child!,
                          );
                        },

                        barrierColor: Colors.white,
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (newDateRange == null) return;

                      setState(() {
                        dateRange = newDateRange;
                        selectedDate =
                        "${newDateRange.start.day}/${newDateRange.start.month}/${newDateRange.start.year}-${newDateRange.end.day}/${newDateRange.end.month}/${newDateRange.end.year}";
                      });
                    } else {
                      DateTime? newDate = await showDatePicker(
                        builder: (context, child){
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: darkPurple,
                                onPrimary: Colors.white,
                              ),
                            ), child: child!,
                          );
                        },
                        barrierColor: Colors.white,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (newDate == null) return;
                      setState(() {
                        date = newDate;
                        selectedDate = "${date.day}/${date.month}/${date.year}";
                      });
                    }
                    request['selectedDate'] = selectedDate.toString();
                  },
                  child: Text(
                    selectedDate,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: mediaQuery.size.height * 0.02,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                    width: mediaQuery.size.width * 0.7,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        print(request);
                        initiatePayment();
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),),
              ),
            ],
          ),
        ),
      ),
    );
  }




  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // Here we get razorpay_payment_id razorpay_order_id razorpay_signature
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> initiatePayment() async {
    String apiUrl = 'https://api.razorpay.com/v1/orders';
    // Make the API request to create an order
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
      },
      body: jsonEncode(paymentData),
    );

    if (response.statusCode == 200) {
      // Parse the response to get the order ID
      var responseData = jsonDecode(response.body);
      String orderId = responseData['id'];

      // Set up the payment options
      var options = {
        'key': apiKey,
        'amount': paymentData['amount'],
        'name': Get.arguments[0],
        'order_id': orderId,
        'prefill': {'contact': '1234567890', 'email': Get.arguments[1]},
        'external': {
          'wallets': ['paytm'] // optional, for adding support for wallets
        }
      };

      // Open the Razorpay payment form
      _razorpay.open(options);
    } else {
      // Handle error response
      debugPrint('Error creating order: ${response.body}');
    }
  }
}
