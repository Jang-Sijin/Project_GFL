//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/Simple 2D Water" {
Properties {
_BaseTex ("Base Bg", 2D) = "white" { }
_texChange ("底图干扰强度", Float) = 5
_SurfaceScale ("Surface Scale", Range(0, 1)) = 1
_MainTex ("Surface Bg", 2D) = "white" { }
_BumpScale ("Bump Scale", Range(0, 1)) = 1
_BumpTex ("Bump Texture", 2D) = "white" { }
_uvScale ("uv scale", Range(0, 1)) = 0.2
_BumpDir ("Dir 1,2", Vector) = (0,0,0,0)
_BumpSpeed1 ("Bump Speed1", Range(0, 1)) = 0
_BumpSpeed2 ("Bump Speed2", Range(0, 1)) = 0
_BumpPower ("Bump Power", Range(0, 1)) = 0
_BgTwickPower ("Bg Power", Range(0, 1)) = 0
_Dir ("dir", Vector) = (0,0,0,0)
_SunColor ("SunLight Color", Color) = (1,1,1,1)
_SunBlend ("Sun Blend", Range(0, 1)) = 1
_SunTex ("SunLight Texture", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 47613
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _BaseTex_ST;
uniform 	float _uvScale;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(_uvScale);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.w = (-u_xlat0.y) * 0.5 + 0.5;
    gl_Position = u_xlat0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _SurfaceScale;
uniform 	float _BumpScale;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunBlend;
uniform 	vec4 _BumpDir;
uniform 	vec4 _Dir;
uniform 	float _BumpSpeed1;
uniform 	float _BumpSpeed2;
uniform 	float _BumpPower;
uniform 	float _BgTwickPower;
uniform 	float _texChange;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SunTex;
uniform lowp sampler2D _BaseTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
float u_xlat4;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
mediump vec2 u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(_Dir.xyz, _Dir.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * _Dir.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat0.x = (u_xlatb0) ? -1.0 : 1.0;
    u_xlat1 = _Time.xxxx * _BumpDir;
    u_xlat1 = u_xlat1 * vec4(_BumpSpeed1, _BumpSpeed1, _BumpSpeed2, _BumpSpeed2);
    u_xlat2 = vs_TEXCOORD0.xyxy * vec4(_BumpScale, _BumpScale, _SurfaceScale, _SurfaceScale);
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * vec2(vec2(_BumpScale, _BumpScale)) + u_xlat1.zw;
    u_xlat10_10.xy = texture2D(_BumpTex, u_xlat10.xy).xy;
    u_xlat10_0.xy = texture2D(_BumpTex, u_xlat0.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_13.xy = u_xlat10_10.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat0.xy = u_xlat16_3.xy * vec2(vec2(_BgTwickPower, _BgTwickPower)) + u_xlat2.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_3.xy = u_xlat16_13.xy + vec2(-1.0, -1.0);
    u_xlat1.xy = u_xlat16_3.xy * vec2(vec2(_BumpPower, _BumpPower)) + vs_TEXCOORD0.zw;
    u_xlat10_1 = texture2D(_SunTex, u_xlat1.xy).x;
    u_xlat16_2 = (-u_xlat10_0) + _SunColor;
    u_xlat16_1 = vec4(u_xlat10_1) * u_xlat16_2;
    u_xlat16_1 = vec4(_SunBlend) * u_xlat16_1 + u_xlat10_0;
    u_xlat16_3.x = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_3.x = u_xlat10_0.z + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_3.x * _texChange;
    u_xlat4 = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.y = u_xlat4;
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978) + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_BaseTex, u_xlat0.xy);
    u_xlat16_2 = (-u_xlat16_1) + u_xlat10_0;
    SV_Target0 = u_xlat10_0.xxxx * u_xlat16_2 + u_xlat16_1;
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
uniform 	vec4 _BaseTex_ST;
uniform 	float _uvScale;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(_uvScale);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.w = (-u_xlat0.y) * 0.5 + 0.5;
    gl_Position = u_xlat0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _SurfaceScale;
uniform 	float _BumpScale;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunBlend;
uniform 	vec4 _BumpDir;
uniform 	vec4 _Dir;
uniform 	float _BumpSpeed1;
uniform 	float _BumpSpeed2;
uniform 	float _BumpPower;
uniform 	float _BgTwickPower;
uniform 	float _texChange;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SunTex;
uniform lowp sampler2D _BaseTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
float u_xlat4;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
mediump vec2 u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(_Dir.xyz, _Dir.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * _Dir.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat0.x = (u_xlatb0) ? -1.0 : 1.0;
    u_xlat1 = _Time.xxxx * _BumpDir;
    u_xlat1 = u_xlat1 * vec4(_BumpSpeed1, _BumpSpeed1, _BumpSpeed2, _BumpSpeed2);
    u_xlat2 = vs_TEXCOORD0.xyxy * vec4(_BumpScale, _BumpScale, _SurfaceScale, _SurfaceScale);
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * vec2(vec2(_BumpScale, _BumpScale)) + u_xlat1.zw;
    u_xlat10_10.xy = texture2D(_BumpTex, u_xlat10.xy).xy;
    u_xlat10_0.xy = texture2D(_BumpTex, u_xlat0.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_13.xy = u_xlat10_10.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat0.xy = u_xlat16_3.xy * vec2(vec2(_BgTwickPower, _BgTwickPower)) + u_xlat2.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_3.xy = u_xlat16_13.xy + vec2(-1.0, -1.0);
    u_xlat1.xy = u_xlat16_3.xy * vec2(vec2(_BumpPower, _BumpPower)) + vs_TEXCOORD0.zw;
    u_xlat10_1 = texture2D(_SunTex, u_xlat1.xy).x;
    u_xlat16_2 = (-u_xlat10_0) + _SunColor;
    u_xlat16_1 = vec4(u_xlat10_1) * u_xlat16_2;
    u_xlat16_1 = vec4(_SunBlend) * u_xlat16_1 + u_xlat10_0;
    u_xlat16_3.x = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_3.x = u_xlat10_0.z + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_3.x * _texChange;
    u_xlat4 = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.y = u_xlat4;
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978) + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_BaseTex, u_xlat0.xy);
    u_xlat16_2 = (-u_xlat16_1) + u_xlat10_0;
    SV_Target0 = u_xlat10_0.xxxx * u_xlat16_2 + u_xlat16_1;
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
uniform 	vec4 _BaseTex_ST;
uniform 	float _uvScale;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(_uvScale);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD0.w = (-u_xlat0.y) * 0.5 + 0.5;
    gl_Position = u_xlat0;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _SurfaceScale;
uniform 	float _BumpScale;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunBlend;
uniform 	vec4 _BumpDir;
uniform 	vec4 _Dir;
uniform 	float _BumpSpeed1;
uniform 	float _BumpSpeed2;
uniform 	float _BumpPower;
uniform 	float _BgTwickPower;
uniform 	float _texChange;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SunTex;
uniform lowp sampler2D _BaseTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
float u_xlat4;
vec2 u_xlat10;
lowp vec2 u_xlat10_10;
mediump vec2 u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(_Dir.xyz, _Dir.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * _Dir.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat0.x = (u_xlatb0) ? -1.0 : 1.0;
    u_xlat1 = _Time.xxxx * _BumpDir;
    u_xlat1 = u_xlat1 * vec4(_BumpSpeed1, _BumpSpeed1, _BumpSpeed2, _BumpSpeed2);
    u_xlat2 = vs_TEXCOORD0.xyxy * vec4(_BumpScale, _BumpScale, _SurfaceScale, _SurfaceScale);
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * vec2(vec2(_BumpScale, _BumpScale)) + u_xlat1.zw;
    u_xlat10_10.xy = texture2D(_BumpTex, u_xlat10.xy).xy;
    u_xlat10_0.xy = texture2D(_BumpTex, u_xlat0.xy).xy;
    u_xlat16_3.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_13.xy = u_xlat10_10.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat0.xy = u_xlat16_3.xy * vec2(vec2(_BgTwickPower, _BgTwickPower)) + u_xlat2.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_3.xy = u_xlat16_13.xy + vec2(-1.0, -1.0);
    u_xlat1.xy = u_xlat16_3.xy * vec2(vec2(_BumpPower, _BumpPower)) + vs_TEXCOORD0.zw;
    u_xlat10_1 = texture2D(_SunTex, u_xlat1.xy).x;
    u_xlat16_2 = (-u_xlat10_0) + _SunColor;
    u_xlat16_1 = vec4(u_xlat10_1) * u_xlat16_2;
    u_xlat16_1 = vec4(_SunBlend) * u_xlat16_1 + u_xlat10_0;
    u_xlat16_3.x = u_xlat10_0.y + u_xlat10_0.x;
    u_xlat16_3.x = u_xlat10_0.z + u_xlat16_3.x;
    u_xlat0.x = u_xlat16_3.x * _texChange;
    u_xlat4 = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.y = u_xlat4;
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978) + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_BaseTex, u_xlat0.xy);
    u_xlat16_2 = (-u_xlat16_1) + u_xlat10_0;
    SV_Target0 = u_xlat10_0.xxxx * u_xlat16_2 + u_xlat16_1;
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