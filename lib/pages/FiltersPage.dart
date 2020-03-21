import 'package:flutter/material.dart';
import 'package:yourstyle/main.dart';
import 'package:yourstyle/models/offer.dart';
import 'package:yourstyle/pages/ProductList.dart';
import 'package:yourstyle/services/api.service.dart';

class FiltersPage extends StatefulWidget {

  const FiltersPage({Key key}) : super(key: key);

  @override
  _FiltersPageState createState() => new _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> with AutomaticKeepAliveClientMixin<FiltersPage> {

  void toProductList() {
    HomePageState.widgetOptions[HomePageState.selectedIndex].navigateTo(ProductList(lowerPrice: _lowerPrice, upperPrice: _upperPrice));
  }

  double _lowerPrice = -1;
  double _upperPrice = -1;

  Future<PriceRange> priceRange;

  @override
  void initState() {
    super.initState();
    priceRange = ApiService.getPriceRange();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: ListView(
        children: [
          FutureBuilder<PriceRange>(
            future: priceRange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (_lowerPrice == -1) {
                  _lowerPrice = snapshot.data.price_min.toDouble();
                  _upperPrice = snapshot.data.price_max.toDouble();
                }
                return ExpansionTile(
                  title: Text('Цена'),
                  children: [
                    Container(
                      child: RangeSlider(
                        min: snapshot.data.price_min.toDouble(),
                        max: snapshot.data.price_max.toDouble(),
                        values: RangeValues(_lowerPrice, _upperPrice),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _lowerPrice = values.start;
                            _upperPrice = values.end;
                          });
                        },
                      ),
                      height: 50,
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Align(
                            child: Text(_lowerPrice.round().toString()),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(_upperPrice.round().toString()),
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                      height: 50,
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator()
              );
            },
          ),
          Container(
            child: FlatButton(child: Text('Применить'), onPressed: toProductList,),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}