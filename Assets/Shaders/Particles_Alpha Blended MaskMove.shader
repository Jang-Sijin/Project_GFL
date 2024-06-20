//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Particles/Alpha Blended MaskMove" {
Properties {
_Color ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_UVXMoveSpeed ("UVX移动速度", Float) = 0
_UVYMoveSpeed ("UVY移动速度", Float) = 0
_MaskTex ("Mask Texture", 2D) = "white" { }
_MaskControl ("Mask 控制(_MaskControl)", Range(0, 2)) = 0
_MaskBright ("Mask 亮度", Float) = 1
_MaskAngle ("Mask 角度", Float) = 0
_MaskSpace ("Mask 移动间隔", Float) = 3
_MaskRange ("Mask 范围", Float) = 2
[MaterialToggle] _MaskAutoMove ("Mask 自动移动", Float) = 0
_MaskMoveSpeed ("Mask 移动速度", Float) = 1
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_XLength ("最终X拉伸", Float) = 1
_YLength ("最终Y拉伸", Float) = 1
_AlphaControl ("透明度控制", Float) = 1
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 22576
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _XLength;
uniform 	float _YLength;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
uniform 	float _MaskAngle;
uniform 	float _MaskMoveSpeed;
uniform 	float _MaskControl;
uniform 	float _MaskSpace;
uniform 	float _MaskRange;
uniform 	float _MaskBright;
uniform 	float _MaskAutoMove;
uniform 	float _UVXMoveSpeed;
uniform 	float _UVYMoveSpeed;
uniform 	float _AlphaControl;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = 0.5;
    u_xlat0.y = _MaskRange;
    u_xlat10.x = _MaskAngle * -0.0174532942;
    u_xlat1.x = sin(u_xlat10.x);
    u_xlat2.x = cos(u_xlat10.x);
    u_xlat10.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xx * u_xlat10.xy;
    u_xlat3.x = u_xlat10.y * u_xlat2.x + (-u_xlat1.x);
    u_xlat3.y = u_xlat10.x * u_xlat2.x + u_xlat1.y;
    u_xlat0.xy = u_xlat0.xy + u_xlat3.xy;
    u_xlat5.x = u_xlat0.y + _MaskControl;
    u_xlat5.x = u_xlat5.x + 0.5;
    u_xlat15 = _Time.x * _MaskAutoMove;
    u_xlat5.x = u_xlat15 * _MaskMoveSpeed + u_xlat5.x;
    u_xlat5.x = u_xlat5.x / _MaskSpace;
    u_xlatb15 = u_xlat5.x>=(-u_xlat5.x);
    u_xlat5.x = fract(abs(u_xlat5.x));
    u_xlat5.x = (u_xlatb15) ? u_xlat5.x : (-u_xlat5.x);
    u_xlat0.z = u_xlat5.x * _MaskSpace;
    u_xlatb5 = _MaskRange>=u_xlat0.z;
    u_xlat10_1 = texture2D(_MaskTex, u_xlat0.xz);
    u_xlat0.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xy = _Time.xx * vec2(_UVXMoveSpeed, _UVYMoveSpeed) + vs_TEXCOORD0.xy;
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat3 = vs_COLOR0 + vs_COLOR0;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat2 = u_xlat10_2 * u_xlat3;
    u_xlat5.x = u_xlat2.w * _AlphaControl;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = u_xlat10_1.w * _MaskBright;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(vec3(_MaskBright, _MaskBright, _MaskBright)) + u_xlat2.xyz;
    u_xlat1.w = max(u_xlat5.x, u_xlat0.x);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _XLength;
uniform 	float _YLength;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
uniform 	float _MaskAngle;
uniform 	float _MaskMoveSpeed;
uniform 	float _MaskControl;
uniform 	float _MaskSpace;
uniform 	float _MaskRange;
uniform 	float _MaskBright;
uniform 	float _MaskAutoMove;
uniform 	float _UVXMoveSpeed;
uniform 	float _UVYMoveSpeed;
uniform 	float _AlphaControl;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = 0.5;
    u_xlat0.y = _MaskRange;
    u_xlat10.x = _MaskAngle * -0.0174532942;
    u_xlat1.x = sin(u_xlat10.x);
    u_xlat2.x = cos(u_xlat10.x);
    u_xlat10.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xx * u_xlat10.xy;
    u_xlat3.x = u_xlat10.y * u_xlat2.x + (-u_xlat1.x);
    u_xlat3.y = u_xlat10.x * u_xlat2.x + u_xlat1.y;
    u_xlat0.xy = u_xlat0.xy + u_xlat3.xy;
    u_xlat5.x = u_xlat0.y + _MaskControl;
    u_xlat5.x = u_xlat5.x + 0.5;
    u_xlat15 = _Time.x * _MaskAutoMove;
    u_xlat5.x = u_xlat15 * _MaskMoveSpeed + u_xlat5.x;
    u_xlat5.x = u_xlat5.x / _MaskSpace;
    u_xlatb15 = u_xlat5.x>=(-u_xlat5.x);
    u_xlat5.x = fract(abs(u_xlat5.x));
    u_xlat5.x = (u_xlatb15) ? u_xlat5.x : (-u_xlat5.x);
    u_xlat0.z = u_xlat5.x * _MaskSpace;
    u_xlatb5 = _MaskRange>=u_xlat0.z;
    u_xlat10_1 = texture2D(_MaskTex, u_xlat0.xz);
    u_xlat0.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xy = _Time.xx * vec2(_UVXMoveSpeed, _UVYMoveSpeed) + vs_TEXCOORD0.xy;
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat3 = vs_COLOR0 + vs_COLOR0;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat2 = u_xlat10_2 * u_xlat3;
    u_xlat5.x = u_xlat2.w * _AlphaControl;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = u_xlat10_1.w * _MaskBright;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(vec3(_MaskBright, _MaskBright, _MaskBright)) + u_xlat2.xyz;
    u_xlat1.w = max(u_xlat5.x, u_xlat0.x);
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
uniform 	vec4 _MainTex_ST;
uniform 	float _XLength;
uniform 	float _YLength;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Color;
uniform 	float _MaskAngle;
uniform 	float _MaskMoveSpeed;
uniform 	float _MaskControl;
uniform 	float _MaskSpace;
uniform 	float _MaskRange;
uniform 	float _MaskBright;
uniform 	float _MaskAutoMove;
uniform 	float _UVXMoveSpeed;
uniform 	float _UVYMoveSpeed;
uniform 	float _AlphaControl;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = 0.5;
    u_xlat0.y = _MaskRange;
    u_xlat10.x = _MaskAngle * -0.0174532942;
    u_xlat1.x = sin(u_xlat10.x);
    u_xlat2.x = cos(u_xlat10.x);
    u_xlat10.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
    u_xlat1.xy = u_xlat1.xx * u_xlat10.xy;
    u_xlat3.x = u_xlat10.y * u_xlat2.x + (-u_xlat1.x);
    u_xlat3.y = u_xlat10.x * u_xlat2.x + u_xlat1.y;
    u_xlat0.xy = u_xlat0.xy + u_xlat3.xy;
    u_xlat5.x = u_xlat0.y + _MaskControl;
    u_xlat5.x = u_xlat5.x + 0.5;
    u_xlat15 = _Time.x * _MaskAutoMove;
    u_xlat5.x = u_xlat15 * _MaskMoveSpeed + u_xlat5.x;
    u_xlat5.x = u_xlat5.x / _MaskSpace;
    u_xlatb15 = u_xlat5.x>=(-u_xlat5.x);
    u_xlat5.x = fract(abs(u_xlat5.x));
    u_xlat5.x = (u_xlatb15) ? u_xlat5.x : (-u_xlat5.x);
    u_xlat0.z = u_xlat5.x * _MaskSpace;
    u_xlatb5 = _MaskRange>=u_xlat0.z;
    u_xlat10_1 = texture2D(_MaskTex, u_xlat0.xz);
    u_xlat0.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat5.xy = _Time.xx * vec2(_UVXMoveSpeed, _UVYMoveSpeed) + vs_TEXCOORD0.xy;
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat3 = vs_COLOR0 + vs_COLOR0;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat2 = u_xlat10_2 * u_xlat3;
    u_xlat5.x = u_xlat2.w * _AlphaControl;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = u_xlat10_1.w * _MaskBright;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(vec3(_MaskBright, _MaskBright, _MaskBright)) + u_xlat2.xyz;
    u_xlat1.w = max(u_xlat5.x, u_xlat0.x);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _XLength;
uniform 	float _YLength;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = u_xlat1.xy * vec2(_XLength, _YLength);
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat2 = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.w = u_xlat1.w;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _Color;
uniform 	float _MaskAngle;
uniform 	float _MaskMoveSpeed;
uniform 	float _MaskControl;
uniform 	float _MaskSpace;
uniform 	float _MaskRange;
uniform 	float _MaskBright;
uniform 	float _MaskAutoMove;
uniform 	float _UVXMoveSpeed;
uniform 	float _UVYMoveSpeed;
uniform 	float _AlphaControl;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _Color;
    u_xlat1.xy = _Time.xx * vec2(_UVXMoveSpeed, _UVYMoveSpeed) + vs_TEXCOORD0.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat18 = u_xlat0.w * _AlphaControl;
    u_xlat1.x = 0.5;
    u_xlat1.y = _MaskRange;
    u_xlat13.x = _MaskAngle * -0.0174532942;
    u_xlat2.x = sin(u_xlat13.x);
    u_xlat3 = cos(u_xlat13.x);
    u_xlat13.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat2.xx * u_xlat13.xy;
    u_xlat4.x = u_xlat13.y * u_xlat3 + (-u_xlat2.x);
    u_xlat4.y = u_xlat13.x * u_xlat3 + u_xlat2.y;
    u_xlat1.xy = u_xlat1.xy + u_xlat4.xy;
    u_xlat7 = u_xlat1.y + _MaskControl;
    u_xlat7 = u_xlat7 + 0.5;
    u_xlat19 = _Time.x * _MaskAutoMove;
    u_xlat7 = u_xlat19 * _MaskMoveSpeed + u_xlat7;
    u_xlat7 = u_xlat7 / _MaskSpace;
    u_xlatb19 = u_xlat7>=(-u_xlat7);
    u_xlat7 = fract(abs(u_xlat7));
    u_xlat7 = (u_xlatb19) ? u_xlat7 : (-u_xlat7);
    u_xlat1.z = u_xlat7 * _MaskSpace;
    u_xlatb7 = _MaskRange>=u_xlat1.z;
    u_xlat10_2 = texture2D(_MaskTex, u_xlat1.xz);
    u_xlat1.x = u_xlatb7 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x;
    u_xlat1.x = u_xlat10_2.w * _MaskBright;
    u_xlat16_5.xyz = u_xlat10_2.www * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_MaskBright, _MaskBright, _MaskBright)) + u_xlat0.xyz;
    u_xlat2.w = max(u_xlat18, u_xlat1.x);
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _XLength;
uniform 	float _YLength;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = u_xlat1.xy * vec2(_XLength, _YLength);
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat2 = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.w = u_xlat1.w;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _Color;
uniform 	float _MaskAngle;
uniform 	float _MaskMoveSpeed;
uniform 	float _MaskControl;
uniform 	float _MaskSpace;
uniform 	float _MaskRange;
uniform 	float _MaskBright;
uniform 	float _MaskAutoMove;
uniform 	float _UVXMoveSpeed;
uniform 	float _UVYMoveSpeed;
uniform 	float _AlphaControl;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _Color;
    u_xlat1.xy = _Time.xx * vec2(_UVXMoveSpeed, _UVYMoveSpeed) + vs_TEXCOORD0.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat18 = u_xlat0.w * _AlphaControl;
    u_xlat1.x = 0.5;
    u_xlat1.y = _MaskRange;
    u_xlat13.x = _MaskAngle * -0.0174532942;
    u_xlat2.x = sin(u_xlat13.x);
    u_xlat3 = cos(u_xlat13.x);
    u_xlat13.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat2.xx * u_xlat13.xy;
    u_xlat4.x = u_xlat13.y * u_xlat3 + (-u_xlat2.x);
    u_xlat4.y = u_xlat13.x * u_xlat3 + u_xlat2.y;
    u_xlat1.xy = u_xlat1.xy + u_xlat4.xy;
    u_xlat7 = u_xlat1.y + _MaskControl;
    u_xlat7 = u_xlat7 + 0.5;
    u_xlat19 = _Time.x * _MaskAutoMove;
    u_xlat7 = u_xlat19 * _MaskMoveSpeed + u_xlat7;
    u_xlat7 = u_xlat7 / _MaskSpace;
    u_xlatb19 = u_xlat7>=(-u_xlat7);
    u_xlat7 = fract(abs(u_xlat7));
    u_xlat7 = (u_xlatb19) ? u_xlat7 : (-u_xlat7);
    u_xlat1.z = u_xlat7 * _MaskSpace;
    u_xlatb7 = _MaskRange>=u_xlat1.z;
    u_xlat10_2 = texture2D(_MaskTex, u_xlat1.xz);
    u_xlat1.x = u_xlatb7 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x;
    u_xlat1.x = u_xlat10_2.w * _MaskBright;
    u_xlat16_5.xyz = u_xlat10_2.www * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_MaskBright, _MaskBright, _MaskBright)) + u_xlat0.xyz;
    u_xlat2.w = max(u_xlat18, u_xlat1.x);
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _XLength;
uniform 	float _YLength;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = u_xlat1.xy * vec2(_XLength, _YLength);
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat2 = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.w = u_xlat1.w;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _Color;
uniform 	float _MaskAngle;
uniform 	float _MaskMoveSpeed;
uniform 	float _MaskControl;
uniform 	float _MaskSpace;
uniform 	float _MaskRange;
uniform 	float _MaskBright;
uniform 	float _MaskAutoMove;
uniform 	float _UVXMoveSpeed;
uniform 	float _UVYMoveSpeed;
uniform 	float _AlphaControl;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
bool u_xlatb7;
vec2 u_xlat13;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.w = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0 = u_xlat0 * _Color;
    u_xlat1.xy = _Time.xx * vec2(_UVXMoveSpeed, _UVYMoveSpeed) + vs_TEXCOORD0.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat0 = u_xlat0 * u_xlat10_1;
    u_xlat18 = u_xlat0.w * _AlphaControl;
    u_xlat1.x = 0.5;
    u_xlat1.y = _MaskRange;
    u_xlat13.x = _MaskAngle * -0.0174532942;
    u_xlat2.x = sin(u_xlat13.x);
    u_xlat3 = cos(u_xlat13.x);
    u_xlat13.xy = vs_TEXCOORD0.yx + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat2.xx * u_xlat13.xy;
    u_xlat4.x = u_xlat13.y * u_xlat3 + (-u_xlat2.x);
    u_xlat4.y = u_xlat13.x * u_xlat3 + u_xlat2.y;
    u_xlat1.xy = u_xlat1.xy + u_xlat4.xy;
    u_xlat7 = u_xlat1.y + _MaskControl;
    u_xlat7 = u_xlat7 + 0.5;
    u_xlat19 = _Time.x * _MaskAutoMove;
    u_xlat7 = u_xlat19 * _MaskMoveSpeed + u_xlat7;
    u_xlat7 = u_xlat7 / _MaskSpace;
    u_xlatb19 = u_xlat7>=(-u_xlat7);
    u_xlat7 = fract(abs(u_xlat7));
    u_xlat7 = (u_xlatb19) ? u_xlat7 : (-u_xlat7);
    u_xlat1.z = u_xlat7 * _MaskSpace;
    u_xlatb7 = _MaskRange>=u_xlat1.z;
    u_xlat10_2 = texture2D(_MaskTex, u_xlat1.xz);
    u_xlat1.x = u_xlatb7 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x;
    u_xlat1.x = u_xlat10_2.w * _MaskBright;
    u_xlat16_5.xyz = u_xlat10_2.www * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(vec3(_MaskBright, _MaskBright, _MaskBright)) + u_xlat0.xyz;
    u_xlat2.w = max(u_xlat18, u_xlat1.x);
    SV_Target0 = u_xlat2;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
}
}
}
}