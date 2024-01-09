import 'package:flutter/material.dart';
import 'package:post_api/introscreen/intro_page1.dart';
import 'package:post_api/introscreen/intro_page2.dart';
import 'package:post_api/introscreen/intro_page3.dart';
import 'package:post_api/lead_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding_screen extends StatefulWidget {
  const Onboarding_screen({super.key});

  @override
  State<Onboarding_screen> createState() => _Onboarding_screenState();
}

class _Onboarding_screenState extends State<Onboarding_screen> {
  //keeping track of page
  PageController _controller = PageController();
  //omn last page
  bool lastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          onPageChanged: (Index) {
            setState(() {
              lastpage = (Index == 2);
            });
          },
          controller: _controller,
          children: const [
            Intro_page1(),
            Intro_page2(),
            Intro_page3(),
          ],
        ),

        //dot indicator
        Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(3);
                    },
                    child: const Text('SKIP')),
                SmoothPageIndicator(controller: _controller, count: 3),
                lastpage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RetrieveLeadPage(
                                        notaryId: '643074200605c500112e0902',
                                      )));
                        },
                        child: const Text('DONE'))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text('NEXT'))
              ],
            ))
      ]),
    );
  }
}
