//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-18  Jed Young  Creation
//

package fan.vaseWindow;

import java.awt.image.BufferedImage;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import fan.vaseGraphics.*;
import fan.sys.Err;
import fan.std.MimeType;
import fan.std.OutStream;
import fan.sys.UnsupportedErr;
import fanx.interop.Interop;

public class WtkImage extends Image
{
    private BufferedImage image;
    public BufferedImage getImage(){ return image; };

    public void setImage(BufferedImage image)
    {
      this.image = image;
    }

    public Size size()
    {
      return Size.make(image.getWidth(null), image.getHeight(null));
    }

    public long width() {
      return image.getWidth(null);
    }

    public long height() {
      return image.getHeight(null);
    }

    public long getPixel(long x, long y)
    {
      return image.getRGB((int)x, (int)y);
    }
    public void setPixel(long x, long y, long value)
    {
      image.setRGB((int)x, (int)y, (int)value);
    }

    /**
     * save image to outSteam
     */
    public void save(OutStream out, String format)
    {
      OutputStream jout = Interop.toJava(out);
      String subType = format;

      try
      {
        ImageIO.write(image, subType, jout);
      }
      catch(java.io.IOException e)
      {
        throw Err.make(e);
      }
    }
    public void save(OutStream out)
    {
      save(out, "png");
    }
    public boolean isLoaded() { return image != null; }
    public boolean isReady() { return image != null; }

    /**
     * get graphics context from image
     */
    public Graphics createGraphics()
    {
      return new WtkGraphics(image.createGraphics());
    }

  @Override
  public void dispose() {
  }

  // @Override
  // public ConstImage toConst() {
  //   throw UnsupportedErr.make();
  // }
}