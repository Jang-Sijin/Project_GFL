//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/UIDirectionFade" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Controler ("控制", Range(0, 1)) = 0
_DirectionX ("X方向", Float) = 1
_DirectionY ("Y方向", Float) = 0
_FadeRange ("过度范围", Range(1, 10)) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 304
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat4 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat6 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat6, u_xlat4);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat6 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat6, u_xlat1.x);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat6 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat6, u_xlat1.x);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat0.xy = (-vec2(u_xlat4)) + u_xlat0.xy;
    u_xlat2 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = min(u_xlat0.x, u_xlat1.w);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat4 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat6 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat6, u_xlat4);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat6 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat6, u_xlat1.x);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat6 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat6, u_xlat1.x);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat0.xy = (-vec2(u_xlat4)) + u_xlat0.xy;
    u_xlat2 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = min(u_xlat0.x, u_xlat1.w);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat4 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat6 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat6, u_xlat4);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat6 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat6, u_xlat1.x);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat6 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat6, u_xlat1.x);
    u_xlat4 = max(u_xlat6, u_xlat4);
    u_xlat0.xy = (-vec2(u_xlat4)) + u_xlat0.xy;
    u_xlat2 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = min(u_xlat0.x, u_xlat1.w);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat6 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat9 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat6);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat0.xy = (-vec2(u_xlat6)) + u_xlat0.xy;
    u_xlat3 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = min(u_xlat0.x, u_xlat1.w);
    SV_Target0 = u_xlat1;
    u_xlat16_2 = u_xlat1.w + -0.00100000005;
    u_xlatb0 = u_xlat16_2<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat6 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat9 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat6);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat0.xy = (-vec2(u_xlat6)) + u_xlat0.xy;
    u_xlat3 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = min(u_xlat0.x, u_xlat1.w);
    SV_Target0 = u_xlat1;
    u_xlat16_2 = u_xlat1.w + -0.00100000005;
    u_xlatb0 = u_xlat16_2<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat6 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat9 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat6);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat0.xy = (-vec2(u_xlat6)) + u_xlat0.xy;
    u_xlat3 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = min(u_xlat0.x, u_xlat1.w);
    SV_Target0 = u_xlat1;
    u_xlat16_2 = u_xlat1.w + -0.00100000005;
    u_xlatb0 = u_xlat16_2<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _ClipRect;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat6 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat9 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat6);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat0.xy = (-vec2(u_xlat6)) + u_xlat0.xy;
    u_xlat3.x = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat0.x = min(u_xlat0.x, u_xlat1.w);
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _ClipRect;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat6 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat9 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat6);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat0.xy = (-vec2(u_xlat6)) + u_xlat0.xy;
    u_xlat3.x = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat0.x = min(u_xlat0.x, u_xlat1.w);
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _ClipRect;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat6 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat9 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat6);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat9 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat9, u_xlat1.x);
    u_xlat6 = max(u_xlat9, u_xlat6);
    u_xlat0.xy = (-vec2(u_xlat6)) + u_xlat0.xy;
    u_xlat3.x = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat0.x = min(u_xlat0.x, u_xlat1.w);
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat1.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _ClipRect;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bvec2 u_xlatb4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat8 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat12 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat12, u_xlat8);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat12 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat12, u_xlat1.x);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat12 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat12, u_xlat1.x);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat0.xy = (-vec2(u_xlat8)) + u_xlat0.xy;
    u_xlat4.x = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat0.x = min(u_xlat0.x, u_xlat1.w);
    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat4.xy = u_xlat4.xy * u_xlat2.xy;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + -0.00100000005;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    u_xlatb0 = u_xlat16_3<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _ClipRect;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bvec2 u_xlatb4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat8 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat12 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat12, u_xlat8);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat12 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat12, u_xlat1.x);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat12 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat12, u_xlat1.x);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat0.xy = (-vec2(u_xlat8)) + u_xlat0.xy;
    u_xlat4.x = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat0.x = min(u_xlat0.x, u_xlat1.w);
    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat4.xy = u_xlat4.xy * u_xlat2.xy;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + -0.00100000005;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    u_xlatb0 = u_xlat16_3<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Controler;
uniform 	float _DirectionX;
uniform 	float _DirectionY;
uniform 	vec4 _ClipRect;
uniform 	vec4 _CurrentRect;
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bvec2 u_xlatb4;
float u_xlat8;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(vec2(_DirectionX, _DirectionY), vec2(_DirectionX, _DirectionY));
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * vec2(_DirectionX, _DirectionY);
    u_xlat8 = dot(_CurrentRect.xy, u_xlat0.xy);
    u_xlat12 = dot(_CurrentRect.xw, u_xlat0.xy);
    u_xlat1.x = min(u_xlat12, u_xlat8);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat12 = dot(_CurrentRect.zy, u_xlat0.xy);
    u_xlat1.x = min(u_xlat12, u_xlat1.x);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat12 = dot(_CurrentRect.zw, u_xlat0.xy);
    u_xlat0.x = dot(vs_TEXCOORD1.xy, u_xlat0.xy);
    u_xlat0.y = min(u_xlat12, u_xlat1.x);
    u_xlat8 = max(u_xlat12, u_xlat8);
    u_xlat0.xy = (-vec2(u_xlat8)) + u_xlat0.xy;
    u_xlat4.x = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlatb0 = _Controler<u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat0.x = min(u_xlat0.x, u_xlat1.w);
    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat4.xy = u_xlat4.xy * u_xlat2.xy;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + -0.00100000005;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    u_xlatb0 = u_xlat16_3<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
""
}
}
}
}
}