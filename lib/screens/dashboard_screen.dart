import 'package:fintechticket/screens/login_screen.dart';
import 'package:fintechticket/screens/raise_new_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_tickets.dart';

class DashboardScreen extends StatelessWidget {
  final String? userEmail; // you can pass logged in user email/phone
  final String userName; //user name

  DashboardScreen({super.key, this.userEmail, this.userName = "User"});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // clear login flag

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false, // remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Color(0xFF874ECF),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF874ECF)),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xB0874ECF),
                Color(0xFF874ECF),
                Colors.deepPurpleAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              // Welcome text
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Hi, $userName👋",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Dashboard options
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // My Tickets card
                        _buildDashboardCard(
                          title: "My\nTicket",
                          onTap: () {
                            // Navigate to My Tickets Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MyTicketScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 50),
                        // Raise Ticket card
                        _buildDashboardCard(
                          title: "Raise\nNew Ticket",
                          onTap: () {
                            // Navigate to Raise Ticket Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RaiseTicketScreen(),
                              ),
                            );
                          },
                        ),
                      ],
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

//Reusable Dashboard Card
Widget _buildDashboardCard({
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: 180,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // softer shadow
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(2, 4), // shadow position
          ),
        ],
        border: Border.all(color: Color(0xFF874ECF), width: 2),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            fontFamily: 'UbuntuBold',
            color: Color(0xDB874ECF),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
