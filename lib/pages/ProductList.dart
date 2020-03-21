import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourstyle/assets/consts.dart';
import 'package:yourstyle/main.dart';
import 'package:yourstyle/models/offer.dart';
import 'package:yourstyle/other/BaseCard.dart';
import 'package:yourstyle/pages/FiltersPage.dart';
import 'package:yourstyle/services/api.service.dart';

class ProductList extends StatefulWidget {

  String search = '';
  Category category;
  double lowerPrice;
  double upperPrice;

  ProductList({Key key, this.search, this.category, this.lowerPrice, this.upperPrice}) : super(key: key);

  @override
  _ProductListState createState() => new _ProductListState();
}

class _ProductListState extends State<ProductList> with AutomaticKeepAliveClientMixin<ProductList> {

  List<Offer> _offers = [];
  bool _isRequest = false;
  bool _isFinish = false;

  @override
  void initState() {
    super.initState();
    getOffersList();
  }

  void toFilters() {
    HomePageState.widgetOptions[HomePageState.selectedIndex].navigateTo(FiltersPage());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2 - 24;

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Container(
              child: Text(
                'New Collection',
                style: TextStyle(color: PRIMARY,),
              ),
              alignment: Alignment.center,
              height: 50,
            ),
            Align(
              child: IconButton(icon: Icon(Icons.settings), onPressed: toFilters,),
              alignment: Alignment.centerRight,
            )
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification){
          if(scrollNotification.metrics.pixels > scrollNotification.metrics.maxScrollExtent - 400){
            getOffersList();    
          }
          return true;
        },
        child: _offers.length > 0 || _isRequest ? GridView.count(
          primary: false,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 16,
          childAspectRatio: (itemWidth / itemHeight),
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: _offers.map<Widget>((offer) => BaseCard(offer: offer)).toList()
        ) : Text('Ничего не найдено'),
      ),
    );
  }

  void getOffersList() async {
    if (!_isFinish && !_isRequest) {
      setState(() { _isRequest = true; });
      List<Offer> newOffers = await ApiService.getProductList(
        from: _offers.length,
        search: widget.search == null ? '' : widget.search,
        category: widget.category == null ? '' : widget.category.id.toString(),
        lowerPrice: widget.lowerPrice == null ? '' : widget.lowerPrice.toString(),
        upperPrice: widget.upperPrice == null ? '' : widget.upperPrice.toString(),
      );
      setState(() {
        if (newOffers.length == 0) {
          _isFinish = true;
        }
        _offers.addAll(newOffers);
        _isRequest = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}