//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/NormalLightMap" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_NormalMap ("Normal Map", 2D) = "bump" { }
_BumpScale ("Bump Scale", Range(0, 4)) = 1
_SpecPower ("高光亮度", Range(0, 1)) = 1
_SpecGloss ("高光光泽度", Range(0, 5)) = 0.6
_SpecFinal ("高光光斑扩散临界点", Range(0, 1)) = 1
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 17194
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NormalMap_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceLightPos0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _WorldSpaceLightPos0.www + u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    vs_TEXCOORD0.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
    vs_TEXCOORD0.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    vs_TEXCOORD1.x = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[0]);
    vs_TEXCOORD1.y = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[1]);
    vs_TEXCOORD1.z = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[2]);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _BumpScale;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture2D(_NormalMap, vs_TEXCOORD2.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.z = u_xlat16_1.z;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_BumpScale);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), u_xlat16_2.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_2.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_13 = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_13) * _LightColor0.xyz;
    u_xlat16_13 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_13 = inversesqrt(u_xlat16_13);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat12 = log2(u_xlat16_1.x);
    u_xlat3.x = exp2(_SpecGloss);
    u_xlat7.x = u_xlat3.x * _SpecFinal;
    u_xlat12 = u_xlat12 * u_xlat7.x;
    u_xlat12 = exp2(u_xlat12);
    u_xlat7.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = u_xlat10_2 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat2.w;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NormalMap_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceLightPos0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _WorldSpaceLightPos0.www + u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    vs_TEXCOORD0.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
    vs_TEXCOORD0.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    vs_TEXCOORD1.x = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[0]);
    vs_TEXCOORD1.y = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[1]);
    vs_TEXCOORD1.z = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[2]);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _BumpScale;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture2D(_NormalMap, vs_TEXCOORD2.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.z = u_xlat16_1.z;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_BumpScale);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), u_xlat16_2.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_2.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_13 = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_13) * _LightColor0.xyz;
    u_xlat16_13 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_13 = inversesqrt(u_xlat16_13);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat12 = log2(u_xlat16_1.x);
    u_xlat3.x = exp2(_SpecGloss);
    u_xlat7.x = u_xlat3.x * _SpecFinal;
    u_xlat12 = u_xlat12 * u_xlat7.x;
    u_xlat12 = exp2(u_xlat12);
    u_xlat7.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = u_xlat10_2 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat2.w;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat16_1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _NormalMap_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat1.xyz = _WorldSpaceLightPos0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-in_POSITION0.xyz) * _WorldSpaceLightPos0.www + u_xlat1.xyz;
    vs_TEXCOORD0.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    vs_TEXCOORD0.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
    vs_TEXCOORD0.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    vs_TEXCOORD1.x = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[0]);
    vs_TEXCOORD1.y = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[1]);
    vs_TEXCOORD1.z = dot(in_POSITION0, hlslcc_mtx4x4unity_WorldToObject[2]);
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _BumpScale;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _NormalMap;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture2D(_NormalMap, vs_TEXCOORD2.zw).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.z = u_xlat16_1.z;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_BumpScale);
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), u_xlat16_2.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_2.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_13 = dot(u_xlat16_2.xyz, u_xlat0.xyz);
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_13) * _LightColor0.xyz;
    u_xlat16_13 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_13 = inversesqrt(u_xlat16_13);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat3.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat12 = log2(u_xlat16_1.x);
    u_xlat3.x = exp2(_SpecGloss);
    u_xlat7.x = u_xlat3.x * _SpecFinal;
    u_xlat12 = u_xlat12 * u_xlat7.x;
    u_xlat12 = exp2(u_xlat12);
    u_xlat7.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz;
    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = u_xlat10_2 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat2.w;
    SV_Target0.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat16_1.xyz;
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