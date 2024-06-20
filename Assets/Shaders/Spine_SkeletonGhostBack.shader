//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/SkeletonGhostBack" {
Properties {
_Alpha ("Color Fade", Range(0, 1)) = 1
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" { }
_BackColor ("遮挡背景颜色", Color) = (0,0,0,0)
_AlphaTex ("Alpha图", 2D) = "white" { }
_TextureFade ("Texture Fade Out", Range(0, 1)) = 0
_AlphaControl ("透明度控制(_AlphaControl)", Range(0, 1)) = 1
_AddControl ("叠加颜色控制(_AddControl)", Range(0, 1)) = 0
_ControlColor ("叠加颜色(_ControlColor)", Color) = (0,0,0,0)
_AddLoopDuration ("叠加颜色动效持续时间_AddLoopDuration", Float) = 0
_OffsetFactor ("Offset Factor", Float) = 0
_OffsetUnits ("Offset Units", Float) = 0
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 0
_AnimTexture ("动画贴图（_AnimTexture）", 2D) = "black" { }
_R_Channel_Speed ("R Channel Speed", Range(-5, 5)) = 0
_R_Channel_Factor ("R Channel Factor", Vector) = (0,0,0,0)
[Enum(Off, 0, On, 1)] _useFog ("使用雾", Float) = 0
_FarFogColor ("远度雾", Color) = (0.5,0.5,0.5,0)
_FarMinDistance ("雾最远距离", Float) = 25
_FarAddDistance ("雾叠加距离", Float) = 30
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Greater
  ZWrite Off
  GpuProgramID 18690
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _BackColor;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0.w = u_xlat10_0 * _BackColor.w;
    u_xlat0.xyz = _BackColor.xyz;
    SV_Target0 = u_xlat0;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _BackColor;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0.w = u_xlat10_0 * _BackColor.w;
    u_xlat0.xyz = _BackColor.xyz;
    SV_Target0 = u_xlat0;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _BackColor;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0.w = u_xlat10_0 * _BackColor.w;
    u_xlat0.xyz = _BackColor.xyz;
    SV_Target0 = u_xlat0;
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
 Pass {
  Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 66472
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump float u_xlat16_10;
float u_xlat11;
float u_xlat19;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4 = sin(u_xlat1.x);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    u_xlat16_10 = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_10 + _R_Channel_Factor.w;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * vec4(u_xlat16_4) + u_xlat0;
    u_xlat1.xyz = (-vec3(_AlphaControl)) * u_xlat16_0.xyz + _FarFogColor.xyz;
    u_xlat2 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat19 = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_FarMinDistance);
    u_xlat11 = float(1.0) / _FarAddDistance;
    u_xlat5.x = u_xlat11 * u_xlat5.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat11 = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat11;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.w = u_xlat5.x * u_xlat19 + u_xlat2.w;
    u_xlatb1 = _useFog==1.0;
    SV_Target0 = (bool(u_xlatb1)) ? u_xlat0 : u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump float u_xlat16_10;
float u_xlat11;
float u_xlat19;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4 = sin(u_xlat1.x);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    u_xlat16_10 = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_10 + _R_Channel_Factor.w;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * vec4(u_xlat16_4) + u_xlat0;
    u_xlat1.xyz = (-vec3(_AlphaControl)) * u_xlat16_0.xyz + _FarFogColor.xyz;
    u_xlat2 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat19 = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_FarMinDistance);
    u_xlat11 = float(1.0) / _FarAddDistance;
    u_xlat5.x = u_xlat11 * u_xlat5.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat11 = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat11;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.w = u_xlat5.x * u_xlat19 + u_xlat2.w;
    u_xlatb1 = _useFog==1.0;
    SV_Target0 = (bool(u_xlatb1)) ? u_xlat0 : u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump float u_xlat16_10;
float u_xlat11;
float u_xlat19;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4 = sin(u_xlat1.x);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    u_xlat16_10 = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_10 + _R_Channel_Factor.w;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * vec4(u_xlat16_4) + u_xlat0;
    u_xlat1.xyz = (-vec3(_AlphaControl)) * u_xlat16_0.xyz + _FarFogColor.xyz;
    u_xlat2 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat19 = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_FarMinDistance);
    u_xlat11 = float(1.0) / _FarAddDistance;
    u_xlat5.x = u_xlat11 * u_xlat5.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat11 = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat11;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.w = u_xlat5.x * u_xlat19 + u_xlat2.w;
    u_xlatb1 = _useFog==1.0;
    SV_Target0 = (bool(u_xlatb1)) ? u_xlat0 : u_xlat2;
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
CustomEditor "ShadowLitGUI"
}