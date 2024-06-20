//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "HZShader/Dissolution_Add" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_ZiFaGuang ("ZiFaGuang", Float) = 0.5
_Mask ("Mask", 2D) = "white" { }
[MaterialToggle] _FanZhuan_Mask ("FanZhuan_Mask", Float) = 0
_XiaoRong ("XiaoRong", Range(1, 0)) = 1
_XiaoRong_Bian ("XiaoRong_Bian", Range(0, 0.2)) = 0
_XR_color ("XR_color", Color) = (0.5,0.5,1,1)
[MaterialToggle] _XR_Sceen ("XR_Sceen", Float) = 0.5
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Emission1 ("Outside", Color) = (0,0,0,0)
_Emission2 ("Inside", Color) = (0,0,0,0)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  Cull Off
  GpuProgramID 63285
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Mask_ST;
uniform 	float _XiaoRong;
uniform 	float _XiaoRong_Bian;
uniform 	vec4 _XR_color;
uniform 	float _ZiFaGuang;
uniform 	mediump float _XR_Sceen;
uniform 	mediump float _FanZhuan_Mask;
uniform 	vec4 _Emission1;
uniform 	vec4 _Emission2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_0 = texture2D(_Mask, u_xlat0.xy).x;
    u_xlat4.x = u_xlat10_0 * -2.0 + 1.0;
    u_xlat0.x = _FanZhuan_Mask * u_xlat4.x + u_xlat10_0;
    u_xlat4.x = _XiaoRong * 1.29999995 + (-_XiaoRong_Bian);
    u_xlatb4 = u_xlat4.x>=u_xlat0.x;
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat1.xyz = (-_XR_color.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat8.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat8.xy);
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) * vec3(_ZiFaGuang) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat3.xyz) * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + (-_XR_color.xyz);
    u_xlat1.xyz = vec3(_XR_Sceen) * u_xlat1.xyz + _XR_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ZiFaGuang) + (-u_xlat1.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat1.x = float(op_and(int((gl_FrontFacing ? 1 : 0)), 1065353216));
    u_xlat5.xyz = (int((gl_FrontFacing ? 1 : 0)) != 0) ? vec3(0.0, 0.0, 0.0) : _Emission2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * _Emission1.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat4.x = _XiaoRong * 1.29999995;
    u_xlatb0 = u_xlat4.x>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat10_2.w * u_xlat0.x;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "Diffuse"
}