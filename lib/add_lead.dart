//This page I havn't used in my project. I have used onborading.dart and main.dart instead of this page.
//I have used this page for testing purpose only.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:post_api/lead_page.dart';

class AddLeadPage extends StatefulWidget {
  final String notaryId;

  const AddLeadPage({Key? key, required this.notaryId}) : super(key: key);

  @override
  _AddLeadPageState createState() => _AddLeadPageState();
}

class _AddLeadPageState extends State<AddLeadPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> addLead(String firstName, String lastName, String email) async {
    final response = await http.post(
      Uri.parse('https://api.thenotary.app/lead/getLeads'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'notaryId': widget.notaryId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('Lead added successfully');
    } else {
      throw Exception('Failed to add lead');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lead'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                addLead(_firstNameController.text, _lastNameController.text,
                    _emailController.text);
              },
              child: const Text('Add Lead'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RetrieveLeadPage(
                      notaryId: widget.notaryId,
                    ),
                  ),
                );
              },
              child: const Text('see list'),
            ),
          ],
        ),
      ),
    );
  }
}
