import 'package:flutter/material.dart';
import 'ticket_detail_screen.dart';

class MyTicketScreen extends StatelessWidget {
  // Dummy list of tickets
  final List<Map<String, dynamic>> tickets = [
    {
      "ticketId": "TCK1234",
      "transactionId": "TXN5678",
      "category": "Payment",
      "description": "Payment failed but money deducted.",
      "status": "Open",
    },
    {
      "ticketId": "TCK5678",
      "transactionId": "TXN9999",
      "category": "Login Issue",
      "description": "Unable to login to my account.",
      "status": "Pending",
    },
    {
      "ticketId": "TCK9101",
      "transactionId": "TXN3333",
      "category": "Refund",
      "description": "Refund not received yet.",
      "status": "Resolved",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Resolved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Open":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tickets", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        )),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2,
        backgroundColor: const Color(0xFF874ECF),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text("Ticket ID: ${ticket["ticketId"]}"),
              subtitle: Text(ticket["description"]),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(ticket["status"]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket["status"],
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                // Navigate to ticket detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TicketDetailScreen(ticket: ticket),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
