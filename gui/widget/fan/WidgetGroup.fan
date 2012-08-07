//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** WidgetGroup is a Widget Container
**
@Js
class WidgetGroup : Widget
{

  Layout layout := FixedLayout()

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  private Widget[] children := Widget[,]


  **
  ** Iterate the children widgets.
  **
  Void each(|Widget w, Int i| f)
  {
    children.each(f)
  }

  **
  ** Remove a child widget
  **
  This remove(Widget child)
  {
    if (children.removeSame(child) == null)
      throw ArgErr("not my child: $child")
    child.setParent(null)
    return this
  }

  **
  ** Remove all child widgets.  Return this.
  **
  virtual This removeAll()
  {
    children.dup.each |Widget kid| { remove(kid) }
    return this
  }

  **
  ** Add a child widget.
  ** If child is already parented throw ArgErr.  Return this.
  **
  @Operator virtual This add(Widget child)
  {
    if (child.parent != null)
      throw ArgErr("Child already parented: $child")
    child.setParent(this)
    children.add(child)
    return this
  }

  override Widget? findById(Str id)
  {
    if (id == this.id) return this
    return children.eachWhile
    {
      it.findById(id)
    }
  }

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

  override This relayout() { layout.relayout(this); return this }
  override Size prefSize(Size? hints := null) { layout.prefSize(this, hints) }


//////////////////////////////////////////////////////////////////////////
// event
//////////////////////////////////////////////////////////////////////////

  override Void touch(MotionEvent e) {
    children.each {
      if (it.enabled) {
        it.touch(e)
      }
    }
  }

  override Void keyPress(KeyEvent e) {
    children.each {
      if (it.enabled) {
        it.keyPress(e)
      }
    }
  }

//////////////////////////////////////////////////////////////////////////
// Paint
//////////////////////////////////////////////////////////////////////////

  override Void paint(Graphics g)
  {
    if (!visible) return
    super.paint(g)
    paintChildren(g)
  }

  protected virtual Void paintChildren(Graphics g)
  {
    children.each
    {
      if (it.visible)
      {
        g.push
        g.clip(it.bounds)
        g.transform = g.transform.translate(it.pos.x.toFloat, it.pos.y.toFloat)
        it.paint(g)
        g.pop
      }
    }
  }

}