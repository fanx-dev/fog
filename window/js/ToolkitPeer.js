//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.ToolkitPeer = function(){}

fan.vaseWindow.ToolkitPeer.m_instance = null;

fan.vaseWindow.ToolkitPeer.cur = function() {
  if (fan.vaseWindow.ToolkitPeer.m_instance == null) {
   fan.concurrent.Actor.locals().set("vaseGraphics.env", fan.vaseWindow.GfxEnv.m_instance);
   //fan.concurrent.Actor.locals().set("vaseWindow.env", new fan.vaseWindow.Toolkit());
   fan.vaseWindow.ToolkitPeer.m_instance = new fan.vaseWindow.Toolkit();
 }
 return fan.vaseWindow.ToolkitPeer.m_instance;
}


fan.vaseWindow.Toolkit.prototype.window = function(view, options) {
  if (view) {
   this.m_curWindow = fan.vaseWindow.WtkWindow.make(view);
   this.m_curWindow.show(null);
  }
  return this.m_curWindow;
}

fan.vaseWindow.Toolkit.prototype.name = function() {
  return "HTML5"
}

fan.vaseWindow.Toolkit.prototype.$name = function() {
  return "HTML5"
}

fan.vaseWindow.Toolkit.prototype.gfxEnv = function() {
  return fan.vaseWindow.GfxEnv.m_instance;
}

// fan.vaseWindow.Toolkit.prototype.dpi = function() {
//   if (window.devicePixelRatio) {
//     return window.devicePixelRatio * 135;
//   }
//   return 135;
// }

// fan.vaseWindow.Toolkit.prototype.density = function() {
//   return 0.5;
// }

fan.vaseWindow.Toolkit.prototype.callLater = function(delay, callback)
{
  window.setTimeout(function(){ callback.call(); }, delay);
}

fan.vaseWindow.Toolkit.prototype.openUri = function(uri, options) {
  window.open(uri.toStr());
  //window.location.href=uri.toStr();
  return true;
}

fan.vaseWindow.Toolkit.prototype.clipboard = function()
{
  if (!fan.vaseWindow.Toolkit.m_clipboard) {
    fan.vaseWindow.Toolkit.m_clipboard = new fan.vaseWindow.JSClipboard();
  } 
  return fan.vaseWindow.Toolkit.m_clipboard;
}

fan.vaseWindow.Toolkit.resFileCache = {}
fan.vaseWindow.Toolkit.prototype.loadResFile = function(pod, uri) {
  var url = "/pod/"+pod+uri.toStr();

  var res = fan.vaseWindow.Toolkit.resFileCache[url]
  if (res) return res;

  var xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", url, false);
  xmlhttp.send();
  var res = xmlhttp.responseText;
  fan.vaseWindow.Toolkit.resFileCache[url] = res;
  return res
}

