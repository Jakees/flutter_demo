

import 'package:flutter/material.dart';
import 'package:flutter_app/util/TextUtil.dart';
import 'package:video_player/video_player.dart';

class MediaPlayerFactory{

  /**
   * VideoPage页面 List列表中的播放器 创建
   */
  static Widget createListItemPlayer(
      double height,
      VideoPlayerController controller,
      VoidCallback clickListener) {

    return new Container(
      alignment: Alignment.center,
      color: Colors.black,
      height: height,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              controller.value.initialized
                  ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
//                    child: new VideoPlayPause(_ControllerMap[position]))
                  child: new VideoPlayer(controller))
                  : Container(),
              new IconButton(
                  icon: new Icon(
                    controller.value.isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    size: 50.0,
                    color: Colors.grey[300],
                  ),
                  onPressed: () => clickListener()
                  )
            ],
          ),
          new VideoProgressIndicator(
            controller,
            padding: EdgeInsets.zero,
            allowScrubbing: true,
            colors: new VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.white10,
                backgroundColor: Colors.transparent),
          )
        ],
      ),
    );
  }

  /**
   * MicroVideoPage页面 Grid 列表中的播放器 创建
   */
  static Widget createGridItemPlayer(
      VideoPlayerController controller,
      VoidCallback clickListener) {

    return new Container(
      color: Colors.black,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new Stack(
            fit:StackFit.expand,
            children: <Widget>[
              new Center(
                child: controller.value.initialized
                    ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
//                    child: new VideoPlayerPause(_ControllerMap[position]))
                    child: new VideoPlayer(controller))
                    : Container(),
              ),
              new IconButton(
                  icon: new Icon(
                    controller.value.isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    size: 50.0,
                    color: Colors.grey[300],
                  ),
                  onPressed: () => clickListener()
              )
            ],
          ),
          new Container(
            alignment: Alignment.bottomCenter,
            height: 80.0,
            margin: EdgeInsets.all(5.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                      '超市棒棒糖！',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left ,
                      maxLines: 2,
                      style: TextUtil.createTextStyleWhiteLarge()
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            new Text('1.4万播放', style: TextUtil.createTextStyleWhiteSmall())
                          ],
                        )
                    ),
                    new Expanded(
                        child: new Align(
                          alignment: Alignment.centerRight,
                          child: new Text('1.2万赞', style: TextUtil.createTextStyleWhiteSmall()),
                        ))
                  ],
                ),
                new VideoProgressIndicator(
                  controller,
                  padding: EdgeInsets.zero,
                  allowScrubbing: true,
                  colors: new VideoProgressColors(
                      playedColor: Colors.red,
                      bufferedColor: Colors.white10,
                      backgroundColor: Colors.transparent),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}