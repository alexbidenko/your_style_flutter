import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourstyle/assets/consts.dart';
import 'package:yourstyle/main.dart';
import 'package:yourstyle/models/offer.dart';

class BaseCard extends StatefulWidget {

  final Offer offer;
  final Function update;

  BaseCard({Key key, this.offer, this.update}) : super(key: key);

  @override
  _BaseCardState createState() => new _BaseCardState();
}

class _BaseCardState extends State<BaseCard> with AutomaticKeepAliveClientMixin<BaseCard> {

  void toggeFavorits() {
    setState(() {
      if (HomePageState.favorits.any((offer) => widget.offer.id == offer.id)) {
        HomePageState.favorits.removeWhere((offer) => widget.offer.id == offer.id);
      } else {
        HomePageState.favorits.add(widget.offer);
      }
    });
    widget.update();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 3;

    return ListView(
      children: <Widget>[
        Container(
          height: itemHeight - 60,
          child: GestureDetector(
            child: Card(
              color: Color(0xFFF4F4F4),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: new Image.network(
                      widget.offer.pictures[0],
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          child: Text(widget.offer.price.toString() + ' ₽',),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            HomePageState.favorits.any((offer) => widget.offer.id == offer.id) ?
                              Icons.favorite :
                              Icons.favorite_border
                          ),
                          color: PRIMARY,
                          onPressed: toggeFavorits,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.shopping_basket),
                          color: PRIMARY,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () => launch(widget.offer.url),
          ),
        ),
        Text(widget.offer.vendor + ' - ' + widget.offer.name),
      ],
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}