#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-06-04  Jed Young  Creation
//

using build

class Build : BuildPod
{
  new make()
  {
    podName  = "vaseWindow"
    summary  = "Window toolkit"
    depends  = ["sys 2.0", "std 1.0", "vaseGraphics 1.0", "concurrent 1.0", "vaseMath 1.0"]
    srcDirs  = [`fan/`, `fan/event/`, `fan/graphics/`]
    javaDirs = [`java/`]
    jsDirs   = [`js/`]
    //docSrc   = true
  }
}