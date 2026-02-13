class ServiceTicket {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status; // Open / In Progress / Closed

  const ServiceTicket({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });
}
