import 'package:flutter/material.dart';

class PaymentReceiptPage extends StatelessWidget {
  final String eventTitle;
  final String eventDate;
  final String hostName;
  final String paymentMethod;
  final String recipient;
  final String transactionId;
  final double amountPaid;
  final double amountRemaining;

  const PaymentReceiptPage({
    Key? key,
    required this.eventTitle,
    required this.eventDate,
    required this.hostName,
    required this.paymentMethod,
    required this.recipient,
    required this.transactionId,
    required this.amountPaid,
    required this.amountRemaining,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Receipt',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'PAID',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.circle, color: Colors.green, size: 14),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/event_image.png', // Replace with your image
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Event Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(eventTitle, style: const TextStyle(fontSize: 15)),
            Text(
              eventDate,
              style: const TextStyle(color: Colors.orange, fontSize: 13),
            ),
            const SizedBox(height: 8),
            const Text('Host', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Hosted by $hostName',
              style: const TextStyle(color: Colors.orange),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Info',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(paymentMethod),
            const SizedBox(height: 8),
            const Text(
              'Recipient',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(recipient),
            const SizedBox(height: 8),
            const Text(
              'Transaction ID',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              transactionId,
              style: const TextStyle(color: Colors.blue, fontSize: 13),
            ),
            const SizedBox(height: 8),
            const Text(
              'Amount Paid',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${amountPaid.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            const Text(
              'Amount Remaining',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('\$${amountRemaining.toStringAsFixed(2)}'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0ECE9),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Download'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7A46A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Share'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD7A46A),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 40,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Back to Dashboard',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
