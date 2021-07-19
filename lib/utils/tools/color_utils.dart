/*
 * @Description  : 颜色工具类
 * @Date         : 2021-07-05 14:19:55
 * @Author       : 保锋
 * @LastEditTime : 2021-07-05 15:55:38
 * @LastEditors  : 保锋
 * @FilePath     : \knowledge_contest\lib\utils\tools\color_utils.dart
 */
import 'dart:math';
import 'dart:ui';

class ColorUtils {
  ///获取随机颜色
  static Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
    );
  }

  int abc = 1;
  static int seed = -1;

  ///伪随机数
  static double seededRandom({double max = 1.0, double min = 0.0}) {
    ColorUtils.seed = (ColorUtils.seed * 9301 + 49297) % 233280;

    final double rnd = ColorUtils.seed / 233280.0;

    return min + rnd * (max - min);
  }

  ///获取随机颜色（更漂亮的颜色，依据黄金分割法）
  static Color getPrettyRandomColor() {
    ///hsv转rgb
    Color hsvtorgb(double h, double s, double v) {
      final int hI = (h * 6).toInt();
      final double f = h * 6 - hI;
      final double p = v * (1 - s);
      final double q = v * (1 - f * s);
      final double t = v * (1 - (1 - f) * s);
      double r, g, b;
      switch (hI) {
        case 0:
          r = v;
          g = t;
          b = p;
          break;
        case 1:
          r = q;
          g = v;
          b = p;
          break;
        case 2:
          r = p;
          g = v;
          b = t;
          break;
        case 3:
          r = p;
          g = q;
          b = v;
          break;
        case 4:
          r = t;
          g = p;
          b = v;
          break;
        case 5:
          r = v;
          g = p;
          b = q;
          break;
        default:
          r = 1;
          g = 1;
          b = 1;
      }
      return Color.fromRGBO(
          (r * 255).toInt(), (g * 255).toInt(), (b * 255).toInt(), 1);
    }

    const double goldenRatio = 0.618033988749895;
    const double s = 0.5;
    const double v = 0.99;
    final double h = goldenRatio + ColorUtils.seededRandom(max: -0.7, min: 0.3);
    return hsvtorgb(h, s, v);
  }

  ///十六进制记法  #FF000000  取值范围为：00 - FF。
  ///RGB色彩是通过对红(R)、绿(G)、蓝(B)
  ///   三个颜色通道的变化和它们相互之间的叠加来得到各式各样的颜色的。
  ///RGBA此色彩模式与RGB相同，只是在RGB模式上新增了Alpha透明度。

  ///获取随机透明的白色
  static Color getRandonWhightColor(Random random) {
    //0~255 0为完全透明 255 为不透明
    //这里生成的透明度取值范围为 10~200
    final int a = random.nextInt(190) + 10;
    return Color.fromARGB(a, 255, 255, 255);
  }
}
