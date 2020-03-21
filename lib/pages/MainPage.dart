import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {

  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin<MainPage> {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          new Flexible(
            child: Container(
              child: Image.asset('assets/images/logo.png', fit: BoxFit.fitHeight,),
              alignment: Alignment.center,
              height: 140.0,
              margin: EdgeInsets.only(bottom: 40, top: 20),
            ),
          ),
          new Flexible(
            child: Container(
              child: CarouselSlider(
                height: size.width / 411 * 99,
                viewportFraction: 1.0,
                items: [
                  Container(
                    child: Image.asset('assets/images/slider_1.png', fit: BoxFit.cover,),
                    width: size.width,
                  ),
                  Container(
                    child: Image.asset('assets/images/slider_2.png', fit: BoxFit.cover,),
                    width: size.width,
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          new Flexible(
            child: Card(
              child: ListView(
                children: [
                  Container(
                    child: ListView(
                      children: [
                        Container(
                          child: Text('Женское'),
                          alignment: Alignment.center,
                        ),
                        Image.asset('assets/images/sex_1.png', fit: BoxFit.cover,),
                      ],
                    ),
                    width: size.width / 3,
                  ),
                  Container(
                    child: ListView(
                      children: [
                        Container(
                          child: Text('Мужское'),
                          alignment: Alignment.center,
                        ),
                        Image.asset('assets/images/sex_2.png', fit: BoxFit.cover,),
                      ],
                    ),
                    width: size.width / 3,
                  ),
                  Container(
                    child: ListView(
                      children: [
                        Container(
                          child: Text('Для детей'),
                          alignment: Alignment.center,
                        ),
                        Image.asset('assets/images/sex_3.png', fit: BoxFit.cover,),
                      ],
                    ),
                    width: size.width / 3,
                  ),
                ],
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ]
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}