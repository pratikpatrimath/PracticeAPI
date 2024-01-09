import 'package:flutter/material.dart';
// import 'package:post_api/add_lead.dart';
import 'package:post_api/lead_page.dart';
import 'package:post_api/onborading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: AddLeadPage(notaryId: '643074200605c500112e0902'));
        home: const Onboarding_screen());
  }
}
