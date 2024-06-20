//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Sprites/Hightlight" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_Trans ("黑白过渡", Range(0, 1)) = 1
_Light ("深度过渡", Range(0, 1)) = 1
[KeywordEnum(add,lerp)] _SpecMode ("高光叠加方式", Float) = 0
_SpecColor ("高光颜色", Color) = (1,1,1,1)
_SpecPower ("高光亮度", Float) = 1
_SpecGloss ("高光光泽度", Float) = 0.6
_SpecFinal ("高光光斑扩散临界点", Float) = 1
[MaterialToggle] _UseLight ("使用灯1", Float) = 1
_LightPos ("灯1位置", Vector) = (1,0,0,0)
[MaterialToggle] _UseLight1 ("使用灯2", Float) = 1
_LightPos1 ("灯2位置", Vector) = (0,1,0,0)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_CameraPos ("UseCameraPos", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ColorMask 0 0
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
  GpuProgramID 23560
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_11;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_2.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_11.x = u_xlat16_2.x * 40.0;
    u_xlat28 = u_xlat16_11.x * _SpecFinal;
    u_xlat27 = u_xlat27 * u_xlat28;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat16_2.x * u_xlat27;
    u_xlat4.xyz = vec3(u_xlat27) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_5 * vs_COLOR0;
    u_xlat16_11.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_11.x = max(u_xlat16_6.z, u_xlat16_11.x);
    u_xlat5.xyz = u_xlat10_5.xyz * vs_COLOR0.xyz + (-u_xlat16_11.xxx);
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + u_xlat16_11.xxx;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat4.xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_8.xyz);
    u_xlat16_3.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_3.xxx;
    u_xlat16_11.x = dot(u_xlat0.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_11.x);
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_6;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_6;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_11;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_2.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_11.x = u_xlat16_2.x * 40.0;
    u_xlat28 = u_xlat16_11.x * _SpecFinal;
    u_xlat27 = u_xlat27 * u_xlat28;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat16_2.x * u_xlat27;
    u_xlat4.xyz = vec3(u_xlat27) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_5 * vs_COLOR0;
    u_xlat16_11.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_11.x = max(u_xlat16_6.z, u_xlat16_11.x);
    u_xlat5.xyz = u_xlat10_5.xyz * vs_COLOR0.xyz + (-u_xlat16_11.xxx);
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + u_xlat16_11.xxx;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat4.xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_8.xyz);
    u_xlat16_3.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_3.xxx;
    u_xlat16_11.x = dot(u_xlat0.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_11.x);
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_6;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_6;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_11;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_2.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_11.x = u_xlat16_2.x * 40.0;
    u_xlat28 = u_xlat16_11.x * _SpecFinal;
    u_xlat27 = u_xlat27 * u_xlat28;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat16_2.x * u_xlat27;
    u_xlat4.xyz = vec3(u_xlat27) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_5 * vs_COLOR0;
    u_xlat16_11.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_11.x = max(u_xlat16_6.z, u_xlat16_11.x);
    u_xlat5.xyz = u_xlat10_5.xyz * vs_COLOR0.xyz + (-u_xlat16_11.xxx);
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + u_xlat16_11.xxx;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat4.xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_8.xyz);
    u_xlat16_3.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_3.xxx;
    u_xlat16_11.x = dot(u_xlat0.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_11.x);
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_6;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_6;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_2.xyz);
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_21);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat18 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_8.x = u_xlat16_2.x * 40.0;
    u_xlat19 = u_xlat16_8.x * _SpecFinal;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat16_2.x * u_xlat18;
    u_xlat4.xyz = vec3(u_xlat18) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
    u_xlat16_3.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx;
    u_xlat16_8.x = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat4.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_20 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_20 = max(u_xlat16_3.z, u_xlat16_20);
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_20));
    u_xlat0.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat0.xyz + vec3(u_xlat16_20);
    u_xlat4.xyz = u_xlat0.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_3;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_2.xyz);
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_21);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat18 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_8.x = u_xlat16_2.x * 40.0;
    u_xlat19 = u_xlat16_8.x * _SpecFinal;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat16_2.x * u_xlat18;
    u_xlat4.xyz = vec3(u_xlat18) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
    u_xlat16_3.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx;
    u_xlat16_8.x = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat4.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_20 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_20 = max(u_xlat16_3.z, u_xlat16_20);
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_20));
    u_xlat0.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat0.xyz + vec3(u_xlat16_20);
    u_xlat4.xyz = u_xlat0.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_3;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_2.xyz);
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_21);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat18 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_8.x = u_xlat16_2.x * 40.0;
    u_xlat19 = u_xlat16_8.x * _SpecFinal;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat16_2.x * u_xlat18;
    u_xlat4.xyz = vec3(u_xlat18) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
    u_xlat16_3.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx;
    u_xlat16_8.x = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat4.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_20 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_20 = max(u_xlat16_3.z, u_xlat16_20);
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_20));
    u_xlat0.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat0.xyz + vec3(u_xlat16_20);
    u_xlat4.xyz = u_xlat0.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_3;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_4.xyz);
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_23 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_9 = exp2(_SpecGloss);
    u_xlat16_16 = u_xlat16_9 * 40.0;
    u_xlat0.x = u_xlat16_16 * _SpecFinal;
    u_xlat7.x = log2(u_xlat16_23);
    u_xlat7.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat16_9 * u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * _SpecColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat15 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_10.y, u_xlat16_10.x);
    u_xlat16_3.x = max(u_xlat16_10.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_4.xyz);
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_23 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_9 = exp2(_SpecGloss);
    u_xlat16_16 = u_xlat16_9 * 40.0;
    u_xlat0.x = u_xlat16_16 * _SpecFinal;
    u_xlat7.x = log2(u_xlat16_23);
    u_xlat7.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat16_9 * u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * _SpecColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat15 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_10.y, u_xlat16_10.x);
    u_xlat16_3.x = max(u_xlat16_10.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_4.xyz);
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_23 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_9 = exp2(_SpecGloss);
    u_xlat16_16 = u_xlat16_9 * 40.0;
    u_xlat0.x = u_xlat16_16 * _SpecFinal;
    u_xlat7.x = log2(u_xlat16_23);
    u_xlat7.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat16_9 * u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * _SpecColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat15 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_10.y, u_xlat16_10.x);
    u_xlat16_3.x = max(u_xlat16_10.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_4.xyz);
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat16_29 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_11 = exp2(_SpecGloss);
    u_xlat16_20 = u_xlat16_11 * 40.0;
    u_xlat0.x = u_xlat16_20 * _SpecFinal;
    u_xlat9.x = log2(u_xlat16_29);
    u_xlat9.x = u_xlat9.x * u_xlat0.x;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = u_xlat16_11 * u_xlat9.x;
    u_xlat9.xyz = u_xlat9.xxx * _SpecColor.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat19 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_12.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_12.y, u_xlat16_12.x);
    u_xlat16_3.x = max(u_xlat16_12.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat7.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_3.xyz = u_xlat9.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat5.xyz;
    u_xlat16_8.xyz = (-u_xlat6.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_4.xyz);
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat16_29 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_11 = exp2(_SpecGloss);
    u_xlat16_20 = u_xlat16_11 * 40.0;
    u_xlat0.x = u_xlat16_20 * _SpecFinal;
    u_xlat9.x = log2(u_xlat16_29);
    u_xlat9.x = u_xlat9.x * u_xlat0.x;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = u_xlat16_11 * u_xlat9.x;
    u_xlat9.xyz = u_xlat9.xxx * _SpecColor.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat19 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_12.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_12.y, u_xlat16_12.x);
    u_xlat16_3.x = max(u_xlat16_12.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat7.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_3.xyz = u_xlat9.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat5.xyz;
    u_xlat16_8.xyz = (-u_xlat6.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_4.xyz);
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat16_29 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_11 = exp2(_SpecGloss);
    u_xlat16_20 = u_xlat16_11 * 40.0;
    u_xlat0.x = u_xlat16_20 * _SpecFinal;
    u_xlat9.x = log2(u_xlat16_29);
    u_xlat9.x = u_xlat9.x * u_xlat0.x;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = u_xlat16_11 * u_xlat9.x;
    u_xlat9.xyz = u_xlat9.xxx * _SpecColor.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat19 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_12.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_12.y, u_xlat16_12.x);
    u_xlat16_3.x = max(u_xlat16_12.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat7.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_3.xyz = u_xlat9.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat5.xyz;
    u_xlat16_8.xyz = (-u_xlat6.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_11;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_2.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_11.x = u_xlat16_2.x * 40.0;
    u_xlat28 = u_xlat16_11.x * _SpecFinal;
    u_xlat27 = u_xlat27 * u_xlat28;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat16_2.x * u_xlat27;
    u_xlat4.xyz = vec3(u_xlat27) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_5 * vs_COLOR0;
    u_xlat16_11.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_11.x = max(u_xlat16_6.z, u_xlat16_11.x);
    u_xlat5.xyz = u_xlat10_5.xyz * vs_COLOR0.xyz + (-u_xlat16_11.xxx);
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + u_xlat16_11.xxx;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat4.xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_8.xyz);
    u_xlat16_3.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_3.xxx;
    u_xlat16_11.x = dot(u_xlat0.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_11.x);
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_6;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_6;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_11;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_2.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_11.x = u_xlat16_2.x * 40.0;
    u_xlat28 = u_xlat16_11.x * _SpecFinal;
    u_xlat27 = u_xlat27 * u_xlat28;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat16_2.x * u_xlat27;
    u_xlat4.xyz = vec3(u_xlat27) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_5 * vs_COLOR0;
    u_xlat16_11.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_11.x = max(u_xlat16_6.z, u_xlat16_11.x);
    u_xlat5.xyz = u_xlat10_5.xyz * vs_COLOR0.xyz + (-u_xlat16_11.xxx);
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + u_xlat16_11.xxx;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat4.xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_8.xyz);
    u_xlat16_3.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_3.xxx;
    u_xlat16_11.x = dot(u_xlat0.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_11.x);
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_6;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_6;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_11;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_2.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_11.x = u_xlat16_2.x * 40.0;
    u_xlat28 = u_xlat16_11.x * _SpecFinal;
    u_xlat27 = u_xlat27 * u_xlat28;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat16_2.x * u_xlat27;
    u_xlat4.xyz = vec3(u_xlat27) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_5 * vs_COLOR0;
    u_xlat16_11.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_11.x = max(u_xlat16_6.z, u_xlat16_11.x);
    u_xlat5.xyz = u_xlat10_5.xyz * vs_COLOR0.xyz + (-u_xlat16_11.xxx);
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + u_xlat16_11.xxx;
    u_xlat16_7.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat4.xyz;
    u_xlat16_8.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xyz * vec3(u_xlat16_29) + (-u_xlat16_8.xyz);
    u_xlat16_3.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_3.xxx;
    u_xlat16_11.x = dot(u_xlat0.xyz, u_xlat16_11.xyz);
    u_xlat16_11.x = clamp(u_xlat16_11.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_11.x);
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_6;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_6;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_2.xyz);
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_21);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat18 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_8.x = u_xlat16_2.x * 40.0;
    u_xlat19 = u_xlat16_8.x * _SpecFinal;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat16_2.x * u_xlat18;
    u_xlat4.xyz = vec3(u_xlat18) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
    u_xlat16_3.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx;
    u_xlat16_8.x = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat4.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_20 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_20 = max(u_xlat16_3.z, u_xlat16_20);
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_20));
    u_xlat0.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat0.xyz + vec3(u_xlat16_20);
    u_xlat4.xyz = u_xlat0.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_3;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_2.xyz);
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_21);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat18 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_8.x = u_xlat16_2.x * 40.0;
    u_xlat19 = u_xlat16_8.x * _SpecFinal;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat16_2.x * u_xlat18;
    u_xlat4.xyz = vec3(u_xlat18) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
    u_xlat16_3.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx;
    u_xlat16_8.x = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat4.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_20 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_20 = max(u_xlat16_3.z, u_xlat16_20);
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_20));
    u_xlat0.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat0.xyz + vec3(u_xlat16_20);
    u_xlat4.xyz = u_xlat0.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_3;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_20;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_20 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_2.xyz);
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_21);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat18 = log2(u_xlat16_2.x);
    u_xlat16_2.x = exp2(_SpecGloss);
    u_xlat16_8.x = u_xlat16_2.x * 40.0;
    u_xlat19 = u_xlat16_8.x * _SpecFinal;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat16_2.x * u_xlat18;
    u_xlat4.xyz = vec3(u_xlat18) * _SpecColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat4.xyz = u_xlat4.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat16_5.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + (-u_xlat16_5.xyz);
    u_xlat16_3.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx;
    u_xlat16_8.x = dot(u_xlat0.xyz, u_xlat16_8.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_8.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat0.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat4.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_20 = max(u_xlat16_3.y, u_xlat16_3.x);
    u_xlat16_20 = max(u_xlat16_3.z, u_xlat16_20);
    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_20));
    u_xlat0.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat0.xyz + vec3(u_xlat16_20);
    u_xlat4.xyz = u_xlat0.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.www * u_xlat16_2.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_3;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_4.xyz);
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_23 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_9 = exp2(_SpecGloss);
    u_xlat16_16 = u_xlat16_9 * 40.0;
    u_xlat0.x = u_xlat16_16 * _SpecFinal;
    u_xlat7.x = log2(u_xlat16_23);
    u_xlat7.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat16_9 * u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * _SpecColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat15 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_10.y, u_xlat16_10.x);
    u_xlat16_3.x = max(u_xlat16_10.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_4.xyz);
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_23 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_9 = exp2(_SpecGloss);
    u_xlat16_16 = u_xlat16_9 * 40.0;
    u_xlat0.x = u_xlat16_16 * _SpecFinal;
    u_xlat7.x = log2(u_xlat16_23);
    u_xlat7.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat16_9 * u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * _SpecColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat15 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_10.y, u_xlat16_10.x);
    u_xlat16_3.x = max(u_xlat16_10.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + (-u_xlat16_4.xyz);
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_23 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_9 = exp2(_SpecGloss);
    u_xlat16_16 = u_xlat16_9 * 40.0;
    u_xlat0.x = u_xlat16_16 * _SpecFinal;
    u_xlat7.x = log2(u_xlat16_23);
    u_xlat7.x = u_xlat7.x * u_xlat0.x;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = u_xlat16_9 * u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * _SpecColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight));
    u_xlat15 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_9 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_10.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_10.y, u_xlat16_10.x);
    u_xlat16_3.x = max(u_xlat16_10.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat7.xyz;
    u_xlat16_3.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1)) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_4.xyz);
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat16_29 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_11 = exp2(_SpecGloss);
    u_xlat16_20 = u_xlat16_11 * 40.0;
    u_xlat0.x = u_xlat16_20 * _SpecFinal;
    u_xlat9.x = log2(u_xlat16_29);
    u_xlat9.x = u_xlat9.x * u_xlat0.x;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = u_xlat16_11 * u_xlat9.x;
    u_xlat9.xyz = u_xlat9.xxx * _SpecColor.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat19 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_12.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_12.y, u_xlat16_12.x);
    u_xlat16_3.x = max(u_xlat16_12.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat7.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_3.xyz = u_xlat9.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat5.xyz;
    u_xlat16_8.xyz = (-u_xlat6.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_4.xyz);
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat16_29 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_11 = exp2(_SpecGloss);
    u_xlat16_20 = u_xlat16_11 * 40.0;
    u_xlat0.x = u_xlat16_20 * _SpecFinal;
    u_xlat9.x = log2(u_xlat16_29);
    u_xlat9.x = u_xlat9.x * u_xlat0.x;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = u_xlat16_11 * u_xlat9.x;
    u_xlat9.xyz = u_xlat9.xxx * _SpecColor.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat19 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_12.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_12.y, u_xlat16_12.x);
    u_xlat16_3.x = max(u_xlat16_12.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat7.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_3.xyz = u_xlat9.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat5.xyz;
    u_xlat16_8.xyz = (-u_xlat6.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

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
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _CameraPos;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _UseLight;
uniform 	float _UseLight1;
uniform 	float _AlphaSplitEnabled;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform 	mediump vec4 _LightPos1;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
float u_xlat19;
mediump float u_xlat16_20;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = (-u_xlat1.xyz) + _CameraPos.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_3.xyz = (-u_xlat1.xyz) + _LightPos.xyz;
    u_xlat16_4.xyz = (-u_xlat1.xyz) + _LightPos1.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + (-u_xlat16_4.xyz);
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat16_29 = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_11 = exp2(_SpecGloss);
    u_xlat16_20 = u_xlat16_11 * 40.0;
    u_xlat0.x = u_xlat16_20 * _SpecFinal;
    u_xlat9.x = log2(u_xlat16_29);
    u_xlat9.x = u_xlat9.x * u_xlat0.x;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = u_xlat16_11 * u_xlat9.x;
    u_xlat9.xyz = u_xlat9.xxx * _SpecColor.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat19 = log2(u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat16_11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * _SpecColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat5.xyz = u_xlat5.xyz * vec3(vec3(_UseLight1, _UseLight1, _UseLight1));
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_AlphaSplitEnabled);
    if(u_xlatb0.x){
        u_xlat10_0 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).x;
        u_xlat16_3.x = u_xlat10_0;
    } else {
        u_xlat16_3.x = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_12.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
    u_xlat16_4.w = u_xlat16_3.x * vs_COLOR0.w;
    u_xlat16_3.x = max(u_xlat16_12.y, u_xlat16_12.x);
    u_xlat16_3.x = max(u_xlat16_12.z, u_xlat16_3.x);
    u_xlat6.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz + (-u_xlat16_3.xxx);
    u_xlat6.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat6.xyz + u_xlat16_3.xxx;
    u_xlat7.xyz = u_xlat6.xyz * vec3(vec3(_Light, _Light, _Light));
    u_xlat16_3.xyz = u_xlat9.xyz * vec3(vec3(_UseLight, _UseLight, _UseLight)) + u_xlat5.xyz;
    u_xlat16_8.xyz = (-u_xlat6.xyz) * vec3(vec3(_Light, _Light, _Light)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz + u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.www * u_xlat16_3.xyz;
    u_xlatb0.xy = greaterThanEqual(u_xlat1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, u_xlat1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0 = u_xlat0.xxxx * u_xlat16_4;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_4;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_ADD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" "_SPECMODE_LERP" }
""
}
}
}
}
}