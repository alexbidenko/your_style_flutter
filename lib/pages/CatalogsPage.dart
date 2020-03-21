import 'package:flutter/material.dart';
import 'package:yourstyle/main.dart';
import 'package:yourstyle/models/offer.dart';
import 'package:yourstyle/pages/ProductList.dart';
import 'package:yourstyle/services/api.service.dart';

class CatalogsPage extends StatefulWidget {

  const CatalogsPage({Key key}) : super(key: key);

  @override
  _CatalogsPageState createState() => new _CatalogsPageState();
}

class _CatalogsPageState extends State<CatalogsPage> with AutomaticKeepAliveClientMixin<CatalogsPage> {

  Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    categories = ApiService.getCaregoryList();
  }

  void toProductList(Category category) {
    HomePageState.widgetOptions[HomePageState.selectedIndex].navigateTo(ProductList(category: category,));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data.map((category) => ListTile(
                    title: Text(category.name),
                    onTap: () => toProductList(category),
                  )).toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}