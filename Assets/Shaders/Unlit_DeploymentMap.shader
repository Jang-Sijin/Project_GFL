//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/DeploymentMap" {
Properties {
_MainTex ("主纹理 (RGB)", any) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Specular ("高光贴图", 2D) = "white" { }
_SpeRange ("高光范围", Float) = 1
_specularColor ("高光颜色", Color) = (1,1,1,1)
_specularPower ("高光强度", Range(0, 1)) = 0
_SpecLightDirectionX ("高光模拟灯光方向X", Range(-1, 1)) = 0
_SpecLightDirectionY ("高光模拟灯光方向Y", Range(-1, 1)) = 0
_SpecLightDirectionZ ("高光模拟灯光方向Z", Range(-1, 1)) = -1
_bump ("法线贴图", 2D) = "bump" { }
_BunpZ ("法线深度调节", Float) = 0
_HeighMap ("视差贴图", 2D) = "black" { }
_Height ("视差深度", Range(0, 0.08)) = 0.02
}
SubShader {
 Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Overlay" "RenderType" = "Opaque" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Overlay" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 15213
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_TANGENT0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _BunpZ;
uniform 	mediump float _SpeRange;
uniform 	mediump vec4 _specularColor;
uniform 	float _specularPower;
uniform 	mediump float _SpecLightDirectionX;
uniform 	mediump float _SpecLightDirectionY;
uniform 	mediump float _SpecLightDirectionZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _Specular;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat16_2.xyz);
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat10_3.xyz = texture2D(_bump, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.w = u_xlat16_3.z * _BunpZ;
    u_xlat16_2.y = dot(u_xlat16_2.xyz, u_xlat16_3.xyw);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_3.xyw);
    u_xlat16_2.z = dot(u_xlat0.xyz, u_xlat16_3.xyw);
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_20 = dot(vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ), vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ));
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_4.xyz = vec3(u_xlat16_20) * vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ);
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat16_4.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = u_xlat16_20 * 0.5 + 0.5;
    u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_8 = exp2(_SpeRange);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _SpeRange;
    u_xlat10_0.xyz = texture2D(_Specular, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _specularColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_specularPower);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat1 = u_xlat1 * _Color;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_20) + u_xlat0.xyz;
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
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_TANGENT0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _BunpZ;
uniform 	mediump float _SpeRange;
uniform 	mediump vec4 _specularColor;
uniform 	float _specularPower;
uniform 	mediump float _SpecLightDirectionX;
uniform 	mediump float _SpecLightDirectionY;
uniform 	mediump float _SpecLightDirectionZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _Specular;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat16_2.xyz);
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat10_3.xyz = texture2D(_bump, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.w = u_xlat16_3.z * _BunpZ;
    u_xlat16_2.y = dot(u_xlat16_2.xyz, u_xlat16_3.xyw);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_3.xyw);
    u_xlat16_2.z = dot(u_xlat0.xyz, u_xlat16_3.xyw);
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_20 = dot(vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ), vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ));
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_4.xyz = vec3(u_xlat16_20) * vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ);
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat16_4.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = u_xlat16_20 * 0.5 + 0.5;
    u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_8 = exp2(_SpeRange);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _SpeRange;
    u_xlat10_0.xyz = texture2D(_Specular, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _specularColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_specularPower);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat1 = u_xlat1 * _Color;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_20) + u_xlat0.xyz;
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
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec3 in_TANGENT0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_TANGENT0.xyz = in_TANGENT0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _BunpZ;
uniform 	mediump float _SpeRange;
uniform 	mediump vec4 _specularColor;
uniform 	float _specularPower;
uniform 	mediump float _SpecLightDirectionX;
uniform 	mediump float _SpecLightDirectionY;
uniform 	mediump float _SpecLightDirectionZ;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _Specular;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat16_2.xyz);
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat10_3.xyz = texture2D(_bump, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.w = u_xlat16_3.z * _BunpZ;
    u_xlat16_2.y = dot(u_xlat16_2.xyz, u_xlat16_3.xyw);
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_3.xyw);
    u_xlat16_2.z = dot(u_xlat0.xyz, u_xlat16_3.xyw);
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_20 = dot(vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ), vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ));
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_4.xyz = vec3(u_xlat16_20) * vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ);
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat16_4.xyz;
    u_xlat16_20 = dot(u_xlat16_4.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = u_xlat16_20 * 0.5 + 0.5;
    u_xlat16_4.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_8 = exp2(_SpeRange);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _SpeRange;
    u_xlat10_0.xyz = texture2D(_Specular, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _specularColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_specularPower);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat1 = u_xlat1 * _Color;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_20) + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
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