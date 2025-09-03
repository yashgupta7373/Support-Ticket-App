import 'dart:math';

import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200)),
              ),
              child: Column(children: [
                // Logo
                Image.asset(
                  'assets/images/neobytLogo.png',
                  height: 60,
                ),
                SizedBox(height: 10),
                //Title
                Text('Neobyt', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40))
              ],),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Title
                        Text('Login', style: TextStyle(color: Color(0xFF874ECF), fontWeight: FontWeight.bold, fontSize: 40)),
                        SizedBox(height: 40),

                        //email or phone no..
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Color(0xFF874ECF)),
                            labelText: "Email or Phone",
                            hintText: "Enter registered email/phone no.",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        // get otp link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // send otp on registered email or phone number
                              if (emailController.text.isNotEmpty) {
                                setState(()=>generatedOtp = generateOTP());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "OTP Sent: $generatedOtp (demo only)"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter Email/Phone first")),
                                );
                              }
                            },
                            child: Text(
                              "get verification code",
                              style: TextStyle(color: Color(0xFF874ECF), fontWeight: FontWeight.bold, fontSize: 15)
                            )
                          ),
                        ),

                        const SizedBox(height: 10),

                        // otp field
                        TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password, color: Color(0xFF874ECF)),
                            labelText: "OTP",
                            hintText: "Enter OTP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              String enteredOtp = otpController.text.trim();

                              if (emailController.text.isEmpty ||
                                  enteredOtp.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Please fill all fields")),
                                );
                              }

                              if (enteredOtp == generatedOtp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Login Successful!")),
                                );
                                // Navigate to Dashboard Screen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => DashboardScreen(userEmail: emailController.text.trim())),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Invalid OTP")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF874ECF),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            )
            // Email / Phone field

          ],
        ),
      ),
    );
  }
}
