import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:yourstyle/main.dart';
import 'package:yourstyle/models/offer.dart';
import 'package:yourstyle/pages/ProductList.dart';
import 'package:yourstyle/services/api.service.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin<SearchPage> {

  String _search = '';

  Future<List<Offer>> search(String search) async {
    _search = search;
    List<Offer> result = await ApiService.getProductList(search: search);
    if(result.length > 0) result.add(null);
    return result;
  }

  void toProductList() {
    HomePageState.widgetOptions[HomePageState.selectedIndex].navigateTo(ProductList(search: _search));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchBar<Offer>(
            onSearch: search,
            onItemFound: (Offer item, int index) {
              return item == null ? Container(
                child: FlatButton(child: Text('Посмотреть больше'), onPressed: toProductList,),
                padding: EdgeInsets.all(16),
              ) : ListTile(
                title: Text(item.name),
                subtitle: Text(item.vendor),
              );
            },
            emptyWidget: Text("Ничего не найдено"),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}