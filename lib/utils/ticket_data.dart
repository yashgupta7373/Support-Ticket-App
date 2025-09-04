import 'package:flutter/material.dart';
import '../utils/colors.dart';

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

// Function to get status color
Color getStatusColor(String status) {
  switch (status) {
    case "Resolved":
      return AppColors.resolved;
    case "Pending":
      return AppColors.pending;
    case "Open":
      return AppColors.open;
    default:
      return AppColors.dflt;
  }
}

// Dummy chat messages for tickets
List<Map<String, String>> dummyChatMessages = [
  {"sender": "User", "message": "I raised this issue yesterday."},
  {"sender": "Support", "message": "Thanks! We are looking into it."},
];

