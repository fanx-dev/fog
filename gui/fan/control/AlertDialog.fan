//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** MessageBox
**
@Js
class AlertDialog : VBox
{
  Label label { private set }
  
  |Bool|? onAction

  new make(Str msg, Str okText := "OK", Str? cancelText := null)
  {
    label = Label {
      it.id = "alertDialog_msg"
      it.text = msg
      it.margin = Insets(20)
      it.textAlign = Align.center
    }
    
    hb := HBox {
        it.spacing = 80f
        Button {
          it.id = "alertDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(true)
          };
          it.text = okText
        },
    }
    
    if (cancelText != null) {
        bt := Button {
          it.id = "alertDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(false)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }

    this.add(label)
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.center

    this.layout.width = Layout.wrapContent//dpToPixel(500f)
    if (cancelText == null) {
        padding = Insets(30, 150)
    }
    else {
        padding = Insets(30, 70)
    }
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = 2
    overlayer.relayout
    this.moveInAnim(Direction.down).start
  }
}