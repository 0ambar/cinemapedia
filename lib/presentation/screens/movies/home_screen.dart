import 'package:cinemapedia/presentation/views/people/popular_people_view.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';

  // final Widget childView;
  final int pageIndex;

  const HomeScreen({
    super.key, 
    // required this.childView, 
    required this.pageIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularPeopleView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex, 
        duration: const Duration(microseconds: 150), 
        curve: Curves.easeInOut
      );
    }

    return Scaffold(
      body: SafeArea(
        child: PageView(
          // index: widget.pageIndex,
          controller: pageController,
          children: viewRoutes
        ),
      ), 
      bottomNavigationBar: CustomBottomNavigation( currentIndex: widget.pageIndex ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
