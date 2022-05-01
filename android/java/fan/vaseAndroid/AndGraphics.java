//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseAndroid;

import java.util.Stack;

import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.graphics.PorterDuff;
import fan.vaseGraphics.*;
import fan.sys.ArgErr;
import fan.sys.FanObj;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.DashPathEffect;

public class AndGraphics implements Graphics {

  Pen pen = Pen.defVal;
  Brush brush = Color.black;
  Font font;
  int alpha = 255;
  double lineWidth = 1.0;
  Composite composite = Composite.srcOver;

  Stack<State> stack = new Stack<State>();
  Canvas gc;
  Paint p = new Paint();
  public AndGraphics(Canvas c)
  {
    gc = c;
  }

  @Override
  public long alpha() {
    return alpha;
  }

  @Override
  public void alpha(long a) {
    alpha = (int)a;
    p.setAlpha(alpha);
  }

  @Override
  public double lineWidth() {
    return lineWidth;
  }

  @Override
  public void lineWidth(double w) {
    lineWidth = (int)w;
    p.setStrokeWidth((float)w);
  }

  @Override
  public boolean antialias() {
    return p.isAntiAlias();
  }

  @Override
  public void antialias(boolean a) {
    p.setAntiAlias(a);
  }

  @Override
  public Brush brush() {
    return brush;
  }

  @Override
  public void brush(Brush brush) {
    this.brush = brush;
    if (brush instanceof Color) {
      Color ca = (Color) brush;
      p.setColor((int) ca.argb);
      if (ca.a() == 0xff) p.setAlpha(alpha);
      p.setShader(null);
    } else if (brush instanceof Gradient) {
      Shader s = pattern((Gradient) brush, 0, 0, gc.getWidth(), gc.getHeight());
      p.setShader(s);
    } else if (brush instanceof fan.vaseGraphics.Pattern) {
      fan.vaseGraphics.Pattern pattern = (fan.vaseGraphics.Pattern) brush;
      Bitmap im = AndUtil.toAndImage(pattern.image);
      BitmapShader tp = new BitmapShader(im,
          toAndTileMode(pattern.halign),
          toAndTileMode(pattern.valign));
      p.setShader(tp);
    } else {
      throw ArgErr
          .make("Unsupported brush type: " + FanObj.typeof(brush));
    }
  }

  private static Shader.TileMode toAndTileMode(Halign h) {
    if (h == Halign.repeat)
      return Shader.TileMode.REPEAT;
    else
      return Shader.TileMode.CLAMP;
  }

  private static Shader.TileMode toAndTileMode(Valign h) {
    if (h == Valign.repeat)
      return Shader.TileMode.REPEAT;
    else
      return Shader.TileMode.CLAMP;
  }

  private static Shader pattern(Gradient g, float vx, float vy, float vw, float vh) {
    // only support two gradient stops
    GradientStop s1 = (GradientStop) g.stops.get(0);
    GradientStop s2 = (GradientStop) g.stops.get(-1L);
    boolean x1Percent = g.x1Unit == Gradient.percent;
    boolean y1Percent = g.y1Unit == Gradient.percent;
    boolean x2Percent = g.x2Unit == Gradient.percent;
    boolean y2Percent = g.y2Unit == Gradient.percent;

    // start
    float x1 = vx + g.x1;
    float y1 = vy + g.y1;
    float x2 = vx + g.x2;
    float y2 = vy + g.y2;

    // handle percentages
    if (x1Percent)
      x1 = vx + vw * g.x1 / 100f;
    if (y1Percent)
      y1 = vy + vh * g.y1 / 100f;
    if (x2Percent)
      x2 = vx + vw * g.x2 / 100f;
    if (y2Percent)
      y2 = vy + vh * g.y2 / 100f;

    return new LinearGradient(x1, y1, x2, y2, (int) s1.color.argb,
        (int) s2.color.argb, Shader.TileMode.REPEAT);
  }

  @Override
  public Graphics clip(Rect r) {
    gc.clipRect(r.x, r.y, r.x + r.w, r.y + r.h);
    return this;
  }

  static android.graphics.Rect toAndRect(Rect r) {
    return new android.graphics.Rect((int) r.x, (int) r.y,
        (int) (r.x + r.w), (int) (r.y + r.h));
  }

  @Override
  public Rect clipBounds() {
    android.graphics.Rect r = gc.getClipBounds();
    return Rect.make(r.left, r.top, r.right - r.left, r.bottom - r.top);
  }

  @Override
  public void dispose() {
    // gc.dispose();
  }

  @Override
  public Graphics drawArc(long x, long y, long w, long h, long s, long a) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.STROKE);
    gc.drawArc(r, -s, -a, false, p);
    return this;
  }

  @Override
  public Graphics drawLine(long x1, long y1, long x2, long y2) {
    gc.drawLine(x1, y1, x2, y2, p);
    return this;
  }

  @Override
  public Graphics drawOval(long x, long y, long w, long h) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.STROKE);
    gc.drawOval(r, p);
    return this;
  }


  @Override
  public Graphics drawRect(long x, long y, long w, long h) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawRect(x, y, x + w, y + h, p);
    return this;
  }

  @Override
  public Graphics drawRoundRect(long x, long y, long w, long h, long wArc,
      long hArc) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.STROKE);
    gc.drawRoundRect(r, wArc, hArc, p);
    return this;
  }
  @Override
  public Graphics drawText(String str, long x, long y) {
    p.setStyle(Paint.Style.FILL);
    gc.drawText(str, x, y, p);
    return this;
  }

  @Override
  public Graphics fillArc(long x, long y, long w, long h, long s, long a) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.FILL);
    gc.drawArc(r, -s, -a, true, p);
    return this;
  }

  @Override
  public Graphics fillOval(long x, long y, long w, long h) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.FILL);
    gc.drawOval(r, p);
    return this;
  }

  @Override
  public Graphics fillRect(long x, long y, long w, long h) {
    p.setStyle(Paint.Style.FILL);
    gc.drawRect(x, y, x + w, y + h, p);
    return this;
  }

  @Override
  public Graphics clearRect(long x, long y, long w, long h) {
    gc.save();
    gc.clipRect(x, y, x + w, y + h);
    if (brush instanceof Color) {
      Color ca = (Color) brush;
      gc.drawColor((int) ca.argb, PorterDuff.Mode.CLEAR);
    } else {
      gc.drawColor(0, PorterDuff.Mode.CLEAR);
    }
    gc.restore();
    return this;
  }

  @Override
  public Graphics fillRoundRect(long x, long y, long w, long h, long wArc,
      long hArc) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.FILL);
    gc.drawRoundRect(r, wArc, hArc, p);
    return this;
  }
  @Override
  public Font font() {
    return font;
  }
  @Override
  public void font(Font f) {
    this.font = f;
    Typeface typeface = AndUtil.toAndFont(f);
    p.setTypeface(typeface);

    //TODO: reset textSize
    if (typeface != null) p.setTextSize(f.size);
  }
  @Override
  public Pen pen() {
    return pen;
  }

  @Override
  public void pen(Pen pen) {
    this.pen = pen;
    p.setStrokeWidth(pen.width);
    p.setStrokeCap(penCap(pen.cap));
    p.setStrokeJoin(penJoin(pen.join));

    if (pen.dash != null) {
      p.setPathEffect(new DashPathEffect(AndUtil.toFloats(pen.dash), 0));
    }
  }

  private static Paint.Cap penCap(long cap) {
    if (cap == Pen.capSquare)
      return Paint.Cap.SQUARE;
    if (cap == Pen.capButt)
      return Paint.Cap.BUTT;
    if (cap == Pen.capRound)
      return Paint.Cap.ROUND;
    throw new IllegalStateException("Invalid pen.cap " + cap);
  }

  private static Paint.Join penJoin(long join) {
    if (join == Pen.joinMiter)
      return Paint.Join.MITER;
    if (join == Pen.joinBevel)
      return Paint.Join.BEVEL;
    if (join == Pen.joinRound)
      return Paint.Join.ROUND;
    throw new IllegalStateException("Invalid pen.join " + join);
  }

  @Override
  public Graphics clipPath(GraphicsPath path) {
    gc.clipPath(AndUtil.toAndPath(path));
    return this;
  }

  @Override
  public Graphics copyImage(Image img2, Rect src, Rect dest) {
    Bitmap img = AndUtil.toAndImage(img2);
    gc.drawBitmap(img, toAndRect(src), toAndRect(dest), p);
    return this;
  }

  @Override
  public Graphics drawImage(Image img2, long x, long y) {
    Bitmap img = AndUtil.toAndImage(img2);
    gc.drawBitmap(img, x, y, p);
    return this;
  }

  @Override
  public Graphics drawPath(GraphicsPath path) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawPath(AndUtil.toAndPath(path), p);
    return this;
  }

  @Override
  public Graphics drawPolyline(PointArray a) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawPath(AndUtil.palygonToPath(a), p);
    return this;
  }

  @Override
  public Graphics drawPolygon(PointArray list) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawPath(AndUtil.palygonToPath(list), p);
    return this;
  }

  @Override
  public Graphics fillPath(GraphicsPath path) {
    p.setStyle(Paint.Style.FILL);
    gc.drawPath(AndUtil.toAndPath(path), p);
    return this;
  }

  @Override
  public Graphics fillPolygon(PointArray a) {
    p.setStyle(Paint.Style.FILL);
    gc.drawPath(AndUtil.palygonToPath(a), p);
    return this;
  }

  @Override
  public Graphics transform(Transform2D trans) {
    gc.concat(AndUtil.toAndTransform(trans));
    return this;
  }

  public void push() {
    State s = new State();
    s.pen = pen;
    s.brush = brush;
    s.font = font;
    s.antialias = this.antialias();
    s.lineWidth = this.lineWidth;
    s.alpha = alpha;
    //s.transform = gc.getMatrix(mat);
    s.composite = composite;
    s.clip = gc.getClipBounds();
    stack.push(s);
    gc.save();
  }

  public void pop() {
    gc.restore();
    State s = (State) stack.pop();
    pen(s.pen);
    brush(s.brush);
    alpha(s.alpha);
    font(s.font);
    this.antialias(s.antialias);
    this.lineWidth(s.lineWidth);
    this.composite(s.composite);
    //gc.setMatrix(s.transform);
    gc.clipRect(s.clip);
  }

  //////////////////////////////////////////////////////////////////////////
  // Util
  //////////////////////////////////////////////////////////////////////////

  static class State {
    Pen pen;
    Brush brush;
    Font font;
    boolean antialias;
    int alpha;
    double lineWidth;
    Matrix transform;
    android.graphics.Rect clip;
    fan.vaseGraphics.Composite composite;
  }

  @Override
  public Composite composite() {
    return composite;
  }

  @Override
  public void composite(Composite cmp) {
    PorterDuffXfermode mode = AndUtil.toAndComposite(cmp);
    if (mode == null) {
      p.setXfermode(null);
      return;
    }
    p.setXfermode(mode);
    this.composite = cmp;
  }

  @Override
  public Graphics setShadow(fan.vaseGraphics.Shadow shadow) {
    if (shadow != null) {
      p.setShadowLayer((float)shadow.blur, (float)shadow.offsetX, (float)shadow.offsetY, (int)shadow.color.argb);
    } else {
      p.setShadowLayer(0, 0, 0, 0);
    }
    return this;
  }
}