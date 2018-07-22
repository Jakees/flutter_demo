import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mvp/view/pages/video/MicroVideoPage.dart';
import 'package:flutter_app/mvp/view/pages/video/VideoPage.dart';
import 'package:flutter_app/mvp/view/pages/HomePage.dart';
import 'package:flutter_app/mvp/view/pages/user/UserPage.dart';
import 'package:flutter_app/mvp/view/pages/web/WebNavigatePage.dart';
import 'package:flutter_app/util/TextUtil.dart';

class MainPage extends StatefulWidget {
  final String homePageTitle;

  MainPage({Key key, this.homePageTitle}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

/**
 * 主页面 StateFulWidget 的 对应 State实现类
 */
class _MainPageState extends State<MainPage> with TickerProviderStateMixin  {
  TabController controller;
  int _currentTabIndex = 0;
  Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState
    print('--->initState --->_MainPageState');
    controller = new TabController(length: 4, vsync: this);
    controller.addListener((){
      _onTabSelected(controller.index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('--->build --->MainPage-->');
    return new Scaffold(
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new HomePage(homePageTitle: '首页'),
          new VideoPage(pageTitle: '视频'),
          new MicroVideoPage(title: '短视频'),
          new UserPage(),
        ]),
      bottomNavigationBar: new Container(
        child: new Stack(
          children: <Widget>[
            new BottomNavigationBar(
                onTap: (int position){_onTabSelected(position);},
                currentIndex: _currentTabIndex,
                iconSize: 20.0,
                items: _createNavigationBarItems(),
                type: BottomNavigationBarType.shifting,
            ),
//              new TabBar(
//                  labelColor: Colors.red,
//                  unselectedLabelColor: Colors.black54,
//                  indicatorColor: Colors.black54,
//                  indicatorWeight: 1.0,
//                  controller: controller,
//                  tabs: <Tab>[
//                    new Tab(text: '首页', icon: new Icon(Icons.home, size: 20.0)),
//                    new Tab(text: '视频', icon: new Icon(Icons.play_arrow, size: 20.0)),
////                    new Tab(text: '微视频', icon: new Icon(Icons.videocam, size: 20.0)),
//                    new Tab(text: '我的', icon: new Icon(Icons.cloud, size: 20.0)),
//                  ])
          ],
        ),
      )
    );
  }

  List<BottomNavigationBarItem> _createNavigationBarItems() {
    return <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
          icon: new Icon(Icons.home, color: _currentTabIndex == 0 ? Colors.red : Colors.grey,),
          title : new Text('首页', style: new TextStyle(color: _currentTabIndex == 0 ? Colors.red : Colors.grey))),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.play_arrow,  color: _currentTabIndex == 1 ? Colors.red : Colors.grey,),
          title : new Text('视频', style: new TextStyle(color: _currentTabIndex == 1 ? Colors.red : Colors.grey))),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.videocam,  color: _currentTabIndex == 2 ? Colors.red : Colors.grey,),
          title : new Text('短视频', style: new TextStyle(color: _currentTabIndex == 2 ? Colors.red : Colors.grey))),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.person,  color: _currentTabIndex == 3 ? Colors.red : Colors.grey,),
          title : new Text('我的', style: new TextStyle(color: _currentTabIndex == 3 ? Colors.red : Colors.grey))),
    ];
  }

  void _onTabSelected(int position) {
    setState(() {
      _currentTabIndex = position;
      controller.animateTo(position);
    });
  }

}