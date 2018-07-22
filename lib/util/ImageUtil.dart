import 'package:flutter/material.dart';

/**
 * 提供 几何图形 和 图片 加载的工具类
 */
class ImageUtil {

  /**
   * 圆形剪裁 网络图片
   *  size (double) 直径
   */
  static Widget createCircleImgNetwork(size, url, {BoxFit boxFit = BoxFit.cover}) {
    return new ClipOval(
      child: new SizedBox(
        width: size,
        height: size,
        child: new Image.network(
          url,
          fit: boxFit,
        ),
      ),
    );
  }


  /**
   * 圆形剪裁 来自手机相机和手机相册
   *  size (double) 直径
   */
  static Widget createCircleImgPhone(size, file, {BoxFit boxFit = BoxFit.cover}) {
    return new ClipOval(
      child: new SizedBox(
        width: size,
        height: size,
        child: new Image.file(
            file,
            fit: boxFit
        ),
      ),
    );
  }

  /**
   * 圆形剪裁 本地资源图
   *  size (double) 直径
   */
  static Widget createCircleImgAssets(size, url, {BoxFit boxFit = BoxFit.cover}) {
    return new ClipOval(
      child: new SizedBox(
        width: size,
        height: size,
        child: new Image.asset(
          url,
          fit: boxFit
        ),
      ),
    );
  }

  /**
   * 圆角矩形剪裁 （网络图片）
   *  radius 圆角大小
   *  size (double) 直径
   */
  static Widget createRectangleImgCornerNetwork(url,
      {height = double.infinity,
        width = double.infinity,
        topLeft = 0.0, topRight = 0.0, bottomLeft = 0.0, bottomRight = 0.0,
        BoxFit boxFit = BoxFit.cover}) {
    return new ClipRRect(
      borderRadius: new BorderRadius.only(
          topLeft: new Radius.circular(topLeft),
          topRight: new Radius.circular(topRight),
          bottomLeft: new Radius.circular(bottomLeft),
          bottomRight: new Radius.circular(bottomRight)
      ),
      child:  new SizedBox(
        height:height,
        width: width,
        child:  new Image.network(url,fit: boxFit),
      ),
    );
  }

  /**
   * 圆角矩形剪裁（本地资源图）
   *  radius 圆角大小
   *  size (double) 直径
   */
  static Widget createRectangleImgCornerAssets(url,
      {height = double.infinity,
        width = double.infinity,
        topLeft = 0.0, topRight = 0.0, bottomLeft = 0.0, bottomRight = 0.0,
        BoxFit boxFit = BoxFit.cover}) {
    return new ClipRRect(
      borderRadius: new BorderRadius.only(
          topLeft: new Radius.circular(topLeft),
          topRight: new Radius.circular(topRight),
          bottomLeft: new Radius.circular(bottomLeft),
          bottomRight: new Radius.circular(bottomRight)
      ),
      child:  new SizedBox(
        height:height,
        width: width,
        child:  new Image.asset(url,fit: boxFit),
      ),
    );
  }
}