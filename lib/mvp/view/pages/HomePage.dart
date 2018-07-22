import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/topbat/TopBarFactory.dart';
import 'package:flutter_app/util/DialogUtil.dart';
import 'package:video_player/video_player.dart';

final String _DEFAULT_TITLE = 'HomePage';
final _suggestions = <WordPair>[]; //此列表保存建议的单词对
final _biggerFont = const TextStyle(fontSize: 15.0); //列表显示字体样式
final _saved = new Set<WordPair>(); //存储列表中用户收藏的单词对

class HomePage extends StatefulWidget {
  final String homePageTitle;
  HomePage({Key key, this.homePageTitle}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/**
 * 基于StateFulWidget主页面对应的野页面状态State实现类
 */
class _MyHomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  RandomListWidget randomWords;

  @override
  void initState() {
    super.initState();
    print('--->initState --->_MyHomePageState--> ${randomWords}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (randomWords == null) {
      randomWords = new RandomListWidget();
    }
    //如果 主页列表组件 randomWords 创建失败，则终止后续逻辑
    assert(randomWords != null);
    print('--->build -->_MyHomePageState---> ${randomWords}');
    print('--->build -->_MyHomePageState---> ${randomWords._randomWordsState}');
    print('--->build -->_MyHomePageState---> ${_saved}');

    return new Scaffold(
      appBar: TopBarFactory.createAppBar(widget.homePageTitle, defaultTitle: _DEFAULT_TITLE),
      body: new Center(
        child: randomWords,
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          DialogUtil.showBaseDialog(context, '提示', '没什么哈哈哈！');
        },
        tooltip: 'Fade',
        child: new Icon(Icons.message),
      ),
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

/**
 * 随机文本生成Widget StatefulWidget
 */
class RandomListWidget extends StatefulWidget {
  RandomListWidgetState _randomWordsState = new RandomListWidgetState();

  @override
  createState() => _randomWordsState;
}

class RandomListWidgetState extends State<RandomListWidget> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('--->initState --->_RandomWordsState-->');
  }

  @override
  Widget build(BuildContext context) {
    print('--->build -->_RandomWordsState---> ${_biggerFont}');
    print('--->build -->_RandomWordsState---> ${_saved}');
    return _buildSuggestions();
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
    return new Column(
      children: <Widget>[
        new Image.network('http://p.laozu.com/laozutu/2016dwy/20160527/2.jpg'),
        new Align(
            alignment: Alignment.centerLeft,
            child: new Text('赛博朋克2077',
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 15.0))),
        _CreateListItem(alreadySaved, position, pair)
      ],
    );
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
                          alreadySaved ? Icons.star : Icons.star_border,
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
                        onPressed: () {})
                ),
                //评论
                new Expanded(
                    flex: 1,
                    child: new FlatButton(
                        child: new Icon(Icons.insert_comment),
                        //单击点击事件
                        onPressed: () {})
                )
              ],
            ))
      ],
    );
  }

}
