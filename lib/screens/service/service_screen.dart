import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/service_provider.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<ServiceProvider>();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('SERVICE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.grey.shade900)),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create Support Ticket', style: TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.read<ServiceProvider>().createTicket(
                            title: titleCtrl.text,
                            description: descCtrl.text,
                          );
                      titleCtrl.clear();
                      descCtrl.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ticket created')));
                    },
                    child: const Text('Submit'),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const Text('My Tickets', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              const Spacer(),
              TextButton(
                onPressed: () => context.read<ServiceProvider>().clearTickets(),
                child: const Text('Clear'),
              )
            ],
          ),

          if (sp.tickets.isEmpty)
            const Text('No tickets yet.')
          else
            ...sp.tickets.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.title, style: const TextStyle(fontWeight: FontWeight.w900)),
                        const SizedBox(height: 6),
                        Text(t.description, style: TextStyle(color: Colors.grey.shade700)),
                        const SizedBox(height: 8),
                        Text('Status: ${t.status}', style: const TextStyle(fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
