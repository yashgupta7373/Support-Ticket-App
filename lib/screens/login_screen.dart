import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? generatedOtp; // store OTP

  // Generate random OTP
  String generateOTP() {
    var rng = Random();
    return (1000 + rng.nextInt(9000)).toString(); // 4-digit OTP
  }

  Future<void> setLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // show snack bar function
  void _showSnackBar(String message, {Color bgColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }

  // handle get otp button
  void _handleGetVerificationCode() {
    if (emailController.text.isNotEmpty) {
      setState(() => generatedOtp = generateOTP());
      _showSnackBar("OTP Sent: $generatedOtp (demo only)", bgColor: AppColors.resolved);
    } else {
      _showSnackBar("Enter Email/Phone first", bgColor: AppColors.open);
    }
  }

  // handel login button
  void _handleLoginButton() {
    String enteredOtp = otpController.text.trim();

    if (emailController.text.isEmpty ||
        enteredOtp.isEmpty) {
      _showSnackBar("Please fill all fields", bgColor: AppColors.open);
      return;
    }

    if (enteredOtp == generatedOtp) {
      setLoggedIn();
      _showSnackBar("Login Successful!", bgColor: AppColors.resolved);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => DashboardScreen(
                userEmail: emailController.text)),
      );
    } else {
      _showSnackBar("Invalid OTP", bgColor: AppColors.open);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.primary),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header with logo and title
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/neobytLogo.png',
                    height: 60,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Neobyt',
                    style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // login form
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                        const SizedBox(height: 40),

                        // Email/Phone field
                        CustomInputField(
                          controller: emailController,
                          label: "Email or Phone",
                          hint: "Enter registered email/phone no.",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        // Get OTP button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _handleGetVerificationCode,
                            child: const Text(
                              "Get verification code",
                              style: TextStyle(
                                  color: Color(0xFF874ECF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // OTP field
                        CustomInputField(
                          controller: otpController,
                          label: "OTP",
                          hint: "Enter 4-digit OTP",
                          icon: Icons.verified,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        ),
                        const SizedBox(height: 30),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: "Login",
                            onPressed: _handleLoginButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
