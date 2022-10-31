//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   10 Aug 09  Brian Frank  Creation
//   2014-11-14 Jed Young Modify
//

using vaseGraphics


**
** EdgePane is a container which lays out four children along
** the four edges and one child in the center.  The top and
** bottom edges are laid out with their preferred height.  Children
** on the left or right edges are laid out with with their preferred
** width.  Any remaining space is given to the center component.
**
@Js
class EdgeBox : WidgetGroup
{
  new make() {
    layout.height = Layout.matchParent
    layout.width = Layout.matchParent
  }
//////////////////////////////////////////////////////////////////////////
// Children
//////////////////////////////////////////////////////////////////////////

  **
  ** Top widget is laid out with preferred height.
  **
  Widget? top { set { remove(&top); if (it != null) this.add(it); &top = it } }

  **
  ** Bottom widget is laid out with preferred height.
  **
  Widget? bottom { set { remove(&bottom); if (it != null) this.add(it); &bottom = it } }

  **
  ** Left widget is laid out with preferred width.
  **
  Widget? left  { set { remove(&left); if (it != null) this.add(it); &left = it } }

  **
  ** Right widget is laid out with preferred width.
  **
  Widget? right { set { remove(&right); if (it != null) this.add(it); &right = it } }

  **
  ** Center widget gets any remaining space in the center.
  **
  Widget? center { set { remove(&center); if (it != null) this.add(it); &center = it } }

//////////////////////////////////////////////////////////////////////////
// Layout
//////////////////////////////////////////////////////////////////////////

  override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1)
  {
    result := pref(this.top)
    top_w := result.w
    top_h := result.h

    result = pref(this.bottom)
    bottom_w := result.w
    bottom_h := result.h

    result = pref(this.left)
    left_w := result.w
    left_h := result.h

    result = pref(this.right)
    right_w := result.w
    right_h := result.h

    center := pref(this.center)

    w := (left_w + center.w + right_w).max(top_w).max(bottom_w)
    h := top_h + bottom_h + (left_h.max(center.h).max(right_h))
    //echo("prefW$w, center.w$center.w")
    //result.w = w
    //result.h = h
    return Size(w, h)
  }

  private Size pref(Widget? w)
  {
    if (w == null) {
      return Size(0, 0)
    }
    return w.bufferedPrefSize()
  }

  override Void layoutChildren(Bool force)
  {
    x := paddingLeft; y := paddingTop;
    w := contentWidth; h := contentHeight

    if (top != null)
    {
      prefh := top.bufferedPrefSize().h
      top.setLayout(x, y, w, prefh, force)
      y += prefh; h -= prefh
    }

    if (bottom != null)
    {
      prefh := bottom.bufferedPrefSize().h
      bottom.setLayout(x, y+h-prefh, w, prefh, force)
      h -= prefh
    }

    if (left != null)
    {
      prefw := left.bufferedPrefSize().w
      prefh := h
      left.setLayout(x, y, prefw, prefh, force)
      x += prefw; w -= prefw
    }

    if (right != null)
    {
      prefw := right.bufferedPrefSize().w
      prefh := h
      right.setLayout(x+w-prefw, y, prefw, prefh, force)
      w -= prefw
    }

    center := this.center
    if (center != null)
    {
      //mg := center.layout.margin
      center.setLayout(x, y, w, h, force)
    }
  }

}