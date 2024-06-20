//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Glow 11/Blur" {
Properties {
_MainTex ("", 2D) = "" { }
}
SubShader {
 Pass {
  ColorMask RGB 0
  ZTest Always
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 40987
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD1.xy = u_xlat16_2.xz;
    vs_TEXCOORD3.xy = u_xlat16_2.yz;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD2.xy = u_xlat16_2.xz;
    vs_TEXCOORD4.xy = u_xlat16_2.yz;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * vec4(0.31621623, 0.31621623, 0.31621623, 0.31621623);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * vec4(0.0702702701, 0.0702702701, 0.0702702701, 0.0702702701) + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD1.xy = u_xlat16_2.xz;
    vs_TEXCOORD3.xy = u_xlat16_2.yz;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD2.xy = u_xlat16_2.xz;
    vs_TEXCOORD4.xy = u_xlat16_2.yz;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * vec4(0.31621623, 0.31621623, 0.31621623, 0.31621623);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * vec4(0.0702702701, 0.0702702701, 0.0702702701, 0.0702702701) + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD1.xy = u_xlat16_2.xz;
    vs_TEXCOORD3.xy = u_xlat16_2.yz;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD2.xy = u_xlat16_2.xz;
    vs_TEXCOORD4.xy = u_xlat16_2.yz;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * vec4(0.31621623, 0.31621623, 0.31621623, 0.31621623);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * vec4(0.0702702701, 0.0702702701, 0.0702702701, 0.0702702701) + u_xlat0;
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
  ColorMask RGB 0
  ZTest Always
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 114162
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD1.xy = u_xlat16_2.zx;
    vs_TEXCOORD3.xy = u_xlat16_2.zy;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD2.xy = u_xlat16_2.zx;
    vs_TEXCOORD4.xy = u_xlat16_2.zy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * vec4(0.31621623, 0.31621623, 0.31621623, 0.31621623);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * vec4(0.0702702701, 0.0702702701, 0.0702702701, 0.0702702701) + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD1.xy = u_xlat16_2.zx;
    vs_TEXCOORD3.xy = u_xlat16_2.zy;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD2.xy = u_xlat16_2.zx;
    vs_TEXCOORD4.xy = u_xlat16_2.zy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * vec4(0.31621623, 0.31621623, 0.31621623, 0.31621623);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * vec4(0.0702702701, 0.0702702701, 0.0702702701, 0.0702702701) + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD1.xy = u_xlat16_2.zx;
    vs_TEXCOORD3.xy = u_xlat16_2.zy;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD2.xy = u_xlat16_2.zx;
    vs_TEXCOORD4.xy = u_xlat16_2.zy;
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
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * vec4(0.31621623, 0.31621623, 0.31621623, 0.31621623);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * vec4(0.0702702701, 0.0702702701, 0.0702702701, 0.0702702701) + u_xlat0;
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
  ColorMask RGB 0
  ZTest Always
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 162937
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD1.xy = u_xlat16_2.xz;
    vs_TEXCOORD3.xy = u_xlat16_2.yz;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD2.xy = u_xlat16_2.xz;
    vs_TEXCOORD4.xy = u_xlat16_2.yz;
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
uniform 	mediump vec4 _varStrength;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * _varStrength.yyyy;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * _varStrength.xxxx + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * _varStrength.zzzz + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD1.xy = u_xlat16_2.xz;
    vs_TEXCOORD3.xy = u_xlat16_2.yz;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD2.xy = u_xlat16_2.xz;
    vs_TEXCOORD4.xy = u_xlat16_2.yz;
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
uniform 	mediump vec4 _varStrength;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * _varStrength.yyyy;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * _varStrength.xxxx + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * _varStrength.zzzz + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD1.xy = u_xlat16_2.xz;
    vs_TEXCOORD3.xy = u_xlat16_2.yz;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.xx + in_TEXCOORD0.xx;
    u_xlat16_2.z = in_TEXCOORD0.y;
    vs_TEXCOORD2.xy = u_xlat16_2.xz;
    vs_TEXCOORD4.xy = u_xlat16_2.yz;
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
uniform 	mediump vec4 _varStrength;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * _varStrength.yyyy;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * _varStrength.xxxx + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * _varStrength.zzzz + u_xlat0;
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
  ColorMask RGB 0
  ZTest Always
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 244539
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD1.xy = u_xlat16_2.zx;
    vs_TEXCOORD3.xy = u_xlat16_2.zy;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD2.xy = u_xlat16_2.zx;
    vs_TEXCOORD4.xy = u_xlat16_2.zy;
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
uniform 	mediump vec4 _varStrength;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * _varStrength.yyyy;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * _varStrength.xxxx + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * _varStrength.zzzz + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD1.xy = u_xlat16_2.zx;
    vs_TEXCOORD3.xy = u_xlat16_2.zy;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD2.xy = u_xlat16_2.zx;
    vs_TEXCOORD4.xy = u_xlat16_2.zy;
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
uniform 	mediump vec4 _varStrength;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * _varStrength.yyyy;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * _varStrength.xxxx + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * _varStrength.zzzz + u_xlat0;
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
uniform 	mediump float _offset1;
uniform 	mediump float _offset2;
uniform 	mediump vec4 _MainTex_TexelSize;
attribute mediump vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = (-vec2(_offset1, _offset2)) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD1.xy = u_xlat16_2.zx;
    vs_TEXCOORD3.xy = u_xlat16_2.zy;
    u_xlat16_2.xy = vec2(_offset1, _offset2) * _MainTex_TexelSize.yy + in_TEXCOORD0.yy;
    u_xlat16_2.z = in_TEXCOORD0.x;
    vs_TEXCOORD2.xy = u_xlat16_2.zx;
    vs_TEXCOORD4.xy = u_xlat16_2.zy;
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
uniform 	mediump vec4 _varStrength;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat0 = u_xlat0 * _varStrength.yyyy;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * _varStrength.xxxx + u_xlat0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat1 = u_xlat10_1 + u_xlat10_2;
    u_xlat0 = u_xlat1 * _varStrength.zzzz + u_xlat0;
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
}
}