import 'package:flutter/material.dart';
import '../widgets/party_list_item.dart';

class PartiesScreen extends StatelessWidget {
  const PartiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parties',
              style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
            ),
            Text(
              '5 customers • ₹46,350 due',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search customer',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL RECEIVABLE',
                      style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '₹46,350',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.book, color: Colors.yellow, size: 30),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: const [
                PartyListItem(
                  name: 'Anand Kirana Stores',
                  phone: '+91 99000 11122',
                  amount: '₹12,450',
                  status: 'due',
                  initial: 'A',
                  color: Colors.blue,
                ),
                PartyListItem(
                  name: 'Bharath Hardware',
                  phone: '+91 98801 23344',
                  amount: 'SETTLED',
                  status: '',
                  initial: 'B',
                  color: Colors.lightBlue,
                ),
                PartyListItem(
                  name: 'Citylight Electricals',
                  phone: '+91 90000 55667',
                  amount: '₹8,900',
                  status: 'due',
                  initial: 'C',
                  color: Colors.blueAccent,
                ),
                PartyListItem(
                  name: 'Devi Provision',
                  phone: '+91 96320 77889',
                  amount: '₹3,200',
                  status: 'due',
                  initial: 'D',
                  color: Colors.blueGrey,
                ),
                PartyListItem(
                  name: 'Everest Mart',
                  phone: '+91 99888 22110',
                  amount: '₹21,800',
                  status: 'due',
                  initial: 'E',
                  color: Colors.indigo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
