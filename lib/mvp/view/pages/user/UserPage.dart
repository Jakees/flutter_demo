import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppConst.dart';
import 'package:flutter_app/components/ClickableLayout.dart';
import 'package:flutter_app/mvp/model/UserInfoBean.dart';
import 'package:flutter_app/mvp/view/pages/pay/UserWalletPage.dart';
import 'package:flutter_app/mvp/view/pages/user/UserMessagePage.dart';
import 'package:flutter_app/mvp/view/pages/user/UserSettingPage.dart';
import 'package:flutter_app/mvp/view/pages/web/WebNavigatePage.dart';
import 'package:flutter_app/util/DialogUtil.dart';
import 'package:flutter_app/util/ImageUtil.dart';
import 'package:flutter_app/util/NavigatorUtil.dart';
import 'package:flutter_app/util/TextUtil.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);
  static final double HEAD_VIEW_HEIGHT = 180.0; //头部高度

  @override
  _UserPageState createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  UserInfoBean _UserInfoBean; //用户信息
  File _image;   //本地图片选择
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('--->initState --->_UserPageState');
    initData();
  }

  /**
   * 数据初始化
   */
  void initData() {
    _UserInfoBean = new UserInfoBean('小时候很调皮', '男', 23, 1000);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: AppConst.COLOR_PAGE_BACK_GREY,
        body: new ListView(
          children: <Widget>[
            //区域1:顶部 个人信息
            new Stack(
              children: <Widget>[
                ImageUtil.createRectangleImgCornerAssets('images/icon_bg_user_info.png', height: UserPage.HEAD_VIEW_HEIGHT, boxFit: BoxFit.cover),
                _createHeadInfoArea(UserPage.HEAD_VIEW_HEIGHT)
              ],
            ),
            //区域2: 底部 信息选择列表项
            _createBodyOperationArea()
          ],
        ));
  }

  /**
   * 区域1:顶部 个人信息
   */
  Widget _createHeadInfoArea(double height) {
    return new Container(
      height: height,
      padding: const EdgeInsets.all(15.0),
      child: new Column(
        children: <Widget>[
          //头像，用户名等信息
          new Expanded(
              flex: 1,
              child: new Row(
                children: <Widget>[
                  new FlatButton(
                      color: Colors.transparent,
                      child: _image == null
                          ? ImageUtil.createCircleImgAssets(65.0, "images/icon_head_error.png")
                          : ImageUtil.createCircleImgPhone(65.0, _image),
                      onPressed: getImage),
                  new Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                            '${_UserInfoBean != null ? _UserInfoBean.userName: ''}',
                            style: TextUtil.createTextStyleWhiteLarge(),
                            maxLines: 1),
                        new Text(
                            '等级：${_UserInfoBean != null ? _UserInfoBean.userVIP: ''}',
                            style: TextUtil.createTextStyleWhiteSmall(),
                            maxLines: 1)
                      ],
                    ),
                  )
                ],
              )),
          //底边个人状态信息栏
          new Expanded(
              flex: 1,
              child: new Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              flex: 1,
                              child: new Text(
                                  '动态：${_UserInfoBean != null ? _UserInfoBean.actions: ''}',
                                  style: TextUtil.createTextStyle(
                                      color: Colors.grey),
                                  maxLines: 1,
                                  textAlign: TextAlign.center),
                            ),
                            new Expanded(
                              flex: 1,
                              child: new Text(
                                '关注：${_UserInfoBean != null ? _UserInfoBean.attentions: ''}',
                                style: TextUtil.createTextStyle(
                                    color: Colors.grey),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            new Expanded(
                                flex: 1,
                                child: new Text(
                                    '粉丝：${_UserInfoBean != null ? _UserInfoBean.fans: ''}',
                                    style: TextUtil.createTextStyle(
                                        color: Colors.grey),
                                    maxLines: 1,
                                    textAlign: TextAlign.center))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  /**
   * 组件2: 底部 信息选择列表项
   */
  Widget _createBodyOperationArea() {
    return new Container(
      child: new Column(
        children: <Widget>[
          _createUserMiddleItem(70.0),
          ClickableLayout.createClickableLayout('消息通知', marginTop: 20.0,listener: (){_invokeItemPressed(1);}),
          ClickableLayout.createClickableLayout('我的钱包', marginTop: 20.0,listener: (){_invokeItemPressed(2);}),

          ClickableLayout.createClickableLayout('用户反馈',marginTop: 20.0,listener: (){_invokeItemPressed(3);}),
          ClickableLayout.createClickableLayout('系统设置', listener: (){_invokeItemPressed(4);}),
          ClickableLayout.createClickableLayout('关于我们', listener: (){_invokeItemPressed(5);}),
        ],
      ),
    );
  }

  Widget _createUserMiddleItem(double middleHeight) {
    return new Container(
        height: middleHeight,
        color: Colors.white,
        child: new Row(
          children: <Widget>[
            new Expanded(
                flex: 1,
                child: new FlatButton(
                    onPressed: (){

                    },
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.star_border, color: Colors.orange,),
                        new Text(
                            '收藏',
                            textAlign: TextAlign.center,
                            style: TextUtil.createTextStyle(color: Colors.black))
                      ],
                    )
                )
            ),
            new Expanded(
                flex: 1,
                child: new FlatButton(
                    onPressed: (){

                    },
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.star_border, color: Colors.red),
                        new Text(
                            '历史',
                            textAlign: TextAlign.center,
                            style: TextUtil.createTextStyle(color: Colors.black))
                      ],
                    )
                )
            ),
            new Expanded(
                flex: 1,
                child: new FlatButton(
                    onPressed: (){

                    },
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.star_border, color: Colors.lightBlue),
                        new Text(
                            '夜间',
                            textAlign: TextAlign.center,
                            style: TextUtil.createTextStyle(color: Colors.black))
                      ],
                    )
                )
            ),
          ],
        ));
  }

  void _invokeItemPressed(int position) {
    switch(position) {
      case 1: //消息通知
        NavigatorUtil.startNewPageByBuilder(context,
                (context) => new UserMessagePage(title: '消息通知'));
        break;
      case 2: //我的钱包
        NavigatorUtil.startNewPageByBuilder(context,
                (context) => new UserWalletPage(title: '我的钱包'));
        break;
      case 3: //用户反馈
        //TODO.........
        DialogUtil.showBaseDialog(context, '提示', '还没好！！！！');
        break;
      case 4: //系统设置
        NavigatorUtil.startNewPageByBuilder(context,
                (context) => new UserSettingPage(title: '系统设置'));
        break;
      case 5: //关于我们
        NavigatorUtil.startNewPageByBuilder(context,
                (context) => new WebNavigatePage(title: 'WebViewPage'));
        break;
      default:

        break;
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
