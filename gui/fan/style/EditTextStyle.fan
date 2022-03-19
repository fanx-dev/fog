//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class EditTextStyle : WidgetStyle
{
  Color hintColor := Color(0xd7d7d7)

  new make() {
    outlineColor = Color(0x858585)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    EditText lab := widget
    top := widget.paddingTop
    left := widget.paddingLeft

    g.brush = outlineColor
    lWidth := dpToPixel(lineWidth)
    g.pen = Pen { it.width = lWidth }

    lineLeft := lWidth
    bottom := top + widget.contentHeight-lWidth
    right := widget.width - lWidth

    g.drawLine(lineLeft, bottom, right-lWidth, bottom)
    upSize := (lab.font.height * 0.3f).toInt
    g.drawLine(lineLeft, bottom, lineLeft, bottom-upSize)
    g.drawLine(right-lWidth, bottom, right-lWidth, bottom-upSize)

    font := this.font(widget)
    g.font = font
    offset := font.ascent + font.leading
    x := left
    y := top

    if (!lab.text.isEmpty) {
      g.brush = fontColor
      str := lab.text
      if (lab.password) {
        buf := StrBuf()
        str.size.times{
          buf.add("*")
        }
        str = buf.toStr
      }
      if (lab.lines == null) {
        g.drawText(str, x, y+offset)
      }
      else {
        for (i:=0; i<lab.lines.size; ++i) {
            g.drawText(lab.lines[i], x, y+offset)
            y += font.height
        }
      }
    }
    else if (!lab.hint.isEmpty) {
      g.brush = hintColor
      g.drawText(lab.hint, x+2, y+offset)
    }

    if (lab.caret.visible)
    {
      Int xOffset := 1
      if (lab.text.size > 0)
      {
        xOffset = lab.font.width(lab.text[0..<lab.caret.offset])
      }
      g.drawLine(x+xOffset, y, x+xOffset, y+lab.font.height)
    }
  }
}