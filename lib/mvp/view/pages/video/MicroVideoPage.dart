import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/AppConst.dart';
import 'package:flutter_app/components/ClickableLayout.dart';
import 'package:flutter_app/components/media/player/MediaPlayerFactory.dart';
import 'package:flutter_app/components/media/player/SqlVideoPlayerPause.dart';
import 'package:flutter_app/util/DialogUtil.dart';
import 'package:flutter_app/util/ImageUtil.dart';
import 'package:flutter_app/util/TextUtil.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

/**
 * 微视频
 */
final int DEFAULT_VIDEOS = 3;
final List<String> VIDEO_URLS = [
  'http://221.228.226.23/11/t/j/v/b/tjvbwspwhqdmgouolposcsfafpedmb/sh.yinyuetai.com/691201536EE4912BF7E4F1E2C67B8119.mp4',
  'http://221.228.226.5/15/t/s/h/v/tshvhsxwkbjlipfohhamjkraxuknsc/sh.yinyuetai.com/88DC015DB03C829C2126EEBBB5A887CB.mp4',
  'http://221.228.226.5/14/z/w/y/y/zwyyobhyqvmwslabxyoaixvyubmekc/sh.yinyuetai.com/4599015ED06F94848EBF877EAAE13886.mp4'];
class MicroVideoPage extends StatefulWidget {
  MicroVideoPage({Key key, this.title}) : super(key: key);
  final String title;
  final String imgUrl = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529649560576&di=5dd208f8057d5530e90b303bc473966d&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2Fad9bf862242479a6adaca9fb2b65c1ce5ed92b6e.jpg';

  @override
  _MicroVideoPageState createState() => new _MicroVideoPageState();
}

class _MicroVideoPageState extends State<MicroVideoPage>{
  Map<int, VideoPlayerController> _ControllerMap;
  File _image; //来自手机的图片
  int _currentIndex = 0;//当前列表中的播放位置
  bool _isVideoPlaying = false;
  bool _isDisposed = true; //当前状态： true 还未被创建或者已经被销毁; false: 可用状态

  @override
  void initState() {
    super.initState();
    _isDisposed = false;
    //TODO.....初始化控制器，目前必须在此处初始化，否则刷新不到.......
    _ControllerMap = new Map();
    for(int index = 0; index < DEFAULT_VIDEOS; index++) {
      _ControllerMap.addAll({index: _CreateVideoController(index)});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ControllerMap.forEach((int key, VideoPlayerController value) {
      value.dispose();
    });
    _ControllerMap.clear();
    _isDisposed = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppConst.COLOR_PAGE_BACK_GREY,
      appBar: new AppBar(
        title: _createTopBarLayout(),
      ),
      body: new Container(
        color: Colors.white,
        child: new GridView.count(
          primary: false,
          padding: const EdgeInsets.only(top: 0.0),
          crossAxisSpacing: 2.0,
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          children: _initGridVideoItems(2.0),
        )
      ),
    );
  }

  /**
   * 新建(目前单独)一个 播放器控制器
   */
  VideoPlayerController _CreateVideoController(int position) {
    return VideoPlayerController.network(VIDEO_URLS[position % 3])
      ..addListener(() {
        print('Video State-->${_ControllerMap[_currentIndex].value.position}');
        final bool isPlaying = _ControllerMap[_currentIndex].value.isPlaying;
        if (isPlaying != _isVideoPlaying) {
          setState(() {
            _isVideoPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (!_isDisposed) {
          setState(() {});
        }
      });
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

  /**
   * 填充列表数据，来自网络，或者本地
   */
  List<Widget> _initGridVideoItems(padding) {
    List<Widget> items = new List();
    for(int index = 0; index < DEFAULT_VIDEOS; index++) {
      items.add(
          new Container(
              padding: EdgeInsets.only(top: padding),
              child: new Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  _CreateVideoItem(index),
                ],
              )
          )
      );
    }
    for(int index = 0; index < DEFAULT_VIDEOS; index++) {
      items.add(
          new Container(
              padding: EdgeInsets.only(top: padding),
              child: ImageUtil.createRectangleImgCornerNetwork(widget.imgUrl,)
          )
      );
    }
    return items;
  }

  /**
   * 顶部 TopBar
   */
  Widget _createTopBarLayout() {
    return new Row(
        children: <Widget>[
      new Expanded(
          flex: 1,
          child: new Container()
      ),
      new Expanded(
          flex: 2,
          child: new Text(
            widget.title != null ? widget.title : '',
            textAlign: TextAlign.center,
          )
      ),
      new Expanded(
          flex: 1,
          child: new FlatButton(
              padding: EdgeInsets.zero,
              onPressed: getImage,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Icon(Icons.video_call, color: Colors.white,),
                  new Text('发布', style: new TextStyle(color: Colors.white))
                ],
              )
          )
      ),
    ],
    );

  }

  /**
   * 创建 播放器 项
   */
  Widget _CreateVideoItem(final int position) {
    return MediaPlayerFactory.createGridItemPlayer(_ControllerMap[position], (){
      //点击新播放项，需先判断并且暂停当前_currentIndex位置播放的视频
      if(_currentIndex != position
          && _ControllerMap[_currentIndex].value.isPlaying) {
        _ControllerMap[_currentIndex].pause();
      }
      _currentIndex = position;
      _ControllerMap[position].value.isPlaying
          ? _ControllerMap[position].pause()
          : _ControllerMap[position].play();
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

}