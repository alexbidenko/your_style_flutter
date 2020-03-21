import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {

  final Widget startPage;

  dynamic navigateTo;

  BasePage({Key key, this.startPage}) : super(key: key);

  @override
  _BasePageState createState() => new _BasePageState();
}

class _BasePageState extends State<BasePage> with AutomaticKeepAliveClientMixin<BasePage> {

  Widget _activePage;

  @override
  void initState() {
    super.initState();
    _activePage = widget.startPage;
    widget.navigateTo = (Widget w) {
      setState(() {
        _activePage = w;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _activePage,
      alignment: Alignment.center,
    );
  }

  @override
  bool get wantKeepAlive => true;
}