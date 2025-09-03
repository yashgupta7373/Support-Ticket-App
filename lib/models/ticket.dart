class Ticket {
  final String id;
  final String transactionId;
  final String category;
  final String description;
  final String screenshotPath;
  String status; // open, pending, resolved

  Ticket({
    required this.id,
    required this.transactionId,
    required this.category,
    required this.description,
    required this.screenshotPath,
    this.status = "Open",
  });

  // Convert Ticket -> Map (for storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionId': transactionId,
      'category': category,
      'description': description,
      'screenshotPath': screenshotPath,
      'status': status,
    };
  }

  // Convert Map -> Ticket (for retrieval)
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      transactionId: map['transactionId'],
      category: map['category'],
      description: map['description'],
      screenshotPath: map['screenshotPath'],
      status: map['status'],
    );
  }
}
