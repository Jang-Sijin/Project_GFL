//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/EchoSpot" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_LineTex ("条纹图", 2D) = "white" { }
_Height ("高度控制", Range(-1, 1)) = 1
_Check ("调节", Float) = 0
_NoiseTex ("噪音图", 2D) = "white" { }
_Alpha ("透明调节", Range(0, 1)) = 1
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
  Blend SrcAlpha One, SrcAlpha One
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
  GpuProgramID 19096
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" "UNITY_ETC1_EXTERNAL_ALPHA" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _LineTex_ST;
uniform 	vec4 _NoiseTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _LineTex_ST.xy + _LineTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
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
uniform 	float _Height;
uniform 	float _Check;
uniform 	float _Alpha;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.y + 0.899999976;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.y = _Time.x * 10.0 + vs_TEXCOORD3.y;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlatb0 = 0.0500000007>=u_xlat0.x;
    u_xlat16_1 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_4.xyz;
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.y = _Time.x * 50.0 + vs_TEXCOORD2.y;
    u_xlat2.x = vs_TEXCOORD2.x;
    u_xlat10_1 = texture2D(_LineTex, u_xlat2.xy);
    u_xlat16_0 = u_xlat0 * u_xlat10_1 + u_xlat0;
    u_xlat2.x = _Height * 0.5 + _Check;
    u_xlat2.y = u_xlat2.x + 0.5;
    u_xlat2.x = vs_TEXCOORD0.x;
    u_xlat1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlatb2 = vs_TEXCOORD1.y<_Height;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_0 : u_xlat1;
    u_xlat1 = vs_COLOR0 * _Color;
    u_xlat0 = u_xlat16_0 * u_xlat1;
    u_xlat0.w = u_xlat0.w * _Alpha;
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
}