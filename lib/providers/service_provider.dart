import 'package:flutter/foundation.dart';
import '../models/service_ticket.dart';

class ServiceProvider extends ChangeNotifier {
  final List<ServiceTicket> _tickets = [];

  List<ServiceTicket> get tickets => List.unmodifiable(_tickets);

  void createTicket({required String title, required String description}) {
    final ticket = ServiceTicket(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim().isEmpty ? 'Support Request' : title.trim(),
      description: description.trim().isEmpty ? 'No description' : description.trim(),
      createdAt: DateTime.now(),
      status: 'Open',
    );
    _tickets.insert(0, ticket);
    notifyListeners();
  }

  void clearTickets() {
    _tickets.clear();
    notifyListeners();
  }
}
