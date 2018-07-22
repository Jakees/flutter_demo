
import 'package:flutter/material.dart';

/**
 * 提供 文本 空间 和 内容操作的工具类
 */
class TextUtil{


  /**
   * 检查 文本是否为空
   */
  static String checkTextNull(String text, {String defaultText = ''}) {
    return text == null
        ? defaultText
        : text;
  }

  static TextStyle createTextStyle({
    Color color = Colors.white,
    double size = 16.0}) {
    return new TextStyle(
        color: color,
        fontSize: size
    );
  }

  static TextStyle createTextStyleWhiteSmall() {
    return new TextStyle(
        color: Colors.white,
        fontSize: 12.0
    );
  }

  static TextStyle createTextStyleWhiteMiddle() {
    return new TextStyle(
        color: Colors.white,
        fontSize: 14.0
    );
  }

  static TextStyle createTextStyleWhiteLarge() {
    return new TextStyle(
        color: Colors.white,
        fontSize: 18.0
    );
  }

}