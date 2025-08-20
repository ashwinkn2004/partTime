import 'package:flutter/material.dart';
import 'package:parttime/screens/host%20pages/payment_page_2.dart';

class AdvancePaymentPage extends StatefulWidget {
  const AdvancePaymentPage({Key? key}) : super(key: key);

  @override
  State<AdvancePaymentPage> createState() => _AdvancePaymentPageState();
}

class _AdvancePaymentPageState extends State<AdvancePaymentPage> {
  String? selectedPaymentMethod;
  final TextEditingController promoCodeController = TextEditingController();
  bool isPaying = false;

  // Define the startDate variable with a sample date
  final DateTime startDate = DateTime(2024, 7, 15);

  final Color sectionTitleColor = Colors.black;
  final Color lightTextColor = Colors.grey.shade600;
  final Color buttonColor = const Color(0xFFE8C28E);

  String _fmtDate(DateTime date) {
    // Format as 'July 15, 2024'
    return "${_monthName(date.month)} ${date.day}, ${date.year}";
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _payAndRegister() async {
    // if (selectedPaymentMethod == null) {
    //   _showSnack('Please select a payment method');
    //   return;
    // }

    // setState(() => isPaying = true);
    // await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    // setState(() => isPaying = false);

    // _showSnack('Payment Successful & Event Registered 🎉');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessPage(
          eventTitle: 'Sample Event',
          eventDate: _fmtDate(startDate),
          eventImage: 'assets/sample_event_image.png', eventName: '', // replace with actual image
        ),
      ),
    );
  }

  Widget _paymentOption(String method, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedPaymentMethod = method);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedPaymentMethod == method
              ? buttonColor.withOpacity(0.4)
              : const Color(0xFFF5F5F7),
          border: Border.all(
            color: selectedPaymentMethod == method
                ? buttonColor
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.brown),
            const SizedBox(width: 10),
            Text(method, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _billingRow(String title, String subtitle, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: lightTextColor)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Advance Payment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Venue Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Venue',
                        style: TextStyle(color: lightTextColor, fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'The Grand Ballroom',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '123 Main Street, Anytown',
                        style: TextStyle(color: lightTextColor),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/event.jpg', // Replace with your image
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Billing Breakdown
            Text(
              'Billing Breakdown',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: sectionTitleColor,
              ),
            ),
            const SizedBox(height: 10),
            _billingRow('Staff', 'Event Coordinators, Security', '\$1,500'),
            _billingRow(
              'Additional Charges',
              'Overtime, Special Requests',
              '\$500',
            ),
            _billingRow('Tax', 'Applicable Taxes', '\$250'),
            _billingRow('Predicted Total', 'Estimated Total Cost', '\$2,250'),
            _billingRow('Advance to Pay Now', '25% of Total', '\$562.50'),
            const SizedBox(height: 4),
            Text(
              'Remaining balance of \$1,687.50 will be due 30 days before the event.',
              style: TextStyle(color: lightTextColor, fontSize: 13),
            ),

            const SizedBox(height: 20),

            // Payment Options
            Text(
              'Payment Options',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: sectionTitleColor,
              ),
            ),
            const SizedBox(height: 10),
            _paymentOption('UPI', Icons.currency_rupee),
            const SizedBox(height: 10),
            _paymentOption('Debit/Credit Card', Icons.credit_card),
            const SizedBox(height: 10),
            _paymentOption('Net Banking', Icons.account_balance),

            const SizedBox(height: 16),

            // Promo Code
            TextFormField(
              controller: promoCodeController,
              decoration: InputDecoration(
                hintText: 'Promo Code (Optional)',
                filled: true,
                fillColor: const Color(0xFFF5F5F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Preview Invoice
            GestureDetector(
              onTap: () => _showSnack('Invoice preview coming soon!'),
              child: Row(
                children: const [
                  Text(
                    'Preview Invoice',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.copy, size: 18),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Pay & Register Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: isPaying ? null : _payAndRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: isPaying
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        'Pay & Register Event',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page_outlined),
            label: 'Requests',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
