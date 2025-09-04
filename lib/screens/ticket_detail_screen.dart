import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/ticket_data.dart';

class TicketDetailScreen extends StatefulWidget {
  final Map<String, dynamic> ticket;
  const TicketDetailScreen({super.key, required this.ticket});

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Use the dummy chat from utils
  List<Map<String, String>> chatMessages = List.from(dummyChatMessages);

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        chatMessages.add({
          "sender": "User",
          "message": _messageController.text.trim(),
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ticket Details",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        elevation: 2,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          // Status
          Container(
            width: double.infinity,
            color: getStatusColor(ticket["status"]), // use utils function
            padding: EdgeInsets.all(12),
            child: Text(
              "Status: ${ticket["status"]}",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Ticket Info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ticket ID: ${ticket["ticketId"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Transaction ID: ${ticket["transactionId"]}"),
                Text("Category: ${ticket["category"]}"),
                Text("Description: ${ticket["description"]}"),
                Divider(),
                Text("Conversation:", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Chat Thread
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final chat = chatMessages[index];
                final isUser = chat["sender"] == "User";

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primary : AppColors.dflt,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      chat["message"]!,
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input Box
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.accentDark, size: 30),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
