import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/media/player/MediaPlayerFactory.dart';
import 'package:flutter_app/components/topbat/TopBarFactory.dart';
import 'package:flutter_app/util/NavigatorUtil.dart';
import 'package:video_player/video_player.dart';

final int DEFAULT_VIDEOS = 2;
final List<String> VIDEO_URLS = [
  'http://221.228.226.23/11/t/j/v/b/tjvbwspwhqdmgouolposcsfafpedmb/sh.yinyuetai.com/691201536EE4912BF7E4F1E2C67B8119.mp4',
  'http://221.228.226.5/14/z/w/y/y/zwyyobhyqvmwslabxyoaixvyubmekc/sh.yinyuetai.com/4599015ED06F94848EBF877EAAE13886.mp4',
  'http://221.228.226.5/15/t/s/h/v/tshvhsxwkbjlipfohhamjkraxuknsc/sh.yinyuetai.com/88DC015DB03C829C2126EEBBB5A887CB.mp4'
];
final _suggestions = <WordPair>[]; //此列表保存建议的单词对
final _biggerFont = const TextStyle(fontSize: 18.0); //列表显示字体样式
final _saved = new Set<WordPair>(); //存储列表中用户收藏的单词对
bool _EnableShowImage = true; //true: 列表显示视频预览； false: 列表隐藏视频预览

class VideoPage extends StatefulWidget {
  final String pageTitle;
  VideoPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _MyVideoPageState createState() => new _MyVideoPageState();
}

/**
 * 基于StateFulWidget主页面对应的野页面状态State实现类
 */
class _MyVideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin {
  VideoListWidget videoList;

  @override
  void initState() {
    super.initState();
    print('--->initState --->_MyHomePageState--> ${videoList}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoList == null) {
      videoList = new VideoListWidget();
    }
    //如果 主页列表组件 randomWords 创建失败，则终止后续逻辑
    assert(videoList != null);
    print('--->build -->_MyHomePageState---> ${videoList}');
    print(
        '--->build -->_MyHomePageState---> ${videoList._videoListWidgetState}');
    print('--->build -->_MyHomePageState---> ${_saved}');

    return new Scaffold(
        appBar: TopBarFactory.createAppBar(
            '${widget.pageTitle == null ? '' : widget.pageTitle}_模式${_EnableShowImage ? '1': '2'}',
            actions: <Widget>[
              new PopupMenuButton<int>(
                  onSelected: (int value) => onMenuSelected(value),
                  itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                    new PopupMenuItem<int>(value: 1, child: new Text('切换模式')),
                    new PopupMenuItem<int>(value: 2, child: new Text('我的收藏')),
                  ]),
            ]
        ),
        body: new Center(
          child: videoList,
        ));
  }

  /**
   * 菜单栏 选择
   */
  void onMenuSelected(int value) {
    switch (value) {
      case 1:
        _changeListItemState();
        break;
      case 2:
        _checkSavedWords();
        break;
    }
  }

  /**
   * 切换 列表显示风格
   *
   */
  _changeListItemState() {
    _EnableShowImage = !_EnableShowImage;
    //调用根布局的setState通知刷新根布局，顶部Title文字变化
    setState(() {});
    //调用子布局的 setState方法类通知子列表布局刷新
    videoList._videoListWidgetState.setState(() {});
  }

  /**
   * 跳转到新导航页，展示收藏的 words
   */
  void _checkSavedWords() {
    print('--->build -->_checkSavedWords---> ${videoList}');
    print(
        '--->build -->_checkSavedWords---> ${videoList._videoListWidgetState}');
    print('--->build -->_checkSavedWords---> ${_saved}');
    NavigatorUtil.showSavedWords(context, _saved, _biggerFont);
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

/**
 * 随机文本生成Widget StatefulWidget
 */
class VideoListWidget extends StatefulWidget {
  _VideoListWidgetState _videoListWidgetState = new _VideoListWidgetState();

  @override
  createState() => _videoListWidgetState;
}

class _VideoListWidgetState extends State<VideoListWidget> {
  Map<int, VideoPlayerController> _ControllerMap;
  int _currentIndex = 0; //当前列表中的播放位置
  double _playerHeight = 230.0;
  bool _isVideoPlaying = false;
  bool _isDisposed = true; //当前状态： true 还未被创建或者已经被销毁; false: 可用状态

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
  void initState() {
    print('--->initState --->_videoListWidgetState-->');
    super.initState();
    _isDisposed = false;
    //TODO.....初始化控制器，目前必须在此处初始化，否则刷新不到.......
    _ControllerMap = new Map();
    for (int index = 0; index < DEFAULT_VIDEOS; index++) {
      _ControllerMap.addAll({index: _CreateVideoController(index)});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('--->build -->_videoListWidgetState---> ${_biggerFont}');
    print('--->build -->_videoListWidgetState---> ${_saved}');
    return _buildSuggestions();
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

  /**
   * 构建显示建议单词对的ListView
   */
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, index) {
          // 在每一列之前，默认添加一个1像素高的分隔线widget
          if (index.isOdd) return new Divider();
          // 语法 "i ~/ 2" 表示i除以2返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final amounts = index ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (amounts >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _BuildRow(amounts, _suggestions[amounts]);
        });
  }

  Widget _BuildRow(int position, WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    if (_EnableShowImage) {
      return new Column(
        children: <Widget>[
          position < DEFAULT_VIDEOS
              ? _CreateVideoItem(position)
              : new Image.network('http://i1.hdslb.com/bfs/archive/7ee3075c214232d5eef968659db20a62faba2133.jpg'),
          _CreateListItem(alreadySaved, position, pair),
        ],
      );
    } else {
      return new Row(
        children: <Widget>[
          new Expanded(
            child: _CreateListItem(alreadySaved, position, pair),
          )
        ],
      );
    }
  }

  /**
   * 列表中的播放器 创建
   */
  Widget _CreateVideoItem(final int position) {
    return MediaPlayerFactory.createListItemPlayer(_playerHeight, _ControllerMap[position], (){
      //点击新播放项，需先判断并且暂停当前_currentIndex位置播放的视频
      if (_currentIndex != position &&
          _ControllerMap[_currentIndex].value.isPlaying) {
        _ControllerMap[_currentIndex].pause();
      }
      _currentIndex = position;
      _ControllerMap[position].value.isPlaying
          ? _ControllerMap[position].pause()
          : _ControllerMap[position].play();
    });
  }

  Widget _CreateListItem(bool alreadySaved, int position, WordPair pair) {
    return new Row(
      children: <Widget>[
        //标题单词对
        new Expanded(
            flex: 1,
            child: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            )),
        //收藏图标
        new Expanded(
            flex: 1,
            child: new Row(
              children: <Widget>[
                //收藏图标
                new Expanded(
                    flex: 1,
                    child: new FlatButton(
                        child: new Icon(
                          alreadySaved ? Icons.favorite : Icons.favorite_border,
                          color: alreadySaved ? Colors.red : null,
                        ),
                        //单击点击事件
                        onPressed: () {
                          setState(() {
                            if (alreadySaved) {
                              _saved.remove(pair);
                            } else {
                              _saved.add(pair);
                            }
                          });
                        })),
                //分享
                new Expanded(
                    flex: 1,
                    child: new FlatButton(
                        child: new Icon(Icons.share),
                        //单击点击事件
                        onPressed: () {})),
                //评论
                new Expanded(
                    flex: 1,
                    child: new FlatButton(
                        child: new Icon(Icons.insert_comment),
                        //单击点击事件
                        onPressed: () {}))
              ],
            ))
      ],
    );
  }
}
