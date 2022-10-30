package fan.vaseWindow;

import fan.sys.Func;

import fan.vaseGraphics.*;

public class WtkFont extends Font {

  private java.awt.Font nfont = null;
  private java.awt.FontMetrics fontMetrics = null;

  public static Font makeAwtFont(Func func)
  {
    Font f = new WtkFont();
    //func.enterCtor(f);
    func.call(f);
    //func.exitCtor();
    return f;
  }

  public java.awt.Font getNFont() {
    if (nfont == null) {
      nfont = WtkUtil.toFont(this);
    }
    return nfont;
  }

  void bind(java.awt.Graphics2D g) {
    fontMetrics = g.getFontMetrics(getNFont());
  }

  void unbind() {
    fontMetrics = null;
  }

  public java.awt.FontMetrics getFontMetrics() {
    if (fontMetrics == null) {
      fontMetrics = WtkUtil.scratchG().getFontMetrics(getNFont());
    }
    return fontMetrics;
  }


  @Override
  public long ascent() {
    return getFontMetrics().getAscent();
  }

  @Override
  public long descent() {
    return getFontMetrics().getDescent();
  }

  @Override
  public void dispose() {
  }

  @Override
  public long height() {
    return getFontMetrics().getHeight();
  }

  @Override
  public long leading() {
    return getFontMetrics().getLeading();
  }

  @Override
  public long width(String s) {
    return getFontMetrics().stringWidth(s);
  }

}