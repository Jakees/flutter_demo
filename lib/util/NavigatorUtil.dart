import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';


/**
 * 页面导航 跳转工具类
 */
class NavigatorUtil {
  /**
   * 通过 Router 进行跳转
   * 跳转到新导航页，展示收藏的 words
   */
  static void startNewPageByRouter(
      BuildContext context, MaterialPageRoute pageRoute) {
    Navigator.push(
      context,
      pageRoute,
    );
  }

  /**
   * 通过 Builder 进行跳转
   * 跳转到新导航页
   */
  static void startNewPageByBuilder(
      BuildContext context, WidgetBuilder builder) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: builder),
    );
  }


  /**
   * 从底部淡入淡出效果页面
   */
  static void showSavedWords(
      BuildContext context, Set<WordPair> savedWords, TextStyle style) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {

          final tiles = savedWords.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: style,
                ),
              );
            },
          );

          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new SlideTransition(position: new Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation), child: child),
          );
        }
    ));
  }
}
