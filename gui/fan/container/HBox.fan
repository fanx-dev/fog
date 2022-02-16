//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
@Serializable { collection = true }
class HBox : WidgetGroup
{
  Int spacing := 4
  
  Align align := Align.begin
  
  private Float weightSpace
  private Int alignOffset

  private Void calSpace() {
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    Int spacing := dpToPixel(this.spacing)

    Int spaceUsage := 0
    Float allWeight := 0f

    this.each |c, i|{
      if (c.layout.width == Layout.matchParent) {
        allWeight += c.layout.weight
      } else {
        size := c.bufferedPrefSize(-1, -1)
        spaceUsage += size.w
      }
      if (i > 0) spaceUsage += spacing
    }

    weightSpace = 1f
    alignOffset = 0
    
    if (hintsW <= spaceUsage) return
    
    if (allWeight>0f) {
      weightSpace = (hintsW - spaceUsage)/allWeight
    }
  
    if (align == Align.center) {
        alignOffset = ((hintsW - spaceUsage)/2).toInt
    }
    else if (align == Align.end) {
        alignOffset = (hintsW - spaceUsage)
    } 
  }

  override Void layoutChildren(Bool force)
  {
    Int x := paddingLeft
    Int y := paddingTop
    Int hintsW := contentWidth
    Int hintsH := contentHeight
    spacing := dpToPixel(this.spacing)
    calSpace()
    x += alignOffset

    this.each |Widget c|
    {
      size := c.bufferedPrefSize(hintsW, hintsH)
      cx := x
      cy := y

      cw := size.w
      ch := size.h
      if (c.layout.width == Layout.matchParent) {
        cw = (c.layout.weight*weightSpace).toInt
      }
      x += cw + spacing
      cy += c.layout.prefY(this, hintsW, hintsH, size.h)
    
      c.setLayout(cx, cy, cw, ch, force)
    }

  }

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    Int w := 0
    Int h := 0
    spacing := dpToPixel(this.spacing)
    this.each |c, i|
    {
      size := c.bufferedPrefSize(hintsWidth, hintsHeight)
      //echo("size$size")
      h = h.max(size.h)
      w += size.w
      if (i > 0) w += spacing
    }

    return Size(w, h)
  }
}