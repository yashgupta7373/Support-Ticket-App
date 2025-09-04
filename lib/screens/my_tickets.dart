import 'package:flutter/material.dart';
import '../utils/ticket_data.dart';
import 'ticket_detail_screen.dart';
import '../utils/colors.dart';

class MyTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Tickets",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        elevation: 2,
        backgroundColor: AppColors.primary,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(ticket["status"]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket["status"],
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
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

