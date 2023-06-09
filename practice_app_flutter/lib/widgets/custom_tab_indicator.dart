import 'package:flutter/material.dart';

class RoundedRectangleTabIndicator extends Decoration{
  final BoxPainter _painter;

  RoundedRectangleTabIndicator(
    {required Color color, required double weight, required double width}
  ): _painter = _RRectanglePainterColor(color, weight, width);

  @override
  BoxPainter createBoxPainter([void onChanged]) => _painter;
  }

  class _RRectanglePainterColor extends BoxPainter {
    final Paint _paint;
    final double weight;
    final double width;

    _RRectanglePainterColor(Color color, this.weight, this.width)
    : _paint = Paint()
     ..color = color
     ..isAntiAlias = true;

     @override
     void paint(Canvas canvas, Offset offset, ImageConfiguration imcfg){
      final Offset customoffset = offset + 
      Offset(imcfg.size!.width / 2 - (width * 0.5), imcfg.size!.height - weight);

      Rect myRect = customoffset & Size(width, weight);

      RRect myRRect = RRect.fromRectXY(myRect, weight, weight);

      canvas.drawRRect(myRRect, _paint);

     }
  }