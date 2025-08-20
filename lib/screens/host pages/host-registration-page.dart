import 'package:flutter/material.dart';
import 'package:parttime/screens/host%20pages/host_dash.dart';

class HostRegistrationPage extends StatefulWidget {
  const HostRegistrationPage({Key? key}) : super(key: key);

  @override
  State<HostRegistrationPage> createState() => _HostRegistrationPageState();
}

class _HostRegistrationPageState extends State<HostRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _aadharController = TextEditingController();
  final _agencyController = TextEditingController();
  final _managerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool _aadharVerified = false;
  bool _isVerifying = false;
  bool _isRegistering = false;

  final Color fieldBg = const Color(0xFFF5F5F7);
  final Color buttonColor = const Color(0xFFE8C28E);

  @override
  void dispose() {
    _aadharController.dispose();
    _agencyController.dispose();
    _managerController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _verifyAadhar() async {
    final aadhar = _aadharController.text.trim();
    if (aadhar.isEmpty ||
        aadhar.length != 12 ||
        !RegExp(r'^\d{12}$').hasMatch(aadhar)) {
      _showSnack('Please enter a valid 12-digit Aadhar number');
      return;
    }

    setState(() => _isVerifying = true);

    await Future.delayed(const Duration(seconds: 1)); // simulate API

    setState(() {
      _aadharVerified = true;
      _isVerifying = false;
    });

    _showSnack('Aadhar verified successfully ✅');
  }

  void _register() async {
    // if (!_aadharVerified) {
    //   _showSnack('Please verify Aadhar first');
    //   return;
    // }

    // if (!_formKey.currentState!.validate()) return;

    // setState(() => _isRegistering = true);

    // await Future.delayed(const Duration(seconds: 2)); // simulate API

    // setState(() => _isRegistering = false);

    // _showSnack('Registration successful 🎉');
    Navigator.push(context, MaterialPageRoute(builder: (context) => HostDashboardPage()));
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: fieldBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Registration',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Aadhar Number
              const Text(
                'Aadhar Number',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _aadharController,
                decoration: _inputDecoration('Enter your Aadhar number'),
                keyboardType: TextInputType.number,
                maxLength: 12,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Aadhar number is required';
                  }
                  if (val.length != 12 || !RegExp(r'^\d{12}$').hasMatch(val)) {
                    return 'Enter a valid 12-digit Aadhar number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _isVerifying ? null : _verifyAadhar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isVerifying
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Verify Aadhar',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Name of Agency
              const Text(
                'Name of Agency',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _agencyController,
                decoration: _inputDecoration('Enter Agency name'),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Agency name is required'
                    : null,
              ),
              const SizedBox(height: 20),

              // Manager Name
              const Text(
                'Manager Name',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _managerController,
                decoration: _inputDecoration('Enter manager name'),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Manager name is required'
                    : null,
              ),
              const SizedBox(height: 20),

              // Phone Number
              const Text(
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _phoneController,
                decoration: _inputDecoration('Enter your phone number'),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(val)) {
                    return 'Enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Email ID
              const Text(
                'Email ID',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration('Enter your email ID'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 26),

              // Register Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isRegistering ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isRegistering
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Register',
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
      ),
    );
  }
}
