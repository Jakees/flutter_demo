import 'package:flutter/material.dart';
import 'package:flutter_app/AppConst.dart';
import 'package:flutter_app/components/ClickableLayout.dart';
import 'package:flutter_app/components/topbat/TopBarFactory.dart';
import 'package:flutter_app/util/DialogUtil.dart';
import 'package:flutter_app/util/ImageUtil.dart';

/**
 * 用户 - 消息通知
 */
class UserMessagePage extends StatefulWidget {
  UserMessagePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserMessagePageState createState() => new _UserMessagePageState();
}

class _UserMessagePageState extends State<UserMessagePage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppConst.COLOR_PAGE_BACK_GREY,
      appBar: TopBarFactory.createAppBar(widget.title),
      body: new Container(
        child: new Column(
          children: <Widget>[
            ClickableLayout.createClickableLayout('消息1',marginTop: 10.0,
                listener: (){_invokeItemPressed(1);}),
            ClickableLayout.createClickableLayout('消息2',marginTop: 10.0,
                listener: (){_invokeItemPressed(2);}),
          ],
        ),
      ),
    );
  }

  void _invokeItemPressed(int position) {
    switch(position) {
      case 1:

        break;
      default:

        break;
    }
  }

}