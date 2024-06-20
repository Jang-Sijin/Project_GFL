//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ImageRefract" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_ShowColor ("纯背景到融合", Range(0, 1)) = 0
_MainEffect ("原图调整", Range(0, 3)) = 1
_RFocus ("R偏移", Range(0, 1000)) = 10
_GFocus ("G偏移", Range(0, 1000)) = 10
_BFocus ("B偏移", Range(0, 1000)) = 10
_Height ("放大缩小", Range(-1, 1)) = 0
_DirX ("色散影响范围", Range(0, 10)) = 10
_DirY ("色散偏移度", Range(0, 0.1)) = 0.01
_DirZ ("色散强度", Range(0, 1)) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 GrabPass {
  "_GrabTexture"
}
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
  GpuProgramID 11174
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w + -0.00999999978;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.x = dot(u_xlat0, u_xlat0);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_1.x = (-u_xlat0.z) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat20 = log2(u_xlat16_1.x);
    u_xlat20 = u_xlat20 * _DirX;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = u_xlat20 * _DirZ;
    u_xlat2.xy = u_xlat2.xy * vec2(_RFocus, _GFocus);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * _BFocus + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xx * _GrabTexture_TexelSize.xy;
    u_xlat3.y = _DirY;
    u_xlat3.x = 0.0;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat3 = u_xlat2.xyxy * u_xlat16_1.wwww + u_xlat3.yxxy;
    u_xlat3 = vs_TEXCOORD2.wwww * u_xlat3 + vs_TEXCOORD2.xyxy;
    u_xlat3 = u_xlat3 / vs_TEXCOORD2.wwww;
    u_xlat4.x = texture2D(_GrabTexture, u_xlat3.xy).x;
    u_xlat4.z = texture2D(_GrabTexture, u_xlat3.zw).z;
    u_xlat3.xy = u_xlat2.xy * u_xlat16_1.ww + vec2(vec2(_DirY, _DirY));
    u_xlat2.xy = u_xlat16_1.ww * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat5 = texture2D(_GrabTexture, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD2.ww * u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat4.y = texture2D(_GrabTexture, u_xlat2.xy).y;
    u_xlat2.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat5.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0 + (-u_xlat5);
    u_xlat16_7 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat2.x = float(1.0) / _MainEffect;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat8 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat2.x = u_xlat2.x * _ShowColor;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat5;
    u_xlat0 = u_xlat16_1.wwww * u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w + -0.00999999978;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.x = dot(u_xlat0, u_xlat0);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_1.x = (-u_xlat0.z) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat20 = log2(u_xlat16_1.x);
    u_xlat20 = u_xlat20 * _DirX;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = u_xlat20 * _DirZ;
    u_xlat2.xy = u_xlat2.xy * vec2(_RFocus, _GFocus);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * _BFocus + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xx * _GrabTexture_TexelSize.xy;
    u_xlat3.y = _DirY;
    u_xlat3.x = 0.0;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat3 = u_xlat2.xyxy * u_xlat16_1.wwww + u_xlat3.yxxy;
    u_xlat3 = vs_TEXCOORD2.wwww * u_xlat3 + vs_TEXCOORD2.xyxy;
    u_xlat3 = u_xlat3 / vs_TEXCOORD2.wwww;
    u_xlat4.x = texture2D(_GrabTexture, u_xlat3.xy).x;
    u_xlat4.z = texture2D(_GrabTexture, u_xlat3.zw).z;
    u_xlat3.xy = u_xlat2.xy * u_xlat16_1.ww + vec2(vec2(_DirY, _DirY));
    u_xlat2.xy = u_xlat16_1.ww * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat5 = texture2D(_GrabTexture, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD2.ww * u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat4.y = texture2D(_GrabTexture, u_xlat2.xy).y;
    u_xlat2.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat5.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0 + (-u_xlat5);
    u_xlat16_7 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat2.x = float(1.0) / _MainEffect;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat8 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat2.x = u_xlat2.x * _ShowColor;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat5;
    u_xlat0 = u_xlat16_1.wwww * u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w + -0.00999999978;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.x = dot(u_xlat0, u_xlat0);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_1.x = (-u_xlat0.z) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat20 = log2(u_xlat16_1.x);
    u_xlat20 = u_xlat20 * _DirX;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = u_xlat20 * _DirZ;
    u_xlat2.xy = u_xlat2.xy * vec2(_RFocus, _GFocus);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * _BFocus + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xx * _GrabTexture_TexelSize.xy;
    u_xlat3.y = _DirY;
    u_xlat3.x = 0.0;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat3 = u_xlat2.xyxy * u_xlat16_1.wwww + u_xlat3.yxxy;
    u_xlat3 = vs_TEXCOORD2.wwww * u_xlat3 + vs_TEXCOORD2.xyxy;
    u_xlat3 = u_xlat3 / vs_TEXCOORD2.wwww;
    u_xlat4.x = texture2D(_GrabTexture, u_xlat3.xy).x;
    u_xlat4.z = texture2D(_GrabTexture, u_xlat3.zw).z;
    u_xlat3.xy = u_xlat2.xy * u_xlat16_1.ww + vec2(vec2(_DirY, _DirY));
    u_xlat2.xy = u_xlat16_1.ww * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat5 = texture2D(_GrabTexture, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD2.ww * u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat4.y = texture2D(_GrabTexture, u_xlat2.xy).y;
    u_xlat2.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat5.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0 + (-u_xlat5);
    u_xlat16_7 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat2.x = float(1.0) / _MainEffect;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat8 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat2.x = u_xlat2.x * _ShowColor;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat5;
    u_xlat0 = u_xlat16_1.wwww * u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
mediump float u_xlat16_8;
vec2 u_xlat12;
vec2 u_xlat15;
float u_xlat18;
void main()
{
    u_xlat0.y = _DirY;
    u_xlat0.x = 0.0;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat12.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = dot(u_xlat1, u_xlat1);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_2.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat12.x = log2(u_xlat16_2.x);
    u_xlat12.x = u_xlat12.x * _DirX;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _DirZ;
    u_xlat3.xy = u_xlat3.xy * vec2(_RFocus, _GFocus);
    u_xlat18 = u_xlat3.y + u_xlat3.x;
    u_xlat18 = u_xlat3.z * _BFocus + u_xlat18;
    u_xlat3.xy = vec2(u_xlat18) * _GrabTexture_TexelSize.xy;
    u_xlat16_2 = u_xlat1 * vs_COLOR0;
    u_xlat4 = u_xlat3.xyxy * u_xlat16_2.wwww + u_xlat0.yxxy;
    u_xlat4 = vs_TEXCOORD2.wwww * u_xlat4 + vs_TEXCOORD2.xyxy;
    u_xlat4 = u_xlat4 / vs_TEXCOORD2.wwww;
    u_xlat0.x = texture2D(_GrabTexture, u_xlat4.xy).x;
    u_xlat0.w = texture2D(_GrabTexture, u_xlat4.zw).z;
    u_xlat15.xy = u_xlat3.xy * u_xlat16_2.ww + vec2(vec2(_DirY, _DirY));
    u_xlat3.xy = u_xlat16_2.ww * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat4 = texture2D(_GrabTexture, u_xlat3.xy);
    u_xlat3.xy = vs_TEXCOORD2.ww * u_xlat15.xy + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat0.y = texture2D(_GrabTexture, u_xlat3.xy).y;
    u_xlat0.xyw = u_xlat0.xyw + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0 + (-u_xlat4);
    u_xlat16_5 = u_xlat1.w + -0.00999999978;
    u_xlatb1 = u_xlat16_5<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_8 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_2.x = max(u_xlat16_8, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.w * u_xlat16_2.x;
    u_xlat1.x = float(1.0) / _MainEffect;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat1.x = u_xlat1.x * _ShowColor;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat4;
    u_xlat16_2.x = u_xlat0.w * u_xlat16_2.w + -0.00100000005;
    u_xlat0 = u_xlat16_2.wwww * u_xlat0;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_2.x<0.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
mediump float u_xlat16_8;
vec2 u_xlat12;
vec2 u_xlat15;
float u_xlat18;
void main()
{
    u_xlat0.y = _DirY;
    u_xlat0.x = 0.0;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat12.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = dot(u_xlat1, u_xlat1);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_2.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat12.x = log2(u_xlat16_2.x);
    u_xlat12.x = u_xlat12.x * _DirX;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _DirZ;
    u_xlat3.xy = u_xlat3.xy * vec2(_RFocus, _GFocus);
    u_xlat18 = u_xlat3.y + u_xlat3.x;
    u_xlat18 = u_xlat3.z * _BFocus + u_xlat18;
    u_xlat3.xy = vec2(u_xlat18) * _GrabTexture_TexelSize.xy;
    u_xlat16_2 = u_xlat1 * vs_COLOR0;
    u_xlat4 = u_xlat3.xyxy * u_xlat16_2.wwww + u_xlat0.yxxy;
    u_xlat4 = vs_TEXCOORD2.wwww * u_xlat4 + vs_TEXCOORD2.xyxy;
    u_xlat4 = u_xlat4 / vs_TEXCOORD2.wwww;
    u_xlat0.x = texture2D(_GrabTexture, u_xlat4.xy).x;
    u_xlat0.w = texture2D(_GrabTexture, u_xlat4.zw).z;
    u_xlat15.xy = u_xlat3.xy * u_xlat16_2.ww + vec2(vec2(_DirY, _DirY));
    u_xlat3.xy = u_xlat16_2.ww * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat4 = texture2D(_GrabTexture, u_xlat3.xy);
    u_xlat3.xy = vs_TEXCOORD2.ww * u_xlat15.xy + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat0.y = texture2D(_GrabTexture, u_xlat3.xy).y;
    u_xlat0.xyw = u_xlat0.xyw + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0 + (-u_xlat4);
    u_xlat16_5 = u_xlat1.w + -0.00999999978;
    u_xlatb1 = u_xlat16_5<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_8 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_2.x = max(u_xlat16_8, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.w * u_xlat16_2.x;
    u_xlat1.x = float(1.0) / _MainEffect;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat1.x = u_xlat1.x * _ShowColor;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat4;
    u_xlat16_2.x = u_xlat0.w * u_xlat16_2.w + -0.00100000005;
    u_xlat0 = u_xlat16_2.wwww * u_xlat0;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_2.x<0.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
mediump float u_xlat16_8;
vec2 u_xlat12;
vec2 u_xlat15;
float u_xlat18;
void main()
{
    u_xlat0.y = _DirY;
    u_xlat0.x = 0.0;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat12.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = dot(u_xlat1, u_xlat1);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_2.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat12.x = log2(u_xlat16_2.x);
    u_xlat12.x = u_xlat12.x * _DirX;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _DirZ;
    u_xlat3.xy = u_xlat3.xy * vec2(_RFocus, _GFocus);
    u_xlat18 = u_xlat3.y + u_xlat3.x;
    u_xlat18 = u_xlat3.z * _BFocus + u_xlat18;
    u_xlat3.xy = vec2(u_xlat18) * _GrabTexture_TexelSize.xy;
    u_xlat16_2 = u_xlat1 * vs_COLOR0;
    u_xlat4 = u_xlat3.xyxy * u_xlat16_2.wwww + u_xlat0.yxxy;
    u_xlat4 = vs_TEXCOORD2.wwww * u_xlat4 + vs_TEXCOORD2.xyxy;
    u_xlat4 = u_xlat4 / vs_TEXCOORD2.wwww;
    u_xlat0.x = texture2D(_GrabTexture, u_xlat4.xy).x;
    u_xlat0.w = texture2D(_GrabTexture, u_xlat4.zw).z;
    u_xlat15.xy = u_xlat3.xy * u_xlat16_2.ww + vec2(vec2(_DirY, _DirY));
    u_xlat3.xy = u_xlat16_2.ww * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat4 = texture2D(_GrabTexture, u_xlat3.xy);
    u_xlat3.xy = vs_TEXCOORD2.ww * u_xlat15.xy + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat0.y = texture2D(_GrabTexture, u_xlat3.xy).y;
    u_xlat0.xyw = u_xlat0.xyw + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0 + (-u_xlat4);
    u_xlat16_5 = u_xlat1.w + -0.00999999978;
    u_xlatb1 = u_xlat16_5<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat16_8 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_2.x = max(u_xlat16_8, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.w * u_xlat16_2.x;
    u_xlat1.x = float(1.0) / _MainEffect;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat1.x = u_xlat1.x * _ShowColor;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat4;
    u_xlat16_2.x = u_xlat0.w * u_xlat16_2.w + -0.00100000005;
    u_xlat0 = u_xlat16_2.wwww * u_xlat0;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_2.x<0.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w + -0.00999999978;
    u_xlatb2.x = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2.x) * -1))!=0){discard;}
    u_xlat16_1.x = dot(u_xlat0, u_xlat0);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_1.x = (-u_xlat0.z) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat20 = log2(u_xlat16_1.x);
    u_xlat20 = u_xlat20 * _DirX;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = u_xlat20 * _DirZ;
    u_xlat2.xy = u_xlat2.xy * vec2(_RFocus, _GFocus);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * _BFocus + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xx * _GrabTexture_TexelSize.xy;
    u_xlat3.y = _DirY;
    u_xlat3.x = 0.0;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat3 = u_xlat2.xyxy * u_xlat16_1.wwww + u_xlat3.yxxy;
    u_xlat3 = vs_TEXCOORD2.wwww * u_xlat3 + vs_TEXCOORD2.xyxy;
    u_xlat3 = u_xlat3 / vs_TEXCOORD2.wwww;
    u_xlat4.x = texture2D(_GrabTexture, u_xlat3.xy).x;
    u_xlat4.z = texture2D(_GrabTexture, u_xlat3.zw).z;
    u_xlat3.xy = u_xlat2.xy * u_xlat16_1.ww + vec2(vec2(_DirY, _DirY));
    u_xlat2.xy = u_xlat16_1.ww * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat5 = texture2D(_GrabTexture, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD2.ww * u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat4.y = texture2D(_GrabTexture, u_xlat2.xy).y;
    u_xlat2.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat5.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0 + (-u_xlat5);
    u_xlat16_7 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat2.x = float(1.0) / _MainEffect;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat8 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat2.x = u_xlat2.x * _ShowColor;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat5;
    u_xlat0 = u_xlat16_1.wwww * u_xlat0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat0.w = u_xlat0.w * u_xlat2.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w + -0.00999999978;
    u_xlatb2.x = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2.x) * -1))!=0){discard;}
    u_xlat16_1.x = dot(u_xlat0, u_xlat0);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_1.x = (-u_xlat0.z) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat20 = log2(u_xlat16_1.x);
    u_xlat20 = u_xlat20 * _DirX;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = u_xlat20 * _DirZ;
    u_xlat2.xy = u_xlat2.xy * vec2(_RFocus, _GFocus);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * _BFocus + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xx * _GrabTexture_TexelSize.xy;
    u_xlat3.y = _DirY;
    u_xlat3.x = 0.0;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat3 = u_xlat2.xyxy * u_xlat16_1.wwww + u_xlat3.yxxy;
    u_xlat3 = vs_TEXCOORD2.wwww * u_xlat3 + vs_TEXCOORD2.xyxy;
    u_xlat3 = u_xlat3 / vs_TEXCOORD2.wwww;
    u_xlat4.x = texture2D(_GrabTexture, u_xlat3.xy).x;
    u_xlat4.z = texture2D(_GrabTexture, u_xlat3.zw).z;
    u_xlat3.xy = u_xlat2.xy * u_xlat16_1.ww + vec2(vec2(_DirY, _DirY));
    u_xlat2.xy = u_xlat16_1.ww * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat5 = texture2D(_GrabTexture, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD2.ww * u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat4.y = texture2D(_GrabTexture, u_xlat2.xy).y;
    u_xlat2.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat5.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0 + (-u_xlat5);
    u_xlat16_7 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat2.x = float(1.0) / _MainEffect;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat8 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat2.x = u_xlat2.x * _ShowColor;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat5;
    u_xlat0 = u_xlat16_1.wwww * u_xlat0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat0.w = u_xlat0.w * u_xlat2.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w + -0.00999999978;
    u_xlatb2.x = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2.x) * -1))!=0){discard;}
    u_xlat16_1.x = dot(u_xlat0, u_xlat0);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_1.x = (-u_xlat0.z) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat20 = log2(u_xlat16_1.x);
    u_xlat20 = u_xlat20 * _DirX;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = u_xlat20 * _DirZ;
    u_xlat2.xy = u_xlat2.xy * vec2(_RFocus, _GFocus);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * _BFocus + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xx * _GrabTexture_TexelSize.xy;
    u_xlat3.y = _DirY;
    u_xlat3.x = 0.0;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat3 = u_xlat2.xyxy * u_xlat16_1.wwww + u_xlat3.yxxy;
    u_xlat3 = vs_TEXCOORD2.wwww * u_xlat3 + vs_TEXCOORD2.xyxy;
    u_xlat3 = u_xlat3 / vs_TEXCOORD2.wwww;
    u_xlat4.x = texture2D(_GrabTexture, u_xlat3.xy).x;
    u_xlat4.z = texture2D(_GrabTexture, u_xlat3.zw).z;
    u_xlat3.xy = u_xlat2.xy * u_xlat16_1.ww + vec2(vec2(_DirY, _DirY));
    u_xlat2.xy = u_xlat16_1.ww * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat5 = texture2D(_GrabTexture, u_xlat2.xy);
    u_xlat2.xy = vs_TEXCOORD2.ww * u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD2.ww;
    u_xlat4.y = texture2D(_GrabTexture, u_xlat2.xy).y;
    u_xlat2.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat5.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat5.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0 + (-u_xlat5);
    u_xlat16_7 = max(u_xlat16_1.z, u_xlat16_1.y);
    u_xlat16_1.x = max(u_xlat16_7, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.w * u_xlat16_1.x;
    u_xlat2.x = float(1.0) / _MainEffect;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat8 = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat2.x = u_xlat2.x * _ShowColor;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat5;
    u_xlat0 = u_xlat16_1.wwww * u_xlat0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat0.w = u_xlat0.w * u_xlat2.x;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
mediump float u_xlat16_8;
vec2 u_xlat12;
vec2 u_xlat15;
float u_xlat18;
void main()
{
    u_xlat0.y = _DirY;
    u_xlat0.x = 0.0;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat12.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = dot(u_xlat1, u_xlat1);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_2.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat12.x = log2(u_xlat16_2.x);
    u_xlat12.x = u_xlat12.x * _DirX;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _DirZ;
    u_xlat3.xy = u_xlat3.xy * vec2(_RFocus, _GFocus);
    u_xlat18 = u_xlat3.y + u_xlat3.x;
    u_xlat18 = u_xlat3.z * _BFocus + u_xlat18;
    u_xlat3.xy = vec2(u_xlat18) * _GrabTexture_TexelSize.xy;
    u_xlat16_2 = u_xlat1 * vs_COLOR0;
    u_xlat4 = u_xlat3.xyxy * u_xlat16_2.wwww + u_xlat0.yxxy;
    u_xlat4 = vs_TEXCOORD2.wwww * u_xlat4 + vs_TEXCOORD2.xyxy;
    u_xlat4 = u_xlat4 / vs_TEXCOORD2.wwww;
    u_xlat0.x = texture2D(_GrabTexture, u_xlat4.xy).x;
    u_xlat0.w = texture2D(_GrabTexture, u_xlat4.zw).z;
    u_xlat15.xy = u_xlat3.xy * u_xlat16_2.ww + vec2(vec2(_DirY, _DirY));
    u_xlat3.xy = u_xlat16_2.ww * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat4 = texture2D(_GrabTexture, u_xlat3.xy);
    u_xlat3.xy = vs_TEXCOORD2.ww * u_xlat15.xy + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat0.y = texture2D(_GrabTexture, u_xlat3.xy).y;
    u_xlat0.xyw = u_xlat0.xyw + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0 + (-u_xlat4);
    u_xlat16_5 = u_xlat1.w + -0.00999999978;
    u_xlatb1.x = u_xlat16_5<0.0;
    if(((int(u_xlatb1.x) * -1))!=0){discard;}
    u_xlat16_8 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_2.x = max(u_xlat16_8, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.w * u_xlat16_2.x;
    u_xlat1.x = float(1.0) / _MainEffect;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat1.x = u_xlat1.x * _ShowColor;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat4;
    u_xlat0 = u_xlat16_2.wwww * u_xlat0;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat16_2.x = u_xlat0.w * u_xlat1.x + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat1.x;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_2.x<0.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
mediump float u_xlat16_8;
vec2 u_xlat12;
vec2 u_xlat15;
float u_xlat18;
void main()
{
    u_xlat0.y = _DirY;
    u_xlat0.x = 0.0;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat12.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = dot(u_xlat1, u_xlat1);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_2.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat12.x = log2(u_xlat16_2.x);
    u_xlat12.x = u_xlat12.x * _DirX;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _DirZ;
    u_xlat3.xy = u_xlat3.xy * vec2(_RFocus, _GFocus);
    u_xlat18 = u_xlat3.y + u_xlat3.x;
    u_xlat18 = u_xlat3.z * _BFocus + u_xlat18;
    u_xlat3.xy = vec2(u_xlat18) * _GrabTexture_TexelSize.xy;
    u_xlat16_2 = u_xlat1 * vs_COLOR0;
    u_xlat4 = u_xlat3.xyxy * u_xlat16_2.wwww + u_xlat0.yxxy;
    u_xlat4 = vs_TEXCOORD2.wwww * u_xlat4 + vs_TEXCOORD2.xyxy;
    u_xlat4 = u_xlat4 / vs_TEXCOORD2.wwww;
    u_xlat0.x = texture2D(_GrabTexture, u_xlat4.xy).x;
    u_xlat0.w = texture2D(_GrabTexture, u_xlat4.zw).z;
    u_xlat15.xy = u_xlat3.xy * u_xlat16_2.ww + vec2(vec2(_DirY, _DirY));
    u_xlat3.xy = u_xlat16_2.ww * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat4 = texture2D(_GrabTexture, u_xlat3.xy);
    u_xlat3.xy = vs_TEXCOORD2.ww * u_xlat15.xy + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat0.y = texture2D(_GrabTexture, u_xlat3.xy).y;
    u_xlat0.xyw = u_xlat0.xyw + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0 + (-u_xlat4);
    u_xlat16_5 = u_xlat1.w + -0.00999999978;
    u_xlatb1.x = u_xlat16_5<0.0;
    if(((int(u_xlatb1.x) * -1))!=0){discard;}
    u_xlat16_8 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_2.x = max(u_xlat16_8, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.w * u_xlat16_2.x;
    u_xlat1.x = float(1.0) / _MainEffect;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat1.x = u_xlat1.x * _ShowColor;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat4;
    u_xlat0 = u_xlat16_2.wwww * u_xlat0;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat16_2.x = u_xlat0.w * u_xlat1.x + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat1.x;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_2.x<0.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Height;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.w + _Height;
    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.5, 0.5);
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
uniform 	float _RFocus;
uniform 	float _GFocus;
uniform 	float _BFocus;
uniform 	float _MainEffect;
uniform 	float _ShowColor;
uniform 	mediump vec4 _GrabTexture_TexelSize;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	float _DirX;
uniform 	float _DirY;
uniform 	float _DirZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrabTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat7;
mediump float u_xlat16_8;
vec2 u_xlat12;
vec2 u_xlat15;
float u_xlat18;
void main()
{
    u_xlat0.y = _DirY;
    u_xlat0.x = 0.0;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat12.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = dot(u_xlat1, u_xlat1);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat3.xyz = u_xlat1.xyz * u_xlat16_2.xxx + vec3(-0.5, -0.5, -0.5);
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat12.x = log2(u_xlat16_2.x);
    u_xlat12.x = u_xlat12.x * _DirX;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _DirZ;
    u_xlat3.xy = u_xlat3.xy * vec2(_RFocus, _GFocus);
    u_xlat18 = u_xlat3.y + u_xlat3.x;
    u_xlat18 = u_xlat3.z * _BFocus + u_xlat18;
    u_xlat3.xy = vec2(u_xlat18) * _GrabTexture_TexelSize.xy;
    u_xlat16_2 = u_xlat1 * vs_COLOR0;
    u_xlat4 = u_xlat3.xyxy * u_xlat16_2.wwww + u_xlat0.yxxy;
    u_xlat4 = vs_TEXCOORD2.wwww * u_xlat4 + vs_TEXCOORD2.xyxy;
    u_xlat4 = u_xlat4 / vs_TEXCOORD2.wwww;
    u_xlat0.x = texture2D(_GrabTexture, u_xlat4.xy).x;
    u_xlat0.w = texture2D(_GrabTexture, u_xlat4.zw).z;
    u_xlat15.xy = u_xlat3.xy * u_xlat16_2.ww + vec2(vec2(_DirY, _DirY));
    u_xlat3.xy = u_xlat16_2.ww * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vs_TEXCOORD2.ww + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat4 = texture2D(_GrabTexture, u_xlat3.xy);
    u_xlat3.xy = vs_TEXCOORD2.ww * u_xlat15.xy + vs_TEXCOORD2.xy;
    u_xlat3.xy = u_xlat3.xy / vs_TEXCOORD2.ww;
    u_xlat0.y = texture2D(_GrabTexture, u_xlat3.xy).y;
    u_xlat0.xyw = u_xlat0.xyw + (-u_xlat4.xyz);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat0.xyw + u_xlat4.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0 + (-u_xlat4);
    u_xlat16_5 = u_xlat1.w + -0.00999999978;
    u_xlatb1.x = u_xlat16_5<0.0;
    if(((int(u_xlatb1.x) * -1))!=0){discard;}
    u_xlat16_8 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_2.x = max(u_xlat16_8, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.w * u_xlat16_2.x;
    u_xlat1.x = float(1.0) / _MainEffect;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7;
    u_xlat1.x = u_xlat1.x * _ShowColor;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat4;
    u_xlat0 = u_xlat16_2.wwww * u_xlat0;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat16_2.x = u_xlat0.w * u_xlat1.x + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat1.x;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_2.x<0.0;
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