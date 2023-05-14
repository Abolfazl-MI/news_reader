import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_reader/common/widgets/cached_image_widget.dart';
import 'package:news_reader/common/widgets/custome_shimmerh_loading.dart';
import 'package:news_reader/features/feature_home/data/models/headline_model/headline_model.dart';
import 'package:news_reader/features/feature_home/data/models/news_model/news_model.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/head_line_cubit/headline_cubit.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/home_data_status.dart';
import 'package:news_reader/features/feature_home/presentation/bloc/topic_cubit/topic_news_cubit.dart';
import 'package:news_reader/gen/assets.gen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late PageController _headLindePageController;
  @override
  void initState() {
    super.initState();
    _headLindePageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // bottomNavigationBar: BottomNavigationWidget(size: size),
        body: SizedBox(
      width: size.width,
      height: size.height,
      // color: Colors.amber,
      child: Column(
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 500),
            child: _appBar(size),
          ),
          const SizedBox(
            height: 10,
          ),
          FadeIn(
            child: _searchBar(),
            duration: const Duration(
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
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      /// headline news!
                      FadeIn(
                        duration: const Duration(milliseconds: 600),
                        child: Shimmer(
                          linearGradient: shimmerGradient,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              // color: Colors.green,
                              width: size.width,
                              child: Column(
                                children: [
                                  ShimmerLoading(
                                    isLoading: context
                                            .watch<HeadLineCubit>()
                                            .state is HomeDataLoadingState
                                        ? true
                                        : false,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Trending',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'See all',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  BlocBuilder<HeadLineCubit, HomeDataState>(
                                    builder: (context, state) {
                                      return ShimmerLoading(
                                        isLoading: state is HomeDataLoadingState
                                            ? true
                                            : false,
                                        child: SizedBox(
                                          width: size.width,
                                          height: size.height * 0.45,
                                          child: PageView.builder(
                                              controller:
                                                  _headLindePageController,
                                              itemCount: state
                                                      is HomeDataLoadingState
                                                  ? 10
                                                  : state is HomeDataLoadedState
                                                      ? state.data.length
                                                      : 0,
                                              itemBuilder: (context, index) {
                                                return _headLineWidget(size,
                                                    headLineNewsModel: state
                                                            is HomeDataLoadedState
                                                        ? state.data[index]
                                                        : null);
                                              }),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  BlocBuilder<HeadLineCubit, HomeDataState>(
                                      builder: (context, state) {
                                    return ShimmerLoading(
                                      isLoading: state is HomeDataLoadingState
                                          ? true
                                          : false,
                                      child: SmoothPageIndicator(
                                        controller: _headLindePageController,
                                        count: state is HomeDataLoadingState
                                            ? 10
                                            : state is HomeDataLoadedState
                                                ? state.data.length
                                                : 0,
                                        effect: const WormEffect(),
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // latest news
                      _topic_tab_selector(size),
                      const SizedBox(height: 10),
                      _topic_list_view(size),
                      const SizedBox(height: 20),
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

  BlocBuilder<TopicCubit, TopicCubitState> _topic_list_view(Size size) {
    return BlocBuilder<TopicCubit, TopicCubitState>(builder: ((context, state) {
      if (state.topicDataSate is HomeDataLoadedState ||
          state.topicDataSate is HomeDataLoadingState) {
        HomeDataState topicState = state.topicDataSate;
        return Shimmer(
          linearGradient: shimmerGradient,
          child: ShimmerLoading(
            isLoading:
                state.topicDataSate is HomeDataLoadingState ? true : false,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              // color: Colors.green,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: topicState is HomeDataLoadedState
                    ? topicState.data.length
                    : 20,
                itemBuilder: ((context, index) {
                  NewsModel? newsModel = topicState is HomeDataLoadedState
                      ? topicState.data[index]
                      : null;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CachedImage(
                          imageUrl: newsModel?.urlToImage ??
                              'https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg',
                          width: 100,
                          height: 100,
                          borderRadius: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                newsModel?.title ??
                                    "Venmo now lets you send crypto to other users for some reason",
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(newsModel?.source?.name ?? 'BBC-NEws'),
                                    Row(
                                      // mainAxisAlignment:
                                      children: [
                                        const Icon(CupertinoIcons.clock),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(newsModel?.getTimeDifference() ??
                                            '4h ago'),
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
              ),
            ),
          ),
        );
      }
      return Container();
    }));
  }

  BlocBuilder<TopicCubit, TopicCubitState> _topic_tab_selector(Size size) {
    return BlocBuilder<TopicCubit, TopicCubitState>(builder: (context, state) {
      if (state.topicDataSate is HomeDataLoadingState ||
          state.topicDataSate is HomeDataLoadedState) {
        return Shimmer(
          linearGradient: shimmerGradient,
          child: SizedBox(
              width: size.width,
              height: size.height * 0.05,
              // color: Colors.yellow,
              child: ShimmerLoading(
                isLoading:
                    state.topicDataSate is HomeDataLoadingState ? true : false,
                child: PageView.builder(
                  itemCount: context.watch<TopicCubit>().userTopic.length,
                  padEnds: false,
                  controller: PageController(viewportFraction: 0.25),
                  itemBuilder: ((context, index) {
                    List<String> topics = context.watch<TopicCubit>().userTopic;
                    return Center(
                      child: InkWell(
                        onTap: () {
                          print(topics[index]);
                          context.read<TopicCubit>().updateIndex(index);
                          context
                              .read<TopicCubit>()
                              .fetchTopicNews(topics[index]);
                        },
                        child: Container(
                          child: Text(
                            topics[index],
                            style: TextStyle(
                              fontSize: state.selectedIndex == index ? 18 : 15,
                              fontWeight: state.selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )),
        );
      }
      if (state.topicDataSate is HomeDataErrorState) {
        var mineState = state.topicDataSate as HomeDataErrorState;
        return SizedBox(
          width: size.width,
          height: size.height * 0.04,
          // color: Colors.red,
          child: const Center(
              // child: Text(mineState.error),
              ),
        );
      }
      return Container();
    });
  }

/* 
 */
  _headLineWidget(Size size, {HeadLineNewsModel? headLineNewsModel}) {
    return Container(
      padding: const EdgeInsets.all(5),
      // color: Colors.green,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedImage(
            imageUrl: headLineNewsModel?.urlToImage ??
                'https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg',
            width: size.width,
            height: size.height * 0.25,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            headLineNewsModel?.title ??
                "Venmo now lets you send crypto to other users for some reason",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('BBC News'),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  // mainAxisAlignment:
                  children: [
                    const Icon(CupertinoIcons.clock),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(headLineNewsModel?.getTimeDifference() ?? '4h ago'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              CupertinoIcons.slider_horizontal_3,
            ),
            onPressed: () {},
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
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
      padding: const EdgeInsets.all(10),
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
            icon: const Icon(
              CupertinoIcons.bell,
            ),
          )
        ],
      ),
    );
  }
}
