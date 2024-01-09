import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RetrieveLeadPage extends StatefulWidget {
  final String notaryId;

  const RetrieveLeadPage({Key? key, required this.notaryId}) : super(key: key);

  @override
  _RetrieveLeadPageState createState() => _RetrieveLeadPageState();
}

class _RetrieveLeadPageState extends State<RetrieveLeadPage> {
  late Future<List<dynamic>> futureLeads;
  String filter = '';

  Future<List<dynamic>> fetchLeads() async {
    final response = await http.post(
      Uri.parse('https://api.thenotary.app/lead/getLeads'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'notaryId': widget.notaryId,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['leads']; // assuming 'leads' is the key containing the list
    } else {
      throw Exception('Failed to load leads');
    }
  }

  @override
  void initState() {
    super.initState();
    futureLeads = fetchLeads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Leads'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: futureLeads,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var filteredLeads = snapshot.data?.where((lead) {
                  var leadName = '${lead['firstName']} ${lead['lastName']}';
                  return leadName.toLowerCase().contains(filter.toLowerCase());
                }).toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredLeads?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '${filteredLeads?[index]['firstName']} ${filteredLeads?[index]['lastName']}'),
                        subtitle: Text(filteredLeads?[index]['email']),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
