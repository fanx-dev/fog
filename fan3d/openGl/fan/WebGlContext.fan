//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fgfxArray

**
** Stub for native implementation of GlContext
**
@Js
internal native class WebGlContext : GlContext
{
  override native Void bindTexture(GlEnum target, GlTexture? texture)
  override native Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)
  override native Int getProgramParameter(GlProgram program, GlEnum pname)
  override native Int getShaderParameter(GlShader shader, GlEnum pname)
  override native Str getShaderInfoLog(GlShader shader)
  override native Void uniformMatrix4fv(GlUniformLocation location, Bool transpose, ArrayBuffer value)
  override native Void texImage2DBuffer(GlEnum target, Int level, GlEnum internalformat, Int width, Int height, Int border, GlEnum format, GlEnum type, ArrayBuffer pixels)
  override native Void texImage2D(GlEnum target, Int level, GlEnum internalformat, GlEnum format, GlEnum type, GlImage image)


//////////////////////////////////////////////////////////////////////////
// special
//////////////////////////////////////////////////////////////////////////

//  override native null getContextAttributes()
//  override native Bool isContextLost()
//  override native Str[] getSupportedExtensions()
//  override native null getExtension(Str name)
//  override native Void bindTexture(GlEnum target, GlTexture texture)
//  override native Void bufferData(GlEnum target, Int size, GlEnum usage)
//  override native Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)
//  override native Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)
//  override native Void bufferSubData(GlEnum target, Int offset, ArrayBuffer data)
//  override native Void bufferSubData(GlEnum target, Int offset, ArrayBuffer data)
//  override native GlEnum checkFramebufferStatus(GlEnum target)
//  override native GlActiveInfo getActiveAttrib(GlProgram program, Int index)
//  override native GlActiveInfo getActiveUniform(GlProgram program, Int index)
//  override native GlShader[] getAttachedShaders(GlProgram program)
//  override native null getParameter(GlEnum pname)
//  override native null getBufferParameter(GlEnum target, GlEnum pname)
//  override native GlEnum getError()
//  override native null getFramebufferAttachmentParameter(GlEnum target, GlEnum attachment, GlEnum pname)
//  override native null getProgramParameter(GlProgram program, GlEnum pname)
//  override native Str getProgramInfoLog(GlProgram program)
//  override native null getRenderbufferParameter(GlEnum target, GlEnum pname)
//  override native null getShaderParameter(GlShader shader, GlEnum pname)
//  override native Str getShaderInfoLog(GlShader shader)
//  override native Str getShaderSource(GlShader shader)
//  override native null getTexParameter(GlEnum target, GlEnum pname)
//  override native null getUniform(GlProgram program, GlUniformLocation location)
//  override native null getVertexAttrib(Int index, GlEnum pname)
//  override native Int getVertexAttribOffset(Int index, GlEnum pname)
//  override native Void readPixels(Int x, Int y, Int width, Int height, GlEnum format, GlEnum type, ArrayBuffer pixels)
//  override native Void texImage2D(GlEnum target, Int level, GlEnum internalformat, Int width, Int height, Int border, GlEnum format, GlEnum type, ArrayBuffer pixels)
//  override native Void texImage2D(GlEnum target, Int level, GlEnum internalformat, GlEnum format, GlEnum type, null pixels)
//  override native Void texImage2D(GlEnum target, Int level, GlEnum internalformat, GlEnum format, GlEnum type, Image image)
//  override native Void texImage2D(GlEnum target, Int level, GlEnum internalformat, GlEnum format, GlEnum type, null canvas)
//  override native Void texImage2D(GlEnum target, Int level, GlEnum internalformat, GlEnum format, GlEnum type, null video)
//  override native Void texSubImage2D(GlEnum target, Int level, Int xoffset, Int yoffset, Int width, Int height, GlEnum format, GlEnum type, ArrayBuffer pixels)
//  override native Void texSubImage2D(GlEnum target, Int level, Int xoffset, Int yoffset, GlEnum format, GlEnum type, null pixels)
//  override native Void texSubImage2D(GlEnum target, Int level, Int xoffset, Int yoffset, GlEnum format, GlEnum type, Image image)
//  override native Void texSubImage2D(GlEnum target, Int level, Int xoffset, Int yoffset, GlEnum format, GlEnum type, null canvas)
//  override native Void texSubImage2D(GlEnum target, Int level, Int xoffset, Int yoffset, GlEnum format, GlEnum type, null video)
//  override native Void uniform1fv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform1fv(GlUniformLocation location, Float[] v)
//  override native Void uniform1iv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform1iv(GlUniformLocation location, Int[] v)
//  override native Void uniform2fv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform2fv(GlUniformLocation location, Float[] v)
//  override native Void uniform2iv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform2iv(GlUniformLocation location, Int[] v)
//  override native Void uniform3fv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform3fv(GlUniformLocation location, Float[] v)
//  override native Void uniform3iv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform3iv(GlUniformLocation location, Int[] v)
//  override native Void uniform4fv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform4fv(GlUniformLocation location, Float[] v)
//  override native Void uniform4iv(GlUniformLocation location, ArrayBuffer v)
//  override native Void uniform4iv(GlUniformLocation location, Int[] v)
//  override native Void uniformMatrix2fv(GlUniformLocation location, Bool transpose, ArrayBuffer value)
//  override native Void uniformMatrix2fv(GlUniformLocation location, Bool transpose, Float[] value)
//  override native Void uniformMatrix3fv(GlUniformLocation location, Bool transpose, ArrayBuffer value)
//  override native Void uniformMatrix3fv(GlUniformLocation location, Bool transpose, Float[] value)
//  override native Void uniformMatrix4fv(GlUniformLocation location, Bool transpose, ArrayBuffer value)
//  override native Void uniformMatrix4fv(GlUniformLocation location, Bool transpose, Float[] value)
//  override native Void vertexAttrib1fv(Int indx, ArrayBuffer values)
//  override native Void vertexAttrib1fv(Int indx, Float[] values)
//  override native Void vertexAttrib2fv(Int indx, ArrayBuffer values)
//  override native Void vertexAttrib2fv(Int indx, Float[] values)
//  override native Void vertexAttrib3fv(Int indx, ArrayBuffer values)
//  override native Void vertexAttrib3fv(Int indx, Float[] values)
//  override native Void vertexAttrib4fv(Int indx, ArrayBuffer values)
//  override native Void vertexAttrib4fv(Int indx, Float[] values)

//////////////////////////////////////////////////////////////////////////
// Gen
//////////////////////////////////////////////////////////////////////////

  override native Void activeTexture(GlEnum texture)
  override native Void attachShader(GlProgram program, GlShader shader)
  override native Void bindAttribLocation(GlProgram program, Int index, Str name)
  override native Void bindBuffer(GlEnum target, GlBuffer buffer)
  override native Void bindFramebuffer(GlEnum target, GlFramebuffer framebuffer)
  override native Void bindRenderbuffer(GlEnum target, GlRenderbuffer renderbuffer)
  override native Void blendColor(Float red, Float green, Float blue, Float alpha)
  override native Void blendEquation(GlEnum mode)
  override native Void blendEquationSeparate(GlEnum modeRGB, GlEnum modeAlpha)
  override native Void blendFunc(GlEnum sfactor, GlEnum dfactor)
  override native Void blendFuncSeparate(GlEnum srcRGB, GlEnum dstRGB, GlEnum srcAlpha, GlEnum dstAlpha)
  override native Void clear(GlEnum mask)
  override native Void clearColor(Float red, Float green, Float blue, Float alpha)
  override native Void clearDepth(Float depth)
  override native Void clearStencil(Int s)
  override native Void colorMask(Bool red, Bool green, Bool blue, Bool alpha)
  override native Void compileShader(GlShader shader)
  override native Void copyTexImage2D(GlEnum target, Int level, GlEnum internalformat, Int x, Int y, Int width, Int height, Int border)
  override native Void copyTexSubImage2D(GlEnum target, Int level, Int xoffset, Int yoffset, Int x, Int y, Int width, Int height)
  override native GlBuffer createBuffer()
  override native GlFramebuffer createFramebuffer()
  override native GlProgram createProgram()
  override native GlRenderbuffer createRenderbuffer()
  override native GlShader createShader(GlEnum type)
  override native GlTexture createTexture()
  override native Void cullFace(GlEnum mode)
  override native Void deleteBuffer(GlBuffer buffer)
  override native Void deleteFramebuffer(GlFramebuffer framebuffer)
  override native Void deleteProgram(GlProgram program)
  override native Void deleteRenderbuffer(GlRenderbuffer renderbuffer)
  override native Void deleteShader(GlShader shader)
  override native Void deleteTexture(GlTexture texture)
  override native Void depthFunc(GlEnum func)
  override native Void depthMask(Bool flag)
  override native Void depthRange(Float zNear, Float zFar)
  override native Void detachShader(GlProgram program, GlShader shader)
  override native Void disable(GlEnum cap)
  override native Void disableVertexAttribArray(Int index)
  override native Void drawArrays(GlEnum mode, Int first, Int count)
  override native Void drawElements(GlEnum mode, Int count, GlEnum type, Int offset)
  override native Void enable(GlEnum cap)
  override native Void enableVertexAttribArray(Int index)
  override native Void finish()
  override native Void flush()
  override native Void framebufferRenderbuffer(GlEnum target, GlEnum attachment, GlEnum renderbuffertarget, GlRenderbuffer renderbuffer)
  override native Void framebufferTexture2D(GlEnum target, GlEnum attachment, GlEnum textarget, GlTexture texture, Int level)
  override native Void frontFace(GlEnum mode)
  override native Void generateMipmap(GlEnum target)
  override native Int getAttribLocation(GlProgram program, Str name)
  override native GlUniformLocation getUniformLocation(GlProgram program, Str name)
  override native Void hint(GlEnum target, GlEnum mode)
  override native Bool isBuffer(GlBuffer buffer)
  override native Bool isEnabled(GlEnum cap)
  override native Bool isFramebuffer(GlFramebuffer framebuffer)
  override native Bool isProgram(GlProgram program)
  override native Bool isRenderbuffer(GlRenderbuffer renderbuffer)
  override native Bool isShader(GlShader shader)
  override native Bool isTexture(GlTexture texture)
  override native Void lineWidth(Float width)
  override native Void linkProgram(GlProgram program)
  override native Void pixelStorei(GlEnum pname, Int param)
  override native Void polygonOffset(Float factor, Float units)
  override native Void renderbufferStorage(GlEnum target, GlEnum internalformat, Int width, Int height)
  override native Void sampleCoverage(Float value, Bool invert)
  override native Void scissor(Int x, Int y, Int width, Int height)
  override native Void shaderSource(GlShader shader, Str source)
  override native Void stencilFunc(GlEnum func, Int ref, Int mask)
  override native Void stencilFuncSeparate(GlEnum face, GlEnum func, Int ref, Int mask)
  override native Void stencilMask(Int mask)
  override native Void stencilMaskSeparate(GlEnum face, Int mask)
  override native Void stencilOp(GlEnum fail, GlEnum zfail, GlEnum zpass)
  override native Void stencilOpSeparate(GlEnum face, GlEnum fail, GlEnum zfail, GlEnum zpass)
  override native Void texParameterf(GlEnum target, GlEnum pname, Float param)
  override native Void texParameteri(GlEnum target, GlEnum pname, Int param)
  override native Void uniform1f(GlUniformLocation location, Float x)
  override native Void uniform1i(GlUniformLocation location, Int x)
  override native Void uniform2f(GlUniformLocation location, Float x, Float y)
  override native Void uniform2i(GlUniformLocation location, Int x, Int y)
  override native Void uniform3f(GlUniformLocation location, Float x, Float y, Float z)
  override native Void uniform3i(GlUniformLocation location, Int x, Int y, Int z)
  override native Void uniform4f(GlUniformLocation location, Float x, Float y, Float z, Float w)
  override native Void uniform4i(GlUniformLocation location, Int x, Int y, Int z, Int w)
  override native Void useProgram(GlProgram program)
  override native Void validateProgram(GlProgram program)
  override native Void vertexAttrib1f(Int indx, Float x)
  override native Void vertexAttrib2f(Int indx, Float x, Float y)
  override native Void vertexAttrib3f(Int indx, Float x, Float y, Float z)
  override native Void vertexAttrib4f(Int indx, Float x, Float y, Float z, Float w)
  override native Void vertexAttribPointer(Int indx, Int size, GlEnum type, Bool normalized, Int stride, Int offset)
  override native Void viewport(Int x, Int y, Int width, Int height)
}