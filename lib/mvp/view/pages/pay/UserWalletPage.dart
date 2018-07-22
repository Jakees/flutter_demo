import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/AppConst.dart';
import 'package:flutter_app/components/ClickableLayout.dart';
import 'package:flutter_app/components/topbat/TopBarFactory.dart';
import 'package:flutter_app/util/DialogUtil.dart';
import 'package:flutter_app/util/ImageUtil.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * 用户 - 钱包相关
 */
class UserWalletPage extends StatefulWidget {
  UserWalletPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserWalletPageState createState() => new _UserWalletPageState();
}

class _UserWalletPageState extends State<UserWalletPage>{

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
            ClickableLayout.createClickableLayout('微信',
                leftIconTextMargin: 10.0,
                leftIcon: ImageUtil.createRectangleImgCornerAssets('images/icon_charge_weichat.png', height: 35.0, width: 35.0, boxFit: BoxFit.cover),
                listener: (){_invokeItemPressed(1);}),
            ClickableLayout.createClickableLayout('支付宝',marginTop: 10.0,
                leftIconTextMargin: 10.0,
                leftIcon: ImageUtil.createRectangleImgCornerAssets('images/icon_charge_alipay.png', height: 35.0, width: 35.0, boxFit: BoxFit.cover),
                listener: (){_invokeItemPressed(1);}),
          ],
        ),
      ),
    );
  }

  void _invokeItemPressed(int position) {
    switch(position) {
      case 1:
        DialogUtil.showBaseDialog(context, '微信', '微信暂未支持！！！！');
        break;
      case 2:
        DialogUtil.showBaseDialog(context, '提示', '支付宝还没好！！！！');
        break;
      default:

        break;
    }
  }

}