import 'package:flutter/material.dart';
import 'package:yourstyle/assets/consts.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            child: Card(
              child: Container(
                height: 50,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Text('Личные Данные', style: TextStyle(color: PRIMARY),),
              ),
            ),
          ),
          new Flexible(
            child: Container(
              child: Text('Страница профиля')
            ),
          ),
        ]
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}