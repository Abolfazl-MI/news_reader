import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_reader/common/screens/main_screen.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/features/feature_home/presentation/screens/home_screen.dart';
import 'package:news_reader/features/feature_select_topic/presentation/screens/select_topic_screen.dart';
import 'package:news_reader/gen/assets.gen.dart';
import 'package:news_reader/locator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = '/intro_screen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final PageController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  final List<String> _introImages = [
    Assets.image.bitcoinImage.path,
    Assets.image.foodImage.path,
    Assets.image.japanImage.path
  ];
  final List<String> _introStrings = [
    'Discover Economic news and its events',
    'Get know about last news about food health',
    'Learn from other cultures and them countries'
  ];
  final List<String> _introSubStrings = [
    'Economic is always hot and not predictable! discver the last changes with live events with us ',
    'Health of food,now days is big mature of world specially after COVID-19',
    'Knowing about other countries helps us to understand more about theme .'
  ];
  int current_index = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height / 1.6,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    current_index = index;
                  });
                },
                itemCount: _introImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _introImages[index],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 30,
              ),
              child: Text(
                _introStrings[current_index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Text(
                _introSubStrings[current_index],
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            // Spacer(),
            SizedBox(
              height: size.height * 0.10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dotedIndicator(current_index),
                  Row(
                    children: [
                      current_index >= 1
                          ? TextButton(
                              onPressed: () {
                                if (current_index <= 2) {
                                  current_index--;
                                  _controller.animateToPage(current_index,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                }
                              },
                              child: const Text(
                                'back',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Text(''),
                      ElevatedButton(
                        onPressed: () async {
                          if (current_index < 2) {
                            setState(() {
                              current_index++;
                              _controller.animateToPage(current_index,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            });
                          } else {
                            // changes the value to true to shown that use had seen the
                            //sliders then check if user had selected topics or not!
                            locator<PrefOperator>().changeIntroState(true);
                            // if topics where null then we navigate to select topic page
                            // else we navigate to home
                            List<String>? topics =
                                await locator<PrefOperator>().getUserTopics();
                            if (topics == null) {
                              Navigator.pushReplacementNamed(
                                  context, SelectTopicScreen.routeName);
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, MainScreen.routeName);
                            }
                          }
                        },
                        child: Text(current_index < 2 ? 'Next' : 'Continue'),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _dotedIndicator(int index) {
    return Row(
      children: [
        AnimatedContainer(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: index == 0 ? Colors.blue : Colors.grey,
              shape: BoxShape.circle),
          duration: const Duration(milliseconds: 300),
          // curve: ,
        ),
        const SizedBox(
          width: 5,
        ),
        AnimatedContainer(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: index == 1 ? Colors.blue : Colors.grey,
              shape: BoxShape.circle),
          duration: const Duration(milliseconds: 500),
        ),
        const SizedBox(
          width: 5,
        ),
        AnimatedContainer(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: index == 2 ? Colors.blue : Colors.grey,
              shape: BoxShape.circle),
          duration: const Duration(milliseconds: 500),
        )
      ],
    );
  }
}
