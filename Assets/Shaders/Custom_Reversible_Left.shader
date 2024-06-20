//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/Reversible_Left" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Light ("Light Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Progress ("Progress", Range(1, 50)) = 1
_Highlight ("Highlight", Range(1, 20)) = 1
_Period ("Period (Seconds)", Float) = 1
_PeriodNum ("PeriodNum", Float) = 1
[Toggle] _Inversion ("Inversion?", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_MaskPos ("Mask Pos", Vector) = (0,0,512,0)
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
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
  GpuProgramID 59896
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_0 = texture2D(_Light, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat0 * vec4(_Highlight);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + (-u_xlat1.xyz);
    u_xlat16_2.xyz = u_xlat1.www * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_0.w * _Color.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_0 = texture2D(_Light, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat0 * vec4(_Highlight);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + (-u_xlat1.xyz);
    u_xlat16_2.xyz = u_xlat1.www * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_0.w * _Color.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_0 = texture2D(_Light, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat0 * vec4(_Highlight);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + (-u_xlat1.xyz);
    u_xlat16_2.xyz = u_xlat1.www * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_0.w * _Color.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_1 = texture2D(_Light, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat16_1 = u_xlat1 * vec4(_Highlight);
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat16_1.w * _Color.w;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_1 = texture2D(_Light, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat16_1 = u_xlat1 * vec4(_Highlight);
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat16_1.w * _Color.w;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_1 = texture2D(_Light, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat16_1 = u_xlat1 * vec4(_Highlight);
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat16_1.w * _Color.w;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_0 = texture2D(_Light, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat0 * vec4(_Highlight);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + (-u_xlat1.xyz);
    u_xlat16_2.xyz = u_xlat1.www * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_0.w * _Color.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_0 = texture2D(_Light, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat0 * vec4(_Highlight);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + (-u_xlat1.xyz);
    u_xlat16_2.xyz = u_xlat1.www * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_0.w * _Color.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_0 = texture2D(_Light, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat0 * vec4(_Highlight);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + (-u_xlat1.xyz);
    u_xlat16_2.xyz = u_xlat1.www * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * _Color.xyz + u_xlat16_2.xyz;
    u_xlat16_11 = u_xlat16_0.w * _Color.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_11) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_1 = texture2D(_Light, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat16_1 = u_xlat1 * vec4(_Highlight);
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat16_1.w * _Color.w;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_1 = texture2D(_Light, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat16_1 = u_xlat1 * vec4(_Highlight);
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat16_1.w * _Color.w;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Progress;
uniform 	mediump float _Period;
uniform 	mediump float _PeriodNum;
uniform 	mediump float _Inversion;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_8;
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
    u_xlat0.x = _Time.y / _Period;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat6 = fract(abs(u_xlat0.x));
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat3 = (u_xlatb3) ? u_xlat6 : (-u_xlat6);
    u_xlat0.y = u_xlat3 * _Period;
    u_xlat0.xy = u_xlat0.xy / vec2(_PeriodNum, _Period);
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _PeriodNum;
    u_xlat16_2.xy = vec2(_PeriodNum, _Progress) + vec2(-1.10000002, 0.5);
    u_xlatb0 = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat6 = u_xlat0.x * u_xlat0.y;
    u_xlatb6 = 0.00999999978>=u_xlat6;
    u_xlat16_2.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.x + u_xlat16_2.x;
    u_xlat16_8 = (-_Inversion) + 1.0;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = _Inversion * u_xlat16_2.x + u_xlat16_8;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_2.y + -1.0;
    u_xlat16_2.x = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_5 = u_xlat16_8 * -0.5;
    u_xlat0.zw = in_TEXCOORD0.xy * u_xlat16_2.xx + vec2(u_xlat16_5);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Light_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Highlight;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Light;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_15;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat16_1.xy = vs_TEXCOORD0.zw * _Light_ST.xy + _Light_ST.zw;
    u_xlat10_1 = texture2D(_Light, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * _Color;
    u_xlat16_1 = u_xlat1 * vec4(_Highlight);
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat16_1.w * _Color.w;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_15) + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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