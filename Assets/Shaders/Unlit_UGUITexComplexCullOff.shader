//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/UGUITexComplexCullOff" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_AlphaTex ("AlphaTex", 2D) = "white" { }
_BlendTex ("Blend Texture", 2D) = "white" { }
_Size ("大小选定", Range(0, 1)) = 1
_Move ("位移大小", Float) = 0
_Color ("Tint", Color) = (1,1,1,1)
_FlashColor ("ImageFlash", Color) = (1,1,1,0)
_ScalePic ("Scale Pic", Float) = 1
_OffsetPic ("Offset Pic", Float) = 0
_ScaleMask ("Scale Mask", Float) = 1
_OffsetMask ("Offset Mask", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_UseClip ("2DMaskClip", Float) = 0
_verticalFill ("Fill Amount (Vertical)", Range(0, 1)) = 1
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
  GpuProgramID 27909
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	float _Move;
uniform 	float _Size;
uniform 	float _ScalePic;
uniform 	float _OffsetPic;
uniform 	float _ScaleMask;
uniform 	float _OffsetMask;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
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
    u_xlat0.x = in_TEXCOORD0.x * _Size + _Move;
    u_xlat0.y = in_TEXCOORD0.y * _ScalePic + _OffsetPic;
    u_xlat0.w = in_TEXCOORD0.y * _ScaleMask + _OffsetMask;
    u_xlat0.z = in_TEXCOORD0.x;
    vs_TEXCOORD0 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	mediump vec4 _FlashColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _verticalFill;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _BlendTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
bool u_xlatb8;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4.xyz = texture2D(_AlphaTex, vs_TEXCOORD0.xy).xyw;
    u_xlatb8 = u_xlat4.y==0.0;
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.z : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = (_UseClipRect != 0) ? u_xlat0.x : u_xlat16_1;
    u_xlatb4 = _verticalFill<vs_TEXCOORD0.y;
    u_xlat0.x = (u_xlatb4) ? 0.0 : u_xlat0.x;
    u_xlat10_4 = texture2D(_BlendTex, vs_TEXCOORD0.zw).w;
    u_xlat4.x = u_xlat10_4 * vs_COLOR0.w;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat2 = u_xlat1 * vs_COLOR0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + _FlashColor.xyz;
    SV_Target0.xyz = _FlashColor.www * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    SV_Target0.w = u_xlat0.x;
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
uniform 	float _Move;
uniform 	float _Size;
uniform 	float _ScalePic;
uniform 	float _OffsetPic;
uniform 	float _ScaleMask;
uniform 	float _OffsetMask;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
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
    u_xlat0.x = in_TEXCOORD0.x * _Size + _Move;
    u_xlat0.y = in_TEXCOORD0.y * _ScalePic + _OffsetPic;
    u_xlat0.w = in_TEXCOORD0.y * _ScaleMask + _OffsetMask;
    u_xlat0.z = in_TEXCOORD0.x;
    vs_TEXCOORD0 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	mediump vec4 _FlashColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _verticalFill;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _BlendTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
bool u_xlatb8;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4.xyz = texture2D(_AlphaTex, vs_TEXCOORD0.xy).xyw;
    u_xlatb8 = u_xlat4.y==0.0;
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.z : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = (_UseClipRect != 0) ? u_xlat0.x : u_xlat16_1;
    u_xlatb4 = _verticalFill<vs_TEXCOORD0.y;
    u_xlat0.x = (u_xlatb4) ? 0.0 : u_xlat0.x;
    u_xlat10_4 = texture2D(_BlendTex, vs_TEXCOORD0.zw).w;
    u_xlat4.x = u_xlat10_4 * vs_COLOR0.w;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat2 = u_xlat1 * vs_COLOR0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + _FlashColor.xyz;
    SV_Target0.xyz = _FlashColor.www * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    SV_Target0.w = u_xlat0.x;
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
uniform 	float _Move;
uniform 	float _Size;
uniform 	float _ScalePic;
uniform 	float _OffsetPic;
uniform 	float _ScaleMask;
uniform 	float _OffsetMask;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
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
    u_xlat0.x = in_TEXCOORD0.x * _Size + _Move;
    u_xlat0.y = in_TEXCOORD0.y * _ScalePic + _OffsetPic;
    u_xlat0.w = in_TEXCOORD0.y * _ScaleMask + _OffsetMask;
    u_xlat0.z = in_TEXCOORD0.x;
    vs_TEXCOORD0 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	mediump vec4 _FlashColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _verticalFill;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _BlendTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
bool u_xlatb8;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4.xyz = texture2D(_AlphaTex, vs_TEXCOORD0.xy).xyw;
    u_xlatb8 = u_xlat4.y==0.0;
    u_xlat16_1 = (u_xlatb8) ? u_xlat4.z : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = (_UseClipRect != 0) ? u_xlat0.x : u_xlat16_1;
    u_xlatb4 = _verticalFill<vs_TEXCOORD0.y;
    u_xlat0.x = (u_xlatb4) ? 0.0 : u_xlat0.x;
    u_xlat10_4 = texture2D(_BlendTex, vs_TEXCOORD0.zw).w;
    u_xlat4.x = u_xlat10_4 * vs_COLOR0.w;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat2 = u_xlat1 * vs_COLOR0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + _FlashColor.xyz;
    SV_Target0.xyz = _FlashColor.www * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    SV_Target0.w = u_xlat0.x;
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
}
}
}
}