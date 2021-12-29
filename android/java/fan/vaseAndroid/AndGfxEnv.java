//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseAndroid;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Region;
import fan.vaseGraphics.Font;
import fan.vaseGraphics.GfxEnv;
import fan.vaseGraphics.Image;
import fan.vaseGraphics.GraphicsPath;
import fan.vaseGraphics.PointArray;
import fan.vaseGraphics.Size;
import fan.sys.*;
import fan.std.*;
import fanx.interop.Interop;

public class AndGfxEnv extends GfxEnv{

  static final AndGfxEnv instance = new AndGfxEnv();
  private AndGfxEnv() {}

  @Override
  public boolean contains(GraphicsPath path, double x, double y) {
    android.graphics.Path p = AndUtil.toAndPath(path);
    Region r = new Region();
    r.setPath(p, null);
    return r.contains((int) x, (int) y);
  }

  @Override
  public Image fromStream(InStream in) {
    InputStream jin = Interop.toJava(in);
    Bitmap image = BitmapFactory.decodeStream(jin);
    AndImage p = new AndImage();
    p.setImage(image);
    return p;
  }

  @Override
  public Image fromUri(Uri uri, fan.std.Map options, Func onLoad) {

    if ("http".equals(uri.scheme()) || "https".equals(uri.scheme())) {
      onLoad = (Func) onLoad.toImmutable();
      AndImage p = new AndImage();
      loadFromWeb(p, uri, options, onLoad);
      return p;
    }

    InStream fin = null;
    if (uri.scheme() != null) {
      fin = ((fan.std.File) uri.get()).in();
    }
    else {
      fin = ((fan.std.File) uri.toFile()).in();
    }
    InputStream jin = Interop.toJava(fin);
    Bitmap image = BitmapFactory.decodeStream(jin);
    AndImage p = new AndImage();
    p.setImage(image);
    fin.close();
    if (onLoad != null) onLoad.call(p);
    return p;
  }

  public void _swapImage(Image dscImg, Image newImg) {
    Bitmap b = ((AndImage)dscImg).getImage();
    ((AndImage)dscImg).setImage(((AndImage)newImg).getImage());
    ((AndImage)newImg).setImage(b);
  }

  private static void loadFromWeb(final Image p, final Uri uri, fan.std.Map options, 
      final Func onLoad) {
    Object v = fan.concurrent.Actor.locals().get("vaseWindow.loadImage");
    if (v == null) throw fan.sys.Err.make("not found vaseWindow.loadImage");
    ((Func)v).call(p, uri, onLoad);
  }

  @Override
  public Font makeFont(Func func) {
    return AndFont.makeFont(func);
  }

  @Override
  public Image makeImage(Size size) {
    Bitmap image = Bitmap.createBitmap((int) size.w, (int) size.h,
        Bitmap.Config.ARGB_4444);
    AndImage p = new AndImage();
    p.setImage(image);
    return p;
  }

  @Override
  public PointArray makePointArray(long size) {
    return new AndPointArray((int)size);
  }

}