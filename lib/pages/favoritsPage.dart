import 'package:flutter/material.dart';
import 'package:yourstyle/assets/consts.dart';
import 'package:yourstyle/main.dart';
import 'package:yourstyle/other/BaseCard.dart';
import 'package:yourstyle/pages/ProductList.dart';

class FavoritsPage extends StatefulWidget {

  const FavoritsPage({Key key}) : super(key: key);

  @override
  _FavoritsPageState createState() => new _FavoritsPageState();
}

class _FavoritsPageState extends State<FavoritsPage> with AutomaticKeepAliveClientMixin<FavoritsPage> {

  void toProductList() {
    HomePageState.widgetOptions[HomePageState.selectedIndex].navigateTo(ProductList());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2 - 24;

    return Scaffold(
      body: HomePageState.favorits.length > 0 ?
        GridView.count(
          primary: false,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          childAspectRatio: (itemWidth / itemHeight),
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: HomePageState.favorits.map((offer) => BaseCard(offer: offer, update: () => setState(() {}),)).toList()
        ) : Column(
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
            child: Card(
              child: Container(
                height: 50,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Text('Избранное', style: TextStyle(color: PRIMARY),)
              ),
            ),
          ),
          new Flexible(
            child: Container(
              alignment: Alignment.center,
              height: 160,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Вы не добавили ничего. Соберите свой Outfit нажатием кнопки \u2764 в карточке продукта',
                textAlign: TextAlign.center,
              )
            ),
          ),
          new Flexible(
            child: Container(
              alignment: Alignment.center,
              child: FlatButton(child: Text('Продолжить покупки'), onPressed: toProductList,),
            ),
          ),
        ]
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}