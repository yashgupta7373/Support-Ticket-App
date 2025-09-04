import 'package:fintechticket/screens/login_screen.dart';
import 'package:fintechticket/screens/raise_new_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';
import '../widgets/dashboard_card.dart';
import 'my_tickets.dart';

class DashboardScreen extends StatelessWidget {
  final String? userEmail;
  final String userName;

  const DashboardScreen({super.key, this.userEmail, this.userName = "User"});

  //logout button logic
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // clear login flag
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textSecondary),
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
                AppColors.accent,
                AppColors.primary,
                AppColors.accentDark,
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
              // user name
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    "Hi, $userName👋",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
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
                        DashboardCard(
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
                        DashboardCard(
                          title: "Raise\nNew Ticket",
                          onTap: () {
                            // Navigate to Raise new Ticket Page
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