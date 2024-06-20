//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/Wave" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Albedo (RGB)", 2D) = "white" { }
_Noise ("Noise", 2D) = "white" { }
_MaskTex ("MaskTex", 2D) = "white" { }
_Glossiness ("Smoothness", Range(0, 1)) = 0.5
_Metallic ("Metallic", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  GpuProgramID 1040
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat13;
mediump vec3 u_xlat16_18;
float u_xlat33;
lowp float u_xlat10_33;
mediump float u_xlat16_34;
float u_xlat35;
mediump float u_xlat16_36;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat2.z = (-_Glossiness) + 1.0;
    u_xlat16_34 = (-u_xlat2.z) * 0.699999988 + 1.70000005;
    u_xlat16_34 = u_xlat16_34 * u_xlat2.z;
    u_xlat16_34 = u_xlat16_34 * 6.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_1.xyz, u_xlat16_34);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xxx;
    u_xlat33 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_4.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_5.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat13 = u_xlat10_4.x + u_xlat10_5.z;
    u_xlat33 = u_xlat33 * 0.100000001 + u_xlat13;
    u_xlat33 = u_xlat33 + _Time.y;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat13 = (-u_xlat10_4.y) + u_xlat10_4.z;
    u_xlat13 = u_xlat33 * u_xlat13 + u_xlat10_4.y;
    u_xlat35 = (-u_xlat10_5.x) + u_xlat10_5.y;
    u_xlat33 = u_xlat33 * u_xlat35 + u_xlat10_5.x;
    u_xlat33 = u_xlat33 + u_xlat13;
    u_xlat33 = u_xlat33 + -0.75;
    u_xlat33 = u_xlat33 * 0.800000012;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat13 = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat13 * u_xlat33 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat33) * u_xlat10_1;
    u_xlat10_33 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_6.xyz = u_xlat1.xyz * vec3(u_xlat10_33) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_33) * u_xlat1;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_36 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_39 = (-u_xlat16_36) + 1.0;
    u_xlat16_7.x = u_xlat16_39 + _Glossiness;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    SV_Target0.w = u_xlat1.w * u_xlat16_36 + u_xlat16_39;
    u_xlat16_18.xyz = u_xlat1.xyz * vec3(u_xlat16_36);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xxx;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat13 = u_xlat33;
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat2.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat2.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_10.xyz = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat16_7.xyz = u_xlat16_18.xyz * u_xlat1.www + u_xlat16_10.xyz;
    u_xlat16_36 = (-u_xlat13) + 1.0;
    u_xlat0.x = u_xlat16_36 * u_xlat16_36;
    u_xlat0.x = u_xlat16_36 * u_xlat0.x;
    u_xlat0.x = u_xlat16_36 * u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz + u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_10;
float u_xlat12;
float u_xlat14;
float u_xlat22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_7.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat7.x = u_xlat10_7.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat7.x = (-u_xlat10_7.y) + u_xlat10_7.z;
    u_xlat7.x = u_xlat0.x * u_xlat7.x + u_xlat10_7.y;
    u_xlat14 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat14 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat7.x * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.x = (-u_xlat16_23) + 1.0;
    u_xlat16_10 = u_xlat16_3.x + _Glossiness;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    SV_Target0.w = u_xlat0.w * u_xlat16_23 + u_xlat16_3.x;
    u_xlat16_3.xzw = u_xlat0.xyz * vec3(u_xlat16_23);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_10);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22) + _WorldSpaceLightPos0.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat22) + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_4.xyz = vec3(u_xlat16_23) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_23 = dot((-u_xlat5.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_23;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_23)) + (-u_xlat5.xyz);
    u_xlat22 = (-_Glossiness) + 1.0;
    u_xlat16_23 = (-u_xlat22) * 0.699999988 + 1.70000005;
    u_xlat16_23 = u_xlat22 * u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * 6.0;
    u_xlat10_5 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_6.xyz, u_xlat16_23);
    u_xlat16_23 = u_xlat10_5.w + -1.0;
    u_xlat16_23 = unity_SpecCube0_HDR.w * u_xlat16_23 + 1.0;
    u_xlat16_23 = u_xlat16_23 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_5.xyz * vec3(u_xlat16_23);
    u_xlat5.x = u_xlat22 * u_xlat22;
    u_xlat16_23 = u_xlat22 * u_xlat5.x;
    u_xlat22 = u_xlat22 * u_xlat22 + 1.5;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_23);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * u_xlat1.x;
    u_xlat14 = max(u_xlat12, 0.319999993);
    u_xlat14 = u_xlat22 * u_xlat14;
    u_xlat1.x = u_xlat5.x * u_xlat5.x + -1.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.00001001;
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat7.x = u_xlat5.x / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -9.99999975e-05;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 100.0);
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat7.xxx;
    u_xlat7.xyz = u_xlat16_3.xzw * u_xlat0.www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xxx + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec4 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
mediump float u_xlat16_10;
float u_xlat12;
float u_xlat14;
float u_xlat22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_7.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat7.x = u_xlat10_7.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat7.x = (-u_xlat10_7.y) + u_xlat10_7.z;
    u_xlat7.x = u_xlat0.x * u_xlat7.x + u_xlat10_7.y;
    u_xlat14 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat14 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat7.x;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat7.x * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.x = (-u_xlat16_23) + 1.0;
    u_xlat16_10 = u_xlat16_3.x + _Glossiness;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    SV_Target0.w = u_xlat0.w * u_xlat16_23 + u_xlat16_3.x;
    u_xlat16_3.xzw = u_xlat0.xyz * vec3(u_xlat16_23);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_10);
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat5.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22) + _WorldSpaceLightPos0.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat22) + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_4.xyz = vec3(u_xlat16_23) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_23 = dot((-u_xlat5.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_23;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_23)) + (-u_xlat5.xyz);
    u_xlat22 = (-_Glossiness) + 1.0;
    u_xlat16_23 = (-u_xlat22) * 0.699999988 + 1.70000005;
    u_xlat16_23 = u_xlat22 * u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * 6.0;
    u_xlat10_5 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_6.xyz, u_xlat16_23);
    u_xlat16_23 = u_xlat10_5.w + -1.0;
    u_xlat16_23 = unity_SpecCube0_HDR.w * u_xlat16_23 + 1.0;
    u_xlat16_23 = u_xlat16_23 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat10_5.xyz * vec3(u_xlat16_23);
    u_xlat5.x = u_xlat22 * u_xlat22;
    u_xlat16_23 = u_xlat22 * u_xlat5.x;
    u_xlat22 = u_xlat22 * u_xlat22 + 1.5;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_23);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * u_xlat1.x;
    u_xlat14 = max(u_xlat12, 0.319999993);
    u_xlat14 = u_xlat22 * u_xlat14;
    u_xlat1.x = u_xlat5.x * u_xlat5.x + -1.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.00001001;
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat7.x = u_xlat5.x / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -9.99999975e-05;
    u_xlat7.x = max(u_xlat7.x, 0.0);
    u_xlat7.x = min(u_xlat7.x, 100.0);
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat7.xxx;
    u_xlat7.xyz = u_xlat16_3.xzw * u_xlat0.www + u_xlat1.xyz;
    u_xlat7.xyz = u_xlat7.xyz * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xxx + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat15;
mediump vec3 u_xlat16_20;
float u_xlat36;
lowp float u_xlat10_36;
mediump float u_xlat16_37;
float u_xlat38;
mediump float u_xlat16_40;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat2.xyz = vec3(u_xlat36) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat3.z = (-_Glossiness) + 1.0;
    u_xlat16_37 = (-u_xlat3.z) * 0.699999988 + 1.70000005;
    u_xlat16_37 = u_xlat16_37 * u_xlat3.z;
    u_xlat16_37 = u_xlat16_37 * 6.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_1.xyz, u_xlat16_37);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat36 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_5.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_6.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat38 = u_xlat10_5.x + u_xlat10_6.z;
    u_xlat36 = u_xlat36 * 0.100000001 + u_xlat38;
    u_xlat36 = u_xlat36 + _Time.y;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * u_xlat36;
    u_xlat38 = (-u_xlat10_5.y) + u_xlat10_5.z;
    u_xlat38 = u_xlat36 * u_xlat38 + u_xlat10_5.y;
    u_xlat15 = (-u_xlat10_6.x) + u_xlat10_6.y;
    u_xlat36 = u_xlat36 * u_xlat15 + u_xlat10_6.x;
    u_xlat36 = u_xlat36 + u_xlat38;
    u_xlat36 = u_xlat36 + -0.75;
    u_xlat36 = u_xlat36 * 0.800000012;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat38 = u_xlat36 * -2.0 + 3.0;
    u_xlat36 = u_xlat36 * u_xlat36;
    u_xlat36 = u_xlat38 * u_xlat36 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat36) * u_xlat10_1;
    u_xlat10_36 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_7.xyz = u_xlat1.xyz * vec3(u_xlat10_36) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_36) * u_xlat1;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_40 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_40) + 1.0;
    u_xlat16_8 = u_xlat16_43 + _Glossiness;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    SV_Target0.w = u_xlat1.w * u_xlat16_40 + u_xlat16_43;
    u_xlat16_20.xyz = u_xlat1.xyz * vec3(u_xlat16_40);
    u_xlat16_20.xyz = u_xlat1.www * u_xlat16_20.xyz;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_8);
    u_xlat36 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat5.xyz = vec3(u_xlat36) * vs_TEXCOORD1.xyz;
    u_xlat36 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat38 = u_xlat36;
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat2.xyz = u_xlat5.xyz * (-vec3(u_xlat36)) + u_xlat2.xyz;
    u_xlat36 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat36 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = u_xlat36 * u_xlat36;
    u_xlat3.x = u_xlat36 * u_xlat36;
    u_xlat36 = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat36 = u_xlat36 * 16.0;
    u_xlat16_11.xyz = vec3(u_xlat36) * u_xlat16_7.xyz + u_xlat16_20.xyz;
    u_xlat16_40 = (-u_xlat38) + 1.0;
    u_xlat36 = u_xlat16_40 * u_xlat16_40;
    u_xlat36 = u_xlat16_40 * u_xlat36;
    u_xlat36 = u_xlat16_40 * u_xlat36;
    u_xlat16_7.xyz = vec3(u_xlat36) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_20.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat9;
vec3 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat21 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_3.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat2.x = u_xlat10_2.x + u_xlat10_3.z;
    u_xlat21 = u_xlat21 * 0.100000001 + u_xlat2.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat10_2.y;
    u_xlat9 = (-u_xlat10_3.x) + u_xlat10_3.y;
    u_xlat21 = u_xlat21 * u_xlat9 + u_xlat10_3.x;
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = u_xlat21 + -0.75;
    u_xlat21 = u_xlat21 * 0.800000012;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.x = u_xlat21 * -2.0 + 3.0;
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat2.x * u_xlat21 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat21) * u_xlat10_1;
    u_xlat10_21 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = vec4(u_xlat10_21) * u_xlat1;
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(u_xlat10_21) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat2.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat3 = (-_Glossiness) + 1.0;
    u_xlat10.x = u_xlat3 * u_xlat3 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat10.x;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat9 = u_xlat3 * u_xlat3;
    u_xlat16 = u_xlat9 * u_xlat9 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat2.x;
    u_xlat21 = u_xlat9 / u_xlat21;
    u_xlat16_26 = u_xlat3 * u_xlat9;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + u_xlat16_6.xyz;
    u_xlat16_12 = (-u_xlat16_25) + 1.0;
    SV_Target0.w = u_xlat2.w * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = u_xlat16_12 + _Glossiness;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_25 = (-u_xlat3) * 0.699999988 + 1.70000005;
    u_xlat16_25 = u_xlat3 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_25 * 6.0;
    u_xlat16_5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_5.xyz, u_xlat16_25);
    u_xlat16_25 = u_xlat10_0.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat9;
vec3 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat21 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_3.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat2.x = u_xlat10_2.x + u_xlat10_3.z;
    u_xlat21 = u_xlat21 * 0.100000001 + u_xlat2.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat10_2.y;
    u_xlat9 = (-u_xlat10_3.x) + u_xlat10_3.y;
    u_xlat21 = u_xlat21 * u_xlat9 + u_xlat10_3.x;
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = u_xlat21 + -0.75;
    u_xlat21 = u_xlat21 * 0.800000012;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.x = u_xlat21 * -2.0 + 3.0;
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat2.x * u_xlat21 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat21) * u_xlat10_1;
    u_xlat10_21 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = vec4(u_xlat10_21) * u_xlat1;
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(u_xlat10_21) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat2.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat3 = (-_Glossiness) + 1.0;
    u_xlat10.x = u_xlat3 * u_xlat3 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat10.x;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat9 = u_xlat3 * u_xlat3;
    u_xlat16 = u_xlat9 * u_xlat9 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat2.x;
    u_xlat21 = u_xlat9 / u_xlat21;
    u_xlat16_26 = u_xlat3 * u_xlat9;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + u_xlat16_6.xyz;
    u_xlat16_12 = (-u_xlat16_25) + 1.0;
    SV_Target0.w = u_xlat2.w * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = u_xlat16_12 + _Glossiness;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_25 = (-u_xlat3) * 0.699999988 + 1.70000005;
    u_xlat16_25 = u_xlat3 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_25 * 6.0;
    u_xlat16_5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_5.xyz, u_xlat16_25);
    u_xlat16_25 = u_xlat10_0.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat15;
mediump vec3 u_xlat16_20;
float u_xlat36;
lowp float u_xlat10_36;
mediump float u_xlat16_37;
float u_xlat38;
mediump float u_xlat16_40;
mediump float u_xlat16_43;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat2.xyz = vec3(u_xlat36) * u_xlat2.xyz;
    u_xlat16_1.x = dot((-u_xlat2.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat2.xyz);
    u_xlat3.z = (-_Glossiness) + 1.0;
    u_xlat16_37 = (-u_xlat3.z) * 0.699999988 + 1.70000005;
    u_xlat16_37 = u_xlat16_37 * u_xlat3.z;
    u_xlat16_37 = u_xlat16_37 * 6.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_1.xyz, u_xlat16_37);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat36 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_5.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_6.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat38 = u_xlat10_5.x + u_xlat10_6.z;
    u_xlat36 = u_xlat36 * 0.100000001 + u_xlat38;
    u_xlat36 = u_xlat36 + _Time.y;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * u_xlat36;
    u_xlat38 = (-u_xlat10_5.y) + u_xlat10_5.z;
    u_xlat38 = u_xlat36 * u_xlat38 + u_xlat10_5.y;
    u_xlat15 = (-u_xlat10_6.x) + u_xlat10_6.y;
    u_xlat36 = u_xlat36 * u_xlat15 + u_xlat10_6.x;
    u_xlat36 = u_xlat36 + u_xlat38;
    u_xlat36 = u_xlat36 + -0.75;
    u_xlat36 = u_xlat36 * 0.800000012;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat38 = u_xlat36 * -2.0 + 3.0;
    u_xlat36 = u_xlat36 * u_xlat36;
    u_xlat36 = u_xlat38 * u_xlat36 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat36) * u_xlat10_1;
    u_xlat10_36 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_7.xyz = u_xlat1.xyz * vec3(u_xlat10_36) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_36) * u_xlat1;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_40 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_43 = (-u_xlat16_40) + 1.0;
    u_xlat16_8 = u_xlat16_43 + _Glossiness;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    SV_Target0.w = u_xlat1.w * u_xlat16_40 + u_xlat16_43;
    u_xlat16_20.xyz = u_xlat1.xyz * vec3(u_xlat16_40);
    u_xlat16_20.xyz = u_xlat1.www * u_xlat16_20.xyz;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_8);
    u_xlat36 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat5.xyz = vec3(u_xlat36) * vs_TEXCOORD1.xyz;
    u_xlat36 = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat38 = u_xlat36;
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat2.xyz = u_xlat5.xyz * (-vec3(u_xlat36)) + u_xlat2.xyz;
    u_xlat36 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat36 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = u_xlat36 * u_xlat36;
    u_xlat3.x = u_xlat36 * u_xlat36;
    u_xlat36 = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat36 = u_xlat36 * 16.0;
    u_xlat16_11.xyz = vec3(u_xlat36) * u_xlat16_7.xyz + u_xlat16_20.xyz;
    u_xlat16_40 = (-u_xlat38) + 1.0;
    u_xlat36 = u_xlat16_40 * u_xlat16_40;
    u_xlat36 = u_xlat16_40 * u_xlat36;
    u_xlat36 = u_xlat16_40 * u_xlat36;
    u_xlat16_7.xyz = vec3(u_xlat36) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_20.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_11.xyz * u_xlat16_10.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat9;
vec3 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat21 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_3.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat2.x = u_xlat10_2.x + u_xlat10_3.z;
    u_xlat21 = u_xlat21 * 0.100000001 + u_xlat2.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat10_2.y;
    u_xlat9 = (-u_xlat10_3.x) + u_xlat10_3.y;
    u_xlat21 = u_xlat21 * u_xlat9 + u_xlat10_3.x;
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = u_xlat21 + -0.75;
    u_xlat21 = u_xlat21 * 0.800000012;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.x = u_xlat21 * -2.0 + 3.0;
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat2.x * u_xlat21 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat21) * u_xlat10_1;
    u_xlat10_21 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = vec4(u_xlat10_21) * u_xlat1;
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(u_xlat10_21) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat2.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat3 = (-_Glossiness) + 1.0;
    u_xlat10.x = u_xlat3 * u_xlat3 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat10.x;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat9 = u_xlat3 * u_xlat3;
    u_xlat16 = u_xlat9 * u_xlat9 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat2.x;
    u_xlat21 = u_xlat9 / u_xlat21;
    u_xlat16_26 = u_xlat3 * u_xlat9;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + u_xlat16_6.xyz;
    u_xlat16_12 = (-u_xlat16_25) + 1.0;
    SV_Target0.w = u_xlat2.w * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = u_xlat16_12 + _Glossiness;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_25 = (-u_xlat3) * 0.699999988 + 1.70000005;
    u_xlat16_25 = u_xlat3 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_25 * 6.0;
    u_xlat16_5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_5.xyz, u_xlat16_25);
    u_xlat16_25 = u_xlat10_0.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat9;
vec3 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat21 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_3.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat2.x = u_xlat10_2.x + u_xlat10_3.z;
    u_xlat21 = u_xlat21 * 0.100000001 + u_xlat2.x;
    u_xlat21 = u_xlat21 + _Time.y;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat2.x = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat2.x = u_xlat21 * u_xlat2.x + u_xlat10_2.y;
    u_xlat9 = (-u_xlat10_3.x) + u_xlat10_3.y;
    u_xlat21 = u_xlat21 * u_xlat9 + u_xlat10_3.x;
    u_xlat21 = u_xlat21 + u_xlat2.x;
    u_xlat21 = u_xlat21 + -0.75;
    u_xlat21 = u_xlat21 * 0.800000012;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.x = u_xlat21 * -2.0 + 3.0;
    u_xlat21 = u_xlat21 * u_xlat21;
    u_xlat21 = u_xlat2.x * u_xlat21 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat21) * u_xlat10_1;
    u_xlat10_21 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat2 = vec4(u_xlat10_21) * u_xlat1;
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(u_xlat10_21) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat2.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat3 = (-_Glossiness) + 1.0;
    u_xlat10.x = u_xlat3 * u_xlat3 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat10.x;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat9 = u_xlat3 * u_xlat3;
    u_xlat16 = u_xlat9 * u_xlat9 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat2.x;
    u_xlat21 = u_xlat9 / u_xlat21;
    u_xlat16_26 = u_xlat3 * u_xlat9;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat21 = dot(u_xlat10.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat10.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat21) + u_xlat16_6.xyz;
    u_xlat16_12 = (-u_xlat16_25) + 1.0;
    SV_Target0.w = u_xlat2.w * u_xlat16_25 + u_xlat16_12;
    u_xlat16_25 = u_xlat16_12 + _Glossiness;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_25);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_25 = (-u_xlat3) * 0.699999988 + 1.70000005;
    u_xlat16_25 = u_xlat3 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_25 * 6.0;
    u_xlat16_5.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_5.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat16_5.xyz, u_xlat16_25);
    u_xlat16_25 = u_xlat10_0.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_0.xyz * vec3(u_xlat16_25);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_26);
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  ColorMask RGB 0
  ZWrite Off
  GpuProgramID 129066
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
lowp vec3 u_xlat10_6;
float u_xlat7;
float u_xlat12;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_6.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat6 = u_xlat10_6.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat6;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = (-u_xlat10_6.y) + u_xlat10_6.z;
    u_xlat6 = u_xlat0.x * u_xlat6 + u_xlat10_6.y;
    u_xlat12 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat19 = u_xlat19 + u_xlat19;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat3.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat0.www + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xx).x;
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat7) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_2.x = (-u_xlat16_20) + 1.0;
    SV_Target0.w = u_xlat0.w * u_xlat16_20 + u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat13 = (-_Glossiness) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat13 + 1.5;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat2.x;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat13 * u_xlat13 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat13 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5 + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = texture2D(_LightTexture0, u_xlat1.xx).x;
    u_xlat16_7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat13 = (-_Glossiness) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat13 + 1.5;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat2.x;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat13 * u_xlat13 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat13 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5 + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat1.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = texture2D(_LightTexture0, u_xlat1.xx).x;
    u_xlat16_7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
lowp vec3 u_xlat10_6;
float u_xlat12;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_6.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat6 = u_xlat10_6.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat6;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = (-u_xlat10_6.y) + u_xlat10_6.z;
    u_xlat6 = u_xlat0.x * u_xlat6 + u_xlat10_6.y;
    u_xlat12 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat19 = u_xlat19 + u_xlat19;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat19) * _LightColor0.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat0.www + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz;
    u_xlat16_2.x = (-u_xlat16_20) + 1.0;
    SV_Target0.w = u_xlat0.w * u_xlat16_20 + u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat1.x = (-_Glossiness) + 1.0;
    u_xlat5.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat12 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5.x = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5.x + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat1.x = (-_Glossiness) + 1.0;
    u_xlat5.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat12 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5.x = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5.x + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat7;
float u_xlat12;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_6.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat6 = u_xlat10_6.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat6;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = (-u_xlat10_6.y) + u_xlat10_6.z;
    u_xlat6 = u_xlat0.x * u_xlat6 + u_xlat10_6.y;
    u_xlat12 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat19 = u_xlat19 + u_xlat19;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat3.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat0.www + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xy).w;
    u_xlatb6 = 0.0<vs_TEXCOORD3.z;
    u_xlat16_5.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_5.x = u_xlat0.x * u_xlat16_5.x;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
    u_xlat16_5.x = u_xlat0.x * u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat7) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_2.x = (-u_xlat16_20) + 1.0;
    SV_Target0.w = u_xlat0.w * u_xlat16_20 + u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
float u_xlat7;
float u_xlat10;
lowp float u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xy).w;
    u_xlatb5 = 0.0<vs_TEXCOORD3.z;
    u_xlat16_1.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat17 = (-_Glossiness) + 1.0;
    u_xlat3.x = u_xlat17 * u_xlat17 + 1.5;
    u_xlat17 = u_xlat17 * u_xlat17;
    u_xlat15 = u_xlat15 * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat10 = u_xlat17 * u_xlat17 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = u_xlat17 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat10 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat2.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat2.zw = vs_TEXCOORD2.xy;
    u_xlat2 = u_xlat2.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_3.xyz = texture2D(_Noise, u_xlat2.xy).yzw;
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat2.zw).xyz;
    u_xlat15 = u_xlat10_2.z + u_xlat10_3.x;
    u_xlat10 = u_xlat10 * 0.100000001 + u_xlat15;
    u_xlat10 = u_xlat10 + _Time.y;
    u_xlat10 = sin(u_xlat10);
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat15 = (-u_xlat10_3.y) + u_xlat10_3.z;
    u_xlat15 = u_xlat10 * u_xlat15 + u_xlat10_3.y;
    u_xlat7 = (-u_xlat10_2.x) + u_xlat10_2.y;
    u_xlat10 = u_xlat10 * u_xlat7 + u_xlat10_2.x;
    u_xlat10 = u_xlat10 + u_xlat15;
    u_xlat10 = u_xlat10 + -0.75;
    u_xlat10 = u_xlat10 * 0.800000012;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat15 = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat15 * u_xlat10 + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat10) * u_xlat10_2;
    u_xlat10_10 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat10_10) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat2 = vec4(u_xlat10_10) * u_xlat2;
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_16 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = vec3(u_xlat16_16) * u_xlat2.xyz;
    u_xlat0.xzw = u_xlat16_4.xyz * u_xlat2.www + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat0.xzw;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_1.x = (-u_xlat16_16) + 1.0;
    SV_Target0.w = u_xlat2.w * u_xlat16_16 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D _LightTextureB0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
float u_xlat7;
float u_xlat10;
lowp float u_xlat10_10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat0.x = texture2D(_LightTexture0, u_xlat0.xy).w;
    u_xlatb5 = 0.0<vs_TEXCOORD3.z;
    u_xlat16_1.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = max(u_xlat15, 0.00100000005);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat15 = max(u_xlat15, 0.319999993);
    u_xlat17 = (-_Glossiness) + 1.0;
    u_xlat3.x = u_xlat17 * u_xlat17 + 1.5;
    u_xlat17 = u_xlat17 * u_xlat17;
    u_xlat15 = u_xlat15 * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat10 = u_xlat17 * u_xlat17 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat15;
    u_xlat0.x = u_xlat17 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat10 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat2.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat2.zw = vs_TEXCOORD2.xy;
    u_xlat2 = u_xlat2.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_3.xyz = texture2D(_Noise, u_xlat2.xy).yzw;
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat2.zw).xyz;
    u_xlat15 = u_xlat10_2.z + u_xlat10_3.x;
    u_xlat10 = u_xlat10 * 0.100000001 + u_xlat15;
    u_xlat10 = u_xlat10 + _Time.y;
    u_xlat10 = sin(u_xlat10);
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat15 = (-u_xlat10_3.y) + u_xlat10_3.z;
    u_xlat15 = u_xlat10 * u_xlat15 + u_xlat10_3.y;
    u_xlat7 = (-u_xlat10_2.x) + u_xlat10_2.y;
    u_xlat10 = u_xlat10 * u_xlat7 + u_xlat10_2.x;
    u_xlat10 = u_xlat10 + u_xlat15;
    u_xlat10 = u_xlat10 + -0.75;
    u_xlat10 = u_xlat10 * 0.800000012;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat15 = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat15 * u_xlat10 + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = vec4(u_xlat10) * u_xlat10_2;
    u_xlat10_10 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat10_10) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat2 = vec4(u_xlat10_10) * u_xlat2;
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_16 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = vec3(u_xlat16_16) * u_xlat2.xyz;
    u_xlat0.xzw = u_xlat16_4.xyz * u_xlat2.www + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat0.xzw;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_1.x = (-u_xlat16_16) + 1.0;
    SV_Target0.w = u_xlat2.w * u_xlat16_16 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat6;
lowp vec3 u_xlat10_6;
float u_xlat7;
float u_xlat12;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_6.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat6 = u_xlat10_6.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat6;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = (-u_xlat10_6.y) + u_xlat10_6.z;
    u_xlat6 = u_xlat0.x * u_xlat6 + u_xlat10_6.y;
    u_xlat12 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat19 = u_xlat19 + u_xlat19;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat3.x = u_xlat1.x * u_xlat1.x;
    u_xlat3.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat3.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat16_20);
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat0.www + u_xlat16_2.xyz;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = texture2D(_LightTextureB0, u_xlat0.xx).x;
    u_xlat6 = textureCube(_LightTexture0, vs_TEXCOORD3.xyz).w;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat7) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_2.x = (-u_xlat16_20) + 1.0;
    SV_Target0.w = u_xlat0.w * u_xlat16_20 + u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat13 = (-_Glossiness) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat13 + 1.5;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat2.x;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat13 * u_xlat13 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat13 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5 + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = texture2D(_LightTextureB0, u_xlat1.xx).x;
    u_xlat5 = textureCube(_LightTexture0, vs_TEXCOORD3.xyz).w;
    u_xlat1.x = u_xlat5 * u_xlat1.x;
    u_xlat16_7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTextureB0;
uniform highp samplerCube _LightTexture0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat13 = (-_Glossiness) + 1.0;
    u_xlat2.x = u_xlat13 * u_xlat13 + 1.5;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat2.x;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat13 * u_xlat13 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat13 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5 + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = texture2D(_LightTextureB0, u_xlat1.xx).x;
    u_xlat5 = textureCube(_LightTexture0, vs_TEXCOORD3.xyz).w;
    u_xlat1.x = u_xlat5 * u_xlat1.x;
    u_xlat16_7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
    vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat10;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_5.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat5 = u_xlat10_5.x + u_xlat10_1.z;
    u_xlat0.x = u_xlat0.x * 0.100000001 + u_xlat5;
    u_xlat0.x = u_xlat0.x + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5 = (-u_xlat10_5.y) + u_xlat10_5.z;
    u_xlat5 = u_xlat0.x * u_xlat5 + u_xlat10_5.y;
    u_xlat10 = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat10_1.x;
    u_xlat0.x = u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + -0.75;
    u_xlat0.x = u_xlat0.x * 0.800000012;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat5 * u_xlat0.x + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat0.xxxx * u_xlat10_1;
    u_xlat10_1.x = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xxx + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat0 = u_xlat0 * u_xlat10_1.xxxx;
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * vs_TEXCOORD1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat16 = u_xlat16 + u_xlat16;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat16)) + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.y = (-_Glossiness) + 1.0;
    u_xlat1.x = texture2D(unity_NHxRoughness, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
    u_xlat16_17 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xyz * vec3(u_xlat16_17);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat0.www + u_xlat16_2.xyz;
    u_xlat0.x = texture2D(_LightTexture0, vs_TEXCOORD3.xy).w;
    u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16) * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = (-u_xlat16_17) + 1.0;
    SV_Target0.w = u_xlat0.w * u_xlat16_17 + u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
    vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat1.x = (-_Glossiness) + 1.0;
    u_xlat5.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat12 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5.x = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5.x + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat1.x = texture2D(_LightTexture0, vs_TEXCOORD3.xy).w;
    u_xlat16_7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
    vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Glossiness;
uniform 	mediump float _Metallic;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _LightTexture0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat1.x = (-_Glossiness) + 1.0;
    u_xlat5.x = u_xlat1.x * u_xlat1.x + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat12 = u_xlat12 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat8 = vs_TEXCOORD2.y + vs_TEXCOORD2.x;
    u_xlat1.xy = vs_TEXCOORD2.yx + _Time.yy;
    u_xlat1.zw = vs_TEXCOORD2.xy;
    u_xlat1 = u_xlat1.zxyw * vec4(0.0250000004, 0.0250000004, 0.0250000004, 0.0250000004);
    u_xlat10_2.xyz = texture2D(_Noise, u_xlat1.xy).yzw;
    u_xlat10_1.xyz = texture2D(_Noise, u_xlat1.zw).xyz;
    u_xlat12 = u_xlat10_1.z + u_xlat10_2.x;
    u_xlat8 = u_xlat8 * 0.100000001 + u_xlat12;
    u_xlat8 = u_xlat8 + _Time.y;
    u_xlat8 = sin(u_xlat8);
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat12 = (-u_xlat10_2.y) + u_xlat10_2.z;
    u_xlat12 = u_xlat8 * u_xlat12 + u_xlat10_2.y;
    u_xlat5.x = (-u_xlat10_1.x) + u_xlat10_1.y;
    u_xlat8 = u_xlat8 * u_xlat5.x + u_xlat10_1.x;
    u_xlat8 = u_xlat8 + u_xlat12;
    u_xlat8 = u_xlat8 + -0.75;
    u_xlat8 = u_xlat8 * 0.800000012;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat12 = u_xlat8 * -2.0 + 3.0;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat8 = u_xlat12 * u_xlat8 + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vec4(u_xlat8) * u_xlat10_1;
    u_xlat10_8 = texture2D(_MaskTex, vs_TEXCOORD0.xy).x;
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(u_xlat10_8) + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat1 = vec4(u_xlat10_8) * u_xlat1;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat1.www + u_xlat0.xzw;
    u_xlat1.x = texture2D(_LightTexture0, vs_TEXCOORD3.xy).w;
    u_xlat16_7.xyz = u_xlat1.xxx * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat1.w * u_xlat16_3.x + u_xlat16_7.x;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
}
Fallback "Diffuse"
}