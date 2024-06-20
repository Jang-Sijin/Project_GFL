//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "OPS/LineNight" {
Properties {
_TinColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_MoveTex ("移动贴图", 2D) = "white" { }
_ShowMove ("显示移动", Range(0, 1)) = 0
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_Alpha ("透明度", Range(0, 1)) = 1
_Control ("控制", Range(0, 1)) = 1
_sam ("采样", Float) = 15
_moveSpeed ("移速", Float) = 50
_clip ("剪裁", Range(0, 0.5)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 4362
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MoveTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MoveTex_ST.xy + _MoveTex_ST.zw;
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
uniform 	mediump vec4 _TinColor;
uniform 	float _Control;
uniform 	float _Alpha;
uniform 	float _sam;
uniform 	float _ShowMove;
uniform 	float _moveSpeed;
uniform 	float _clip;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + _Control;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + _clip;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = _Time.x * _moveSpeed;
    u_xlat0.x = vs_TEXCOORD1.x * _sam + u_xlat0.x;
    u_xlat0.y = vs_TEXCOORD1.y;
    u_xlat10_0 = texture2D(_MoveTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0 * _TinColor;
    u_xlat0 = u_xlat10_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(1.5, 1.5, 1.5, 1.5) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(vec4(_ShowMove, _ShowMove, _ShowMove, _ShowMove)) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2 = vs_COLOR0.w * _Alpha;
    u_xlat0.w = u_xlat0.w * u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MoveTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MoveTex_ST.xy + _MoveTex_ST.zw;
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
uniform 	mediump vec4 _TinColor;
uniform 	float _Control;
uniform 	float _Alpha;
uniform 	float _sam;
uniform 	float _ShowMove;
uniform 	float _moveSpeed;
uniform 	float _clip;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + _Control;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + _clip;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = _Time.x * _moveSpeed;
    u_xlat0.x = vs_TEXCOORD1.x * _sam + u_xlat0.x;
    u_xlat0.y = vs_TEXCOORD1.y;
    u_xlat10_0 = texture2D(_MoveTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0 * _TinColor;
    u_xlat0 = u_xlat10_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(1.5, 1.5, 1.5, 1.5) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(vec4(_ShowMove, _ShowMove, _ShowMove, _ShowMove)) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2 = vs_COLOR0.w * _Alpha;
    u_xlat0.w = u_xlat0.w * u_xlat2;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MoveTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MoveTex_ST.xy + _MoveTex_ST.zw;
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
uniform 	mediump vec4 _TinColor;
uniform 	float _Control;
uniform 	float _Alpha;
uniform 	float _sam;
uniform 	float _ShowMove;
uniform 	float _moveSpeed;
uniform 	float _clip;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + _Control;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + _clip;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = _Time.x * _moveSpeed;
    u_xlat0.x = vs_TEXCOORD1.x * _sam + u_xlat0.x;
    u_xlat0.y = vs_TEXCOORD1.y;
    u_xlat10_0 = texture2D(_MoveTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0 * _TinColor;
    u_xlat0 = u_xlat10_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(1.5, 1.5, 1.5, 1.5) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(vec4(_ShowMove, _ShowMove, _ShowMove, _ShowMove)) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2 = vs_COLOR0.w * _Alpha;
    u_xlat0.w = u_xlat0.w * u_xlat2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MoveTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MoveTex_ST.xy + _MoveTex_ST.zw;
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
uniform 	mediump vec4 _TinColor;
uniform 	float _Control;
uniform 	float _Alpha;
uniform 	float _sam;
uniform 	float _ShowMove;
uniform 	float _moveSpeed;
uniform 	float _clip;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + _Control;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + _clip;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = _Time.x * _moveSpeed;
    u_xlat0.x = vs_TEXCOORD1.x * _sam + u_xlat0.x;
    u_xlat0.y = vs_TEXCOORD1.y;
    u_xlat10_0 = texture2D(_MoveTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0 * _TinColor;
    u_xlat0 = u_xlat10_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(1.5, 1.5, 1.5, 1.5) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(vec4(_ShowMove, _ShowMove, _ShowMove, _ShowMove)) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2 = vs_COLOR0.w * _Alpha;
    u_xlat0.w = u_xlat0.w * u_xlat2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MoveTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MoveTex_ST.xy + _MoveTex_ST.zw;
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
uniform 	mediump vec4 _TinColor;
uniform 	float _Control;
uniform 	float _Alpha;
uniform 	float _sam;
uniform 	float _ShowMove;
uniform 	float _moveSpeed;
uniform 	float _clip;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + _Control;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + _clip;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = _Time.x * _moveSpeed;
    u_xlat0.x = vs_TEXCOORD1.x * _sam + u_xlat0.x;
    u_xlat0.y = vs_TEXCOORD1.y;
    u_xlat10_0 = texture2D(_MoveTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0 * _TinColor;
    u_xlat0 = u_xlat10_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(1.5, 1.5, 1.5, 1.5) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(vec4(_ShowMove, _ShowMove, _ShowMove, _ShowMove)) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2 = vs_COLOR0.w * _Alpha;
    u_xlat0.w = u_xlat0.w * u_xlat2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MoveTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MoveTex_ST.xy + _MoveTex_ST.zw;
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
uniform 	mediump vec4 _TinColor;
uniform 	float _Control;
uniform 	float _Alpha;
uniform 	float _sam;
uniform 	float _ShowMove;
uniform 	float _moveSpeed;
uniform 	float _clip;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD0.x) + _Control;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = -abs(u_xlat0.x) + _clip;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = _Time.x * _moveSpeed;
    u_xlat0.x = vs_TEXCOORD1.x * _sam + u_xlat0.x;
    u_xlat0.y = vs_TEXCOORD1.y;
    u_xlat10_0 = texture2D(_MoveTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0 * _TinColor;
    u_xlat0 = u_xlat10_0 * u_xlat16_1;
    u_xlat0 = u_xlat0 * vec4(1.5, 1.5, 1.5, 1.5) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vec4(vec4(_ShowMove, _ShowMove, _ShowMove, _ShowMove)) * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * u_xlat10_2;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2 = vs_COLOR0.w * _Alpha;
    u_xlat0.w = u_xlat0.w * u_xlat2;
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