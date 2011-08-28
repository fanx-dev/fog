#! /usr/bin/env fan
//
// Copyright (c) 2010, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-28  Jed Young  Creation
//

using build

**
** Build flux/ pods
**
class Build : BuildGroup
{

  new make()
  {
    //notice the order
    childrenScripts =
    [
      `array/build.fan`,
      `math/build.fan`,
      `gfx2/build.fan`,
      `gfx2Imp/build.fan`,
      `fogl/build.fan`,
      `jsTest/build.fan`,
    ]
  }

}