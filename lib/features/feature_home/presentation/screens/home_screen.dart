import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_reader/common/widgets/cached_image_widget.dart';
import 'package:news_reader/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> _categories = [
    'Bussines',
    'Curency',
    'Car',
    'War',
    'Love',
  ];
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // bottomNavigationBar: BottomNavigationWidget(size: size),
        body: Container(
          width: size.width,
          height: size.height,
          // color: Colors.amber,
          child: Column(
            children: [
              FadeIn(
                duration: Duration(milliseconds: 500),
                child: _appBar(size),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeIn(
                child: _searchBar(),
                duration: Duration(
                  milliseconds: 550,
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Expanded(
                child: Container(
                  // color: Colors.red,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: size.width,
                      child: Column(
                        children: [
                          /// headline news!
                          FadeIn(
                            duration: Duration(milliseconds: 600),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Trending',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'See all',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CachedImage(
                                      imageUrl:
                                          'https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg',
                                      width: size.width,
                                      height: size.height * 0.25,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Venmo now lets you send crypto to other users for some reason",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('BBC News'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            // mainAxisAlignment:
                                            children: [
                                              Icon(CupertinoIcons.clock),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text('4h ago'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // latest news
                          FadeIn(
                            duration: Duration(milliseconds: 650),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: size.width,
                                child: Column(
                                  children: [
                                    // last text and show more
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Latest',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'See all',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                    // tab bar
                                    SizedBox(
                                      width: size.width,
                                      height: size.height * 0.06,
                                      // color: Colors.amber,
                                      child: TabBar(
                                        physics: BouncingScrollPhysics(),
                                        isScrollable: true,
                                        controller: _tabController,
                                        tabs: _categories
                                            .map((e) => Tab(
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: size.width,
                                        height: size.height * 0.4,
                                        // color: Colors.amber,
                                        child: TabBarView(
                                          physics: BouncingScrollPhysics(),
                                          controller: _tabController,
                                          children: _categories
                                              .map((e) => ListView.builder(
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: 20,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            CachedImage(
                                                              imageUrl:
                                                                  'https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg',
                                                              width: 100,
                                                              height: 100,
                                                              borderRadius: 12,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Venmo now lets you send crypto to other users for some reason",
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            'BBC-NEws'),
                                                                        Row(
                                                                          // mainAxisAlignment:
                                                                          children: [
                                                                            Icon(CupertinoIcons.clock),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text('4h ago'),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ))
                                              .toList(),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              CupertinoIcons.slider_horizontal_3,
            ),
            onPressed: () {},
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
            ),
          ),
        ),
      ),
    );
  }

  _appBar(Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.all(10),
      // height: size.height * 0.09,
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
            scale: 0.8,
            child: SvgPicture.asset(Assets.icons.logo2),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.bell,
            ),
          )
        ],
      ),
    );
  }
}



