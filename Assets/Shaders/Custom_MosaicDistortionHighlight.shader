//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/MosaicDistortionHighlight" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("_Color", Color) = (1,1,1,1)
_NoiseTex ("扭曲图_NoiseTex", 2D) = "white" { }
_Range ("幅度_Range", Range(0, 1)) = 0
_Difference ("弱化差分_Difference", Range(0, 0.5)) = 0
_MaskColor ("_MaskColor", Color) = (1,0,0,0)
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_Trans ("黑白过渡", Range(0, 1)) = 1
_Light ("深度过渡", Range(0, 1)) = 1
_SpecColor ("高光颜色", Color) = (1,1,1,1)
_SpecPower ("高光亮度", Float) = 1
_SpecGloss ("高光光泽度", Float) = 0.6
_SpecFinal ("高光光斑扩散临界点", Float) = 10
_LightPos ("灯光位置", Vector) = (1,0,0,0)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IngnoreProjector" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IngnoreProjector" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
  GpuProgramID 44331
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat5.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat1.xy = roundEven(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
    u_xlat0.xy = u_xlat0.ww * u_xlat1.xy;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat5.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat1.xy = roundEven(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
    u_xlat0.xy = u_xlat0.ww * u_xlat1.xy;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat5.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat1.xy = roundEven(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
    u_xlat0.xy = u_xlat0.ww * u_xlat1.xy;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat5.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat1.xy = roundEven(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
    u_xlat0.xy = u_xlat0.ww * u_xlat1.xy;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat5.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat1.xy = roundEven(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
    u_xlat0.xy = u_xlat0.ww * u_xlat1.xy;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
float roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 roundEven(vec2 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); return a; }
vec3 roundEven(vec3 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); return a; }
vec4 roundEven(vec4 a) { a.x = roundEven(a.x); a.y = roundEven(a.y); a.z = roundEven(a.z); a.w = roundEven(a.w); return a; }

void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat5.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat1.xy = roundEven(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy / u_xlat5.xy;
    u_xlat0.xy = u_xlat0.ww * u_xlat1.xy;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _Range;
uniform 	mediump float _Difference;
uniform 	int _UseClipRect;
uniform 	vec4 _ClipRect;
uniform 	float _Trans;
uniform 	float _Light;
uniform 	float _SpecPower;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _SpecGloss;
uniform 	mediump vec4 _LightPos;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.x = dot(_LightPos, _LightPos);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * _LightPos.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat16_0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat16_0.xyz;
    u_xlat16_18 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_6 = exp2(_SpecGloss);
    u_xlat16_12 = u_xlat16_6 * 40.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_12;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_0.xxx * _SpecColor.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_3.xyz = texture2D(_NoiseTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xy = u_xlat10_3.xy * _MaskColor.xy;
    u_xlat16_0.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_0.x = u_xlat10_3.z * _MaskColor.z + u_xlat16_0.x;
    u_xlatb19 = u_xlat16_0.x>=0.0500000007;
    u_xlat16_0.x = (u_xlatb19) ? _Range : 0.0;
    u_xlat19 = u_xlatb19 ? 0.100000001 : float(0.0);
    u_xlat19 = (-u_xlat19) * _Range + 1.0;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(-0.0500000007, 0.0, 0.0500000007, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat0 = vec4(u_xlat19) * u_xlat10_0;
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_3.xy = vec2(vec2(_Difference, _Difference)) * vec2(0.5, 0.5);
    u_xlat16_3.z = (-_Difference) + 1.0;
    u_xlat16_3.w = 0.333299994;
    u_xlat16_0 = u_xlat0 * u_xlat16_3.xzyw;
    u_xlat16_0 = u_xlat2 * u_xlat16_3.zyyw + u_xlat16_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat19) * u_xlat10_2;
    u_xlat16_0 = u_xlat2 * u_xlat16_3 + u_xlat16_0;
    u_xlat16_2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_4 = max(u_xlat16_2.y, u_xlat16_2.x);
    u_xlat16_4 = max(u_xlat16_2.z, u_xlat16_4);
    u_xlat5.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-vec3(u_xlat16_4));
    u_xlat5.xyz = vec3(vec3(_Trans, _Trans, _Trans)) * u_xlat5.xyz + vec3(u_xlat16_4);
    u_xlat1.xyz = u_xlat5.xyz * vec3(vec3(_Light, _Light, _Light)) + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.www * u_xlat1.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat16_2;
    SV_Target0 = (_UseClipRect != 0) ? u_xlat0 : u_xlat16_2;
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
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
""
}
}
}
}
Fallback "UI/Default"
}