//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/QuadMove" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_Alpha ("整体透明", Range(0, 1)) = 1
_MoveSpeed ("移动速度", Float) = 1
_TexColor ("贴图颜色", Color) = (1,0,0,1)
_baseColor ("面颜色", Color) = (1,0,0,1)
_bright ("亮度", Float) = 1
_deep ("高度0", Float) = 0
_Height ("高度1", Float) = 1
}
SubShader {
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Always
  Cull Front
  GpuProgramID 57442
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _MoveSpeed;
uniform 	vec4 _baseColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _deep;
uniform 	float _Height;
uniform 	float _bright;
uniform 	vec4 _TexColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(0.0, 1.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _TexColor;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat2.xzw = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = u_xlat2.y + (-_deep);
    u_xlat5 = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xzw;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0 * abs(u_xlat1.xxxx);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat2 = u_xlat1.xxxx * _baseColor;
    u_xlat16_0 = u_xlat2 * vec4(vec4(_bright, _bright, _bright, _bright)) + u_xlat0;
    u_xlat1.x = (-_deep) + _Height;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = u_xlat1.x * _Alpha;
    SV_Target0.w = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _MoveSpeed;
uniform 	vec4 _baseColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _deep;
uniform 	float _Height;
uniform 	float _bright;
uniform 	vec4 _TexColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(0.0, 1.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _TexColor;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat2.xzw = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = u_xlat2.y + (-_deep);
    u_xlat5 = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xzw;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0 * abs(u_xlat1.xxxx);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat2 = u_xlat1.xxxx * _baseColor;
    u_xlat16_0 = u_xlat2 * vec4(vec4(_bright, _bright, _bright, _bright)) + u_xlat0;
    u_xlat1.x = (-_deep) + _Height;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = u_xlat1.x * _Alpha;
    SV_Target0.w = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _MoveSpeed;
uniform 	vec4 _baseColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _deep;
uniform 	float _Height;
uniform 	float _bright;
uniform 	vec4 _TexColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(0.0, 1.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _TexColor;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat2.xzw = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = u_xlat2.y + (-_deep);
    u_xlat5 = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xzw;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0 * abs(u_xlat1.xxxx);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat2 = u_xlat1.xxxx * _baseColor;
    u_xlat16_0 = u_xlat2 * vec4(vec4(_bright, _bright, _bright, _bright)) + u_xlat0;
    u_xlat1.x = (-_deep) + _Height;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = u_xlat1.x * _Alpha;
    SV_Target0.w = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Always
  ZWrite Off
  GpuProgramID 85757
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _MoveSpeed;
uniform 	vec4 _baseColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _deep;
uniform 	float _Height;
uniform 	float _bright;
uniform 	vec4 _TexColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(0.0, 1.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _TexColor;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat2.xzw = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = u_xlat2.y + (-_deep);
    u_xlat5 = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xzw;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0 * abs(u_xlat1.xxxx);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat2 = u_xlat1.xxxx * _baseColor;
    u_xlat16_0 = u_xlat2 * vec4(vec4(_bright, _bright, _bright, _bright)) + u_xlat0;
    u_xlat1.x = (-_deep) + _Height;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = u_xlat1.x * _Alpha;
    SV_Target0.w = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _MoveSpeed;
uniform 	vec4 _baseColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _deep;
uniform 	float _Height;
uniform 	float _bright;
uniform 	vec4 _TexColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(0.0, 1.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _TexColor;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat2.xzw = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = u_xlat2.y + (-_deep);
    u_xlat5 = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xzw;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0 * abs(u_xlat1.xxxx);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat2 = u_xlat1.xxxx * _baseColor;
    u_xlat16_0 = u_xlat2 * vec4(vec4(_bright, _bright, _bright, _bright)) + u_xlat0;
    u_xlat1.x = (-_deep) + _Height;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = u_xlat1.x * _Alpha;
    SV_Target0.w = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
attribute highp vec4 in_TANGENT0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _MoveSpeed;
uniform 	vec4 _baseColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _deep;
uniform 	float _Height;
uniform 	float _bright;
uniform 	vec4 _TexColor;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat4;
float u_xlat5;
float u_xlat10;
void main()
{
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat0.xy = u_xlat0.xx * vec2(0.0, 1.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _TexColor;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat2.xzw = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = u_xlat2.y + (-_deep);
    u_xlat5 = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xzw;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat0 = u_xlat0 * abs(u_xlat1.xxxx);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat2 = u_xlat1.xxxx * _baseColor;
    u_xlat16_0 = u_xlat2 * vec4(vec4(_bright, _bright, _bright, _bright)) + u_xlat0;
    u_xlat1.x = (-_deep) + _Height;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = u_xlat1.x * _Alpha;
    SV_Target0.w = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
Fallback "Diffuse"
}