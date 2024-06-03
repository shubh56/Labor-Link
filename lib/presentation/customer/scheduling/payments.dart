import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Payment Gateway Example',style: TextStyle(color: Colors.white),),
      ),
      body: Card(
        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
        child: ListTile(
          title: const Text("Special Chum Chum",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
          subtitle: const Text('Special Bengali Sweet'),
          trailing: ElevatedButton(
            onPressed: () {
              // checkout to payment
              initiatePayment();
            },
            child: const Text("Checkout"),
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
        'name': 'Sweet Corner',
        'order_id': orderId,
        'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
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
