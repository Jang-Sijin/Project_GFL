//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/Water" {
Properties {
_WaveScale ("Wave scale", Range(0, 0.15)) = 0.063
_ReflDistort ("Reflection distort", Range(0, 1.5)) = 0.44
_RefrDistort ("Refraction distort", Range(0, 1.5)) = 0.4
_RefrColor ("Refraction color", Color) = (0.34,0.85,0.92,1)
_MainTex ("MainTex", 2D) = "white" { }
_Fresnel ("Fresnel (A) ", 2D) = "gray" { }
_BumpMap ("Normalmap ", 2D) = "bump" { }
WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
_ReflectiveColor ("Reflective color (RGB) fresnel (A) ", 2D) = "" { }
_HorizonColor ("Simple water horizon color", Color) = (0.172,0.463,0.435,1)
_ReflectionTex ("Internal Reflection", 2D) = "" { }
_RefractionTex ("Internal Refraction", 2D) = "" { }
_lightpos ("灯光位置", Vector) = (100,100,100,1)
_SpecPower ("高光亮度", Float) = 1
_Gloss ("高光光泽度", Float) = 0.6
_SpecFinal ("高光光斑扩散临界点", Float) = 10
}
SubShader {
 Tags { "RenderType" = "Opaque" "WaterMode" = "Refractive" }
 Pass {
  Tags { "RenderType" = "Opaque" "WaterMode" = "Refractive" }
  GpuProgramID 7139
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD3 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	float _ReflDistort;
uniform 	float _RefrDistort;
uniform 	vec4 _RefrColor;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Fresnel;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD3.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = log2(u_xlat15);
    u_xlat1.x = exp2(_Gloss);
    u_xlat6 = u_xlat1.x * _SpecFinal;
    u_xlat15 = u_xlat15 * u_xlat6;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = u_xlat1.x * u_xlat15;
    u_xlat16_2.x = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat10_0 = texture2D(_Fresnel, u_xlat16_2.xx).w;
    u_xlat5.xy = u_xlat16_3.xy * vec2(_ReflDistort) + vs_TEXCOORD0.xy;
    u_xlat1.xy = (-u_xlat16_3.xy) * vec2(vec2(_RefrDistort, _RefrDistort)) + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture2D(_RefractionTex, u_xlat1.xy);
    u_xlat5.xy = u_xlat5.xy / vs_TEXCOORD0.ww;
    u_xlat10_2 = texture2D(_ReflectionTex, u_xlat5.xy);
    u_xlat16_2 = (-u_xlat10_1) * _RefrColor + u_xlat10_2;
    u_xlat1 = u_xlat10_1 * _RefrColor;
    u_xlat16_1 = vec4(u_xlat10_0) * u_xlat16_2 + u_xlat1;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD5.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat1 = u_xlat16_1 * _HorizonColor;
    SV_Target0.xyz = vec3(u_xlat15) * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD3 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	float _ReflDistort;
uniform 	float _RefrDistort;
uniform 	vec4 _RefrColor;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Fresnel;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD3.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = log2(u_xlat15);
    u_xlat1.x = exp2(_Gloss);
    u_xlat6 = u_xlat1.x * _SpecFinal;
    u_xlat15 = u_xlat15 * u_xlat6;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = u_xlat1.x * u_xlat15;
    u_xlat16_2.x = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat10_0 = texture2D(_Fresnel, u_xlat16_2.xx).w;
    u_xlat5.xy = u_xlat16_3.xy * vec2(_ReflDistort) + vs_TEXCOORD0.xy;
    u_xlat1.xy = (-u_xlat16_3.xy) * vec2(vec2(_RefrDistort, _RefrDistort)) + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture2D(_RefractionTex, u_xlat1.xy);
    u_xlat5.xy = u_xlat5.xy / vs_TEXCOORD0.ww;
    u_xlat10_2 = texture2D(_ReflectionTex, u_xlat5.xy);
    u_xlat16_2 = (-u_xlat10_1) * _RefrColor + u_xlat10_2;
    u_xlat1 = u_xlat10_1 * _RefrColor;
    u_xlat16_1 = vec4(u_xlat10_0) * u_xlat16_2 + u_xlat1;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD5.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat1 = u_xlat16_1 * _HorizonColor;
    SV_Target0.xyz = vec3(u_xlat15) * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD3 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	float _ReflDistort;
uniform 	float _RefrDistort;
uniform 	vec4 _RefrColor;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _RefractionTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Fresnel;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD3.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = log2(u_xlat15);
    u_xlat1.x = exp2(_Gloss);
    u_xlat6 = u_xlat1.x * _SpecFinal;
    u_xlat15 = u_xlat15 * u_xlat6;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = u_xlat1.x * u_xlat15;
    u_xlat16_2.x = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat10_0 = texture2D(_Fresnel, u_xlat16_2.xx).w;
    u_xlat5.xy = u_xlat16_3.xy * vec2(_ReflDistort) + vs_TEXCOORD0.xy;
    u_xlat1.xy = (-u_xlat16_3.xy) * vec2(vec2(_RefrDistort, _RefrDistort)) + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture2D(_RefractionTex, u_xlat1.xy);
    u_xlat5.xy = u_xlat5.xy / vs_TEXCOORD0.ww;
    u_xlat10_2 = texture2D(_ReflectionTex, u_xlat5.xy);
    u_xlat16_2 = (-u_xlat10_1) * _RefrColor + u_xlat10_2;
    u_xlat1 = u_xlat10_1 * _RefrColor;
    u_xlat16_1 = vec4(u_xlat10_0) * u_xlat16_2 + u_xlat1;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD5.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat10_2;
    u_xlat1 = u_xlat16_1 * _HorizonColor;
    SV_Target0.xyz = vec3(u_xlat15) * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD3 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	float _ReflDistort;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectiveColor;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat15;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD3.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = log2(u_xlat15);
    u_xlat1.x = exp2(_Gloss);
    u_xlat6 = u_xlat1.x * _SpecFinal;
    u_xlat15 = u_xlat15 * u_xlat6;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = u_xlat1.x * u_xlat15;
    u_xlat16_2.x = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat0.xy = u_xlat16_3.xy * vec2(_ReflDistort) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture2D(_ReflectionTex, u_xlat0.xy);
    u_xlat10_2 = texture2D(_ReflectiveColor, u_xlat16_2.xx);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * _HorizonColor.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * _HorizonColor.xyz;
    SV_Target0.w = u_xlat10_1.w * u_xlat10_2.w;
    u_xlat16 = u_xlat10_2.w * _HorizonColor.w;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat15) * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD3 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	float _ReflDistort;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectiveColor;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat15;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD3.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = log2(u_xlat15);
    u_xlat1.x = exp2(_Gloss);
    u_xlat6 = u_xlat1.x * _SpecFinal;
    u_xlat15 = u_xlat15 * u_xlat6;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = u_xlat1.x * u_xlat15;
    u_xlat16_2.x = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat0.xy = u_xlat16_3.xy * vec2(_ReflDistort) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture2D(_ReflectionTex, u_xlat0.xy);
    u_xlat10_2 = texture2D(_ReflectiveColor, u_xlat16_2.xx);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * _HorizonColor.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * _HorizonColor.xyz;
    SV_Target0.w = u_xlat10_1.w * u_xlat10_2.w;
    u_xlat16 = u_xlat10_2.w * _HorizonColor.w;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat15) * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD3 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	float _ReflDistort;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _ReflectionTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectiveColor;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat15;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD3.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD3.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = log2(u_xlat15);
    u_xlat1.x = exp2(_Gloss);
    u_xlat6 = u_xlat1.x * _SpecFinal;
    u_xlat15 = u_xlat15 * u_xlat6;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = u_xlat1.x * u_xlat15;
    u_xlat16_2.x = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat0.xy = u_xlat16_3.xy * vec2(_ReflDistort) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
    u_xlat10_1 = texture2D(_ReflectionTex, u_xlat0.xy);
    u_xlat10_2 = texture2D(_ReflectiveColor, u_xlat16_2.xx);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * _HorizonColor.xyz + u_xlat10_1.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz * _HorizonColor.xyz;
    SV_Target0.w = u_xlat10_1.w * u_xlat10_2.w;
    u_xlat16 = u_xlat10_2.w * _HorizonColor.w;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat15) * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "WATER_SIMPLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD0 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectiveColor;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
float u_xlat11;
float u_xlat15;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_17 = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat10_0 = texture2D(_ReflectiveColor, vec2(u_xlat16_17));
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat6.x = exp2(_Gloss);
    u_xlat11 = u_xlat6.x * _SpecFinal;
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat15 = u_xlat10_0.w * _HorizonColor.w;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD5.xy);
    u_xlat6.xyz = u_xlat10_2.xyz * _HorizonColor.xyz + (-u_xlat10_0.xyz);
    u_xlat4.x = u_xlat10_2.w * _HorizonColor.w;
    SV_Target0.w = u_xlat4.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat6.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat1.xxx * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "WATER_SIMPLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD0 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectiveColor;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
float u_xlat11;
float u_xlat15;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_17 = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat10_0 = texture2D(_ReflectiveColor, vec2(u_xlat16_17));
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat6.x = exp2(_Gloss);
    u_xlat11 = u_xlat6.x * _SpecFinal;
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat15 = u_xlat10_0.w * _HorizonColor.w;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD5.xy);
    u_xlat6.xyz = u_xlat10_2.xyz * _HorizonColor.xyz + (-u_xlat10_0.xyz);
    u_xlat4.x = u_xlat10_2.w * _HorizonColor.w;
    SV_Target0.w = u_xlat4.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat6.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat1.xxx * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "WATER_SIMPLE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WaveScale4;
uniform 	vec4 _WaveOffset;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD0 = u_xlat0.xzzx * _WaveScale4.xywz + _WaveOffset.xywz;
    vs_TEXCOORD4 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	vec4 _lightpos;
uniform 	vec4 _HorizonColor;
uniform lowp sampler2D _BumpMap;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectiveColor;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat6;
float u_xlat11;
float u_xlat15;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = _lightpos.www * (-vs_TEXCOORD4.xyz) + _lightpos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat16_17 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_2.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat10_1.xyz = texture2D(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_3.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + vs_NORMAL0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_17 = dot(u_xlat0.xzy, u_xlat16_3.xyz);
    u_xlat10_0 = texture2D(_ReflectiveColor, vec2(u_xlat16_17));
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(u_xlat1.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat6.x = exp2(_Gloss);
    u_xlat11 = u_xlat6.x * _SpecFinal;
    u_xlat1.x = u_xlat1.x * u_xlat11;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat15 = u_xlat10_0.w * _HorizonColor.w;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD5.xy);
    u_xlat6.xyz = u_xlat10_2.xyz * _HorizonColor.xyz + (-u_xlat10_0.xyz);
    u_xlat4.x = u_xlat10_2.w * _HorizonColor.w;
    SV_Target0.w = u_xlat4.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat6.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat1.xxx * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "WATER_REFRACTIVE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "WATER_REFRACTIVE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "WATER_REFRACTIVE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "WATER_REFLECTIVE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "WATER_REFLECTIVE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "WATER_REFLECTIVE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "WATER_SIMPLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "WATER_SIMPLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "WATER_SIMPLE" }
""
}
}
}
}
}