import 'dart:convert';    //集成了支持json、utf-8等数据格式的编码和解码器
import 'dart:io';        //集成了File, socket, HTTP等服务应用的IO库
import 'package:http/http.dart' as http;

final String _NET = 'SQL_NET:';
final String _UTIL_TAGS = '${_NET}HttpUtil:';
final String _RES_STATUS_CODE = '${_NET}Response status code:';
final String _RES_BODY = '${_NET}Response body:';



/**
 * Http 请求相关工具类
 */
class HttpUtil {
  static final String TEST_URL = 'http://sn.myqianyi.com/pinche/index/Login/signin?code=&password=123456789&name=15158164437&type=1';
  final http.Client client = new http.Client();

  /**
   *
   * （参数可选）@params: "parmeter": "value", "parmeter2": "value2"
   */
  static void httpTestNoClient(String baseUrl, {Map params}) {
    http.post(baseUrl, body: params == null ? new Map(): params)
        .then((response) {
      print("${_UTIL_TAGS + _RES_STATUS_CODE}${response.statusCode}");
      print("${_UTIL_TAGS + _RES_BODY}${response.body}");
    });
  }

  /**
   *
   * （参数可选）@params: "parmeter": "value", "parmeter2": "value2"
   */
  void httpRequestNoClient(String baseUrl, {Map params}) {
    try {
      http.post(baseUrl, body: params == null ? new Map(): params)
          .then((response) {
        print("${_UTIL_TAGS + _RES_STATUS_CODE}${response.statusCode}");
        print("${_UTIL_TAGS + _RES_BODY}${response.body}");
      });
    } on HttpException {
      //指定的异常
      print('Http exception.');
    } on Exception catch (e) {
      //所有异常
      print('Unknown exception: $e');
    } finally {

    }
  }


}