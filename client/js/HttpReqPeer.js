//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   8 Jan 09   Andy Frank  Creation
//   20 May 09  Andy Frank  Refactor to new OO model
//   8 Jul 09   Andy Frank  Split webappClient into sys/dom
//

fan.vaseClient.HttpReqPeer = fan.sys.Obj.$extend(fan.sys.Obj);

fan.vaseClient.HttpReqPeer.prototype.$ctor = function(self) {}

fan.vaseClient.HttpReqPeer.prototype.send = function(self, method, content)
{
  if (Promise.prototype._then == undefined) {
    Promise.prototype._then = Promise.prototype.then;
    Promise.prototype.then = function(callback) {
      if (callback instanceof fan.sys.Func) {
        this._then(function(a){ callback.call(a); });
      }
      else {
        this._then(callback);
      }
    }
  }
  return new Promise(function(resolve, reject) {
    fan.vaseClient.HttpReqPeer.doRequest(self, method, content, resolve);
  });
}

fan.vaseClient.HttpReqPeer.doRequest = function(self, method, content, resolve)
{
  var xhr = new XMLHttpRequest();
  var buf;
  var view;

  // attach progress listener if configured
  if (self.m_cbProgress != null)
  {
    var _p = xhr;
    var _m = method.toUpperCase();
    if (_m == "POST" || _m == "PUT") _p = xhr.upload
    _p.addEventListener("progress", function(e) {
      if (e.lengthComputable) self.m_cbProgress.call(e.loaded, e.total);
    });
  }
  
  xhr.open(method.toUpperCase(), self.m_uri.m_str, true);

  xhr.onreadystatechange = function () {
    if (xhr.readyState == 4) {
      res = fan.vaseClient.HttpReqPeer.makeRes(xhr);
      resolve(res);
    }
  }

  var ct = false;
  var k = self.m_headers.keys();
  for (var i=0; i<k.size(); i++)
  {
    var key = k.get(i);
    if (fan.sys.Str.lower(key) == "content-type") ct = true;
    xhr.setRequestHeader(key, self.m_headers.get(key));
  }
  xhr.withCredentials = self.m_withCredentials;
  if (content == null)
  {
    xhr.send(null);
  }
  else if (fan.sys.ObjUtil.$typeof(content) === fan.sys.Str.$type)
  {
    // send text
    if (!ct) xhr.setRequestHeader("Content-Type", "text/plain");
    xhr.send(content);
  }
  else if (content instanceof fan.std.Buf)
  {
    // send binary
    if (!ct) xhr.setRequestHeader("Content-Type", "application/octet-stream");
    buf = new ArrayBuffer(content.size());
    view = new Uint8Array(buf);
    view.set(content.m_buf.slice(0, content.size()));
    xhr.send(view);
  }
  else if (content instanceof File)
  {
    // send file as raw data
    if (!ct) xhr.setRequestHeader("Content-Type", "application/octet-stream");
    var reader = new FileReader();
    reader.onloadend = function() { 
      if (reader.error) { 
        console.log(reader.error); 
      } else {
        //xhr.overrideMimeType("application/octet-stream");
        xhr.send(reader.result);
      }
    }
    reader.readAsBinaryString(content); 
  }
  else if (content instanceof fan.std.Map) {
    if (!ct) xhr.setRequestHeader("Content-Type", "multipart/form-data");
    var fd = new FormData();
    content.each(function(k, v) {
      fd.append(k, v);
    });
    xhr.send(fd);
  }
  else
  {
    throw fan.sys.Err.make("Can only send Str or Buf: " + content);
  }
}

fan.vaseClient.HttpReqPeer.makeRes = function(xhr)
{
  var res = fan.vaseClient.HttpRes.make();
  res.m_status  = xhr.status;
  res.m_content = xhr.responseText;

  var all = xhr.getAllResponseHeaders().split("\n");
  for (var i=0; i<all.length; i++)
  {
    if (all[i].length == 0) continue;
    var j = all[i].indexOf(":");
    var k = fan.sys.Str.trim(all[i].substr(0, j));
    var v = fan.sys.Str.trim(all[i].substr(j+1));
    res.m_headers.set(k, v);
  }

  return res;
}
/*
fan.vaseClient.HttpReqPeer.prototype.encodeForm = function(self, form)
{
  var content = ""
  var k = form.keys();
  for (var i=0; i<k.size(); i++)
  {
    if (i > 0) content += "&";
    content += encodeURIComponent(k.get(i)) + "=" +
               encodeURIComponent(form.get(k.get(i)));
  }
  return content;
}
*/
