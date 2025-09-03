import 'package:fintechticket/screens/splesh_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TicketApp());
}

class TicketApp extends StatelessWidget {
  const TicketApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neobyt Support Ticket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF874ECF)),
      ),
      home: const SplashScreen(),
    );
  }
}
