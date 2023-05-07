import 'package:flutter/material.dart';
import 'package:news_reader/common/utils/pref_opreator.dart';
import 'package:news_reader/config/app_topic_constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_reader/features/feature_home/presentation/screens/home_screen.dart';
import 'package:news_reader/locator.dart';

class SelectTopicScreen extends StatefulWidget {
  static const String routeName = '/select-topics';
  const SelectTopicScreen({super.key});

  @override
  State<SelectTopicScreen> createState() => _SelectTopicScreenState();
}

class _SelectTopicScreenState extends State<SelectTopicScreen> {
  @override
  List<String> selectedTopics = [];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomNavigationBar: Container(
          width: size.width,
          height: size.height * 0.09,
          // color: Colors.amber,
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () async {
              if (selectedTopics.isEmpty) {
                _showEmptyBanner();
              } else {
                await locator<PrefOperator>()
                    .saveUserTopics(selectedTopics)
                    .then((value) => Navigator.of(context).pushReplacementNamed(
                          HomeScreen.routeName,
                        ));
              }
            },
            child: Text('Next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Choose your Topic',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(20),
                height: size.height,
                width: size.width,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: topics
                      .map((e) => InkWell(
                            onTap: () {
                              if (!selectedTopics.contains(e) &&
                                  selectedTopics.length <= 3) {
                                setState(() {
                                  selectedTopics.add(e);
                                });
                                print(selectedTopics);
                              } else if (selectedTopics.contains(e)) {
                                setState(() {
                                  selectedTopics.remove(e);
                                });
                                print(selectedTopics);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showMaterialBanner(MaterialBanner(
                                        content: Text(
                                            'This time you could select only 4 topics'),
                                        actions: [
                                      TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentMaterialBanner();
                                          },
                                          child: Text('ok'))
                                    ]));
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                e.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedTopics.contains(e)
                                      ? Colors.white
                                      : Colors.blue[800],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selectedTopics.contains(e)
                                      ? Colors.blue[800]
                                      : null,
                                  border: Border.all(
                                      width: 2.5, color: Colors.blue[800]!)),
                            ),
                          ))
                      .toList(),
                )),
          ),
        ));
  }

  _showEmptyBanner() =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: Text('You should select 3 topics at least'),
          actions: [
            TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
                child: Text('ok'))
          ]));
}
