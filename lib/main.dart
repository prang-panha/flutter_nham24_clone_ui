import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  int pageCount = 3;
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!pageController.hasClients) {
        return;
      }
      if (pageController.page! >= pageCount - 1) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: SizedBox(
          width: 100,
          child: Image.asset(
            "assets/logo.png",
            color: Colors.blue,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "Your Location",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      Icons.location_on,
                      size: 18,
                    )
                  ],
                ),
                Text(
                  "CURRENT LOCATION",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            LimitedBox(
              maxHeight: 250,
              child: Stack(
                children: [
                  PageView(
                    controller: pageController,
                    children: const [
                      AdsSlideCard(
                        slideImage: "assets/f1.jpg",
                      ),
                      AdsSlideCard(
                        slideImage: "assets/f3.jpg",
                      ),
                      AdsSlideCard(
                        slideImage: "assets/f4.jpg",
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 18.0,
                    left: 0.0,
                    right: 0.0,
                    child: Center(
                      child: SlideIndicator(
                        pageController: pageController,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  MenuFeature(iconAsset: "assets/m_tuktuk.png", name: "Taxi"),
                  MenuFeature(
                    iconAsset: "assets/m_express.png",
                    name: "Express",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_food.png",
                    name: "Food",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_grocery.png",
                    name: "Grocery",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_flower.png",
                    name: "Flower",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_shop.png",
                    name: "Shop",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_bakery.png",
                    name: "Bakery",
                  ),
                  MenuFeature(
                    iconAsset: "assets/m_alcohol.png",
                    name: "Alcohol",
                  )
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Trending Now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LimitedBox(
                maxHeight: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [TrendingCard(), TrendingCard(), TrendingCard()],
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 8,
            ),
            const PromoteShopCard(
              image: "assets/f8.jpg",
            ),
            const PromoteShopCard(
              image: "assets/f9.jpg",
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ("Track")),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox), label: ("Inbox")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: ("Account")),
        ],
      ),
    );
  }
}



class SlideIndicator extends StatelessWidget {
  const SlideIndicator({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(3, buildIndicator),
    );
  }

  Widget buildIndicator(int index) {
    print("build $index");
    double select = max(
      0.0,
      1.0 - ((pageController.page ?? pageController.initialPage) - index).abs(),
    );
    double decrease = 10 * select;
    return Container(
      width: 30,
      child: Center(
        child: Container(
          width: 20 - decrease,
          height: 4,
          decoration: BoxDecoration(
              color: decrease == 10.0 ? Colors.blue : Colors.black,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}



class PromoteShopCard extends StatelessWidget {
  const PromoteShopCard({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}



class TrendingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 200,
        width: 250,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/f7.jpg",
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
class MenuFeature extends StatelessWidget {
  const MenuFeature({super.key, required this.iconAsset, required this.name});
  final String iconAsset;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 50, height: 50, child: Image.asset(iconAsset)),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}


class AdsSlideCard extends StatelessWidget {
  const AdsSlideCard({super.key, required this.slideImage});
  final String slideImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 200,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                slideImage,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}

