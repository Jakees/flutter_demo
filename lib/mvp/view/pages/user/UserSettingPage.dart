import 'package:flutter/material.dart';
import 'package:flutter_app/AppConst.dart';
import 'package:flutter_app/components/ClickableLayout.dart';
import 'package:flutter_app/components/topbat/TopBarFactory.dart';
import 'package:flutter_app/util/DialogUtil.dart';
import 'package:flutter_app/util/ImageUtil.dart';

/**
 * 用户 - 系统设置
 */
class UserSettingPage extends StatefulWidget {
  UserSettingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserSettingPageState createState() => new _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage>{

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
            ClickableLayout.createClickableLayout('清除缓存',marginTop: 10.0,
                listener: (){_invokeItemPressed(1);}),
            ClickableLayout.createClickableLayout('关闭系统通知',marginTop: 10.0,
                listener: (){_invokeItemPressed(2);}),
          ],
        ),
      ),
    );
  }

  void _invokeItemPressed(int position) {
    switch(position) {
      case 1:
        DialogUtil.showBaseDialog(context, '提示', '缓存已清除！');
        break;
      case 2:
        DialogUtil.showBaseDialog(context, '提示', '关闭系统通知已关闭！');
        break;
      default:
        break;
    }
  }

}