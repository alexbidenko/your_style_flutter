import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:yourstyle/assets/consts.dart';
import 'package:yourstyle/models/offer.dart';
import 'package:yourstyle/pages/CatalogsPage.dart';
import 'package:yourstyle/pages/MainPage.dart';
import 'package:yourstyle/pages/ProfilePage.dart';
import 'package:yourstyle/pages/SearchPage.dart';
import 'package:yourstyle/pages/favoritsPage.dart';

import 'BasePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Style',
      theme: ThemeData(
        primarySwatch: PRIMARY
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new HomePage(),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: PRIMARY,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static int selectedIndex = 2;

  static List<Offer> favorits = [];

  static List<BasePage> widgetOptions = <BasePage>[
    BasePage(startPage: Container()),
    BasePage(startPage: FavoritsPage(),),
    BasePage(startPage: MainPage(),),
    BasePage(startPage: ProfilePage(),),
    BasePage(startPage: SearchPage(),),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if(index == 0) {
        _scaffoldKey.currentState.openDrawer();
      } else if (selectedIndex == index) {
        widgetOptions[selectedIndex].navigateTo(widgetOptions[selectedIndex].startPage);
      } else {
        selectedIndex = index;
      }
    });
  }

  void draverNavidateTo(Widget w) {
    setState(() {
      selectedIndex = 0;
      widgetOptions[selectedIndex].navigateTo(w);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF4F4F4),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Каталог'),
              onTap: () => draverNavidateTo(CatalogsPage()),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        children: widgetOptions,
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(''),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: PRIMARY,
        unselectedItemColor: Color(0xFF979797),
        onTap: _onItemTapped,
      ),
    );
  }
}
