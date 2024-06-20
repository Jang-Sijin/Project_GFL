//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/DeploymentNightMap" {
Properties {
_MainTex ("Texture", any) = "" { }
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
_CloudTex ("云", 2D) = "black" { }
_CloudColor ("云彩颜色", Color) = (1,1,1,1)
_Direction ("风向", Vector) = (0.5,0.5,1,1)
_MoveSpeed ("高层云移动速度", Float) = 1
_Guodu ("黑天白天过渡", Range(0, 1)) = 0
_CloudPower ("云层浓度", Range(0, 1.5)) = 0
_RenderColor ("渲染颜色", Color) = (1,1,1,1)
_Compare ("光圈对比程度", Range(0.5, 1)) = 1
_high ("高度", Range(1, 3)) = 1
_show ("显示", Float) = 0
}
SubShader {
 Pass {
  Tags { "ForceSupported" = "true" "RenderType" = "Overlay" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Less
  ZWrite Off
  Cull Off
  GpuProgramID 53701
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
uniform 	vec4 _Time;
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
uniform 	float _high;
uniform 	vec3 _Direction;
uniform 	float _MoveSpeed;
uniform 	float _CloudPower;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _RenderColor;
uniform 	float _Guodu;
uniform 	float _Compare;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _Specular;
uniform lowp sampler2D _CloudTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
vec2 u_xlat18;
mediump vec2 u_xlat16_20;
vec2 u_xlat21;
mediump vec2 u_xlat16_22;
float u_xlat28;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = dot(_Direction.xxyz.yz, _Direction.xxyz.yz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _Direction.xxyz.yzyz;
    u_xlat0 = u_xlat0 * vec4(_MoveSpeed);
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_2.x = u_xlat1.z * u_xlat28 + 2.0;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_2.xy = u_xlat1.xy / u_xlat16_2.xx;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(10.0, 10.0);
    u_xlat16_20.xy = u_xlat16_2.xy * vec2(_high) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat16_2.xy * vec2(_high);
    u_xlat21.xy = u_xlat0.xy * _Time.xx + u_xlat16_20.xy;
    u_xlat0 = u_xlat0 * _Time.xxxx;
    u_xlat10_2 = texture2D(_CloudTex, u_xlat21.xy);
    u_xlat16_4 = vs_TEXCOORD0.xyxy * vec4(10.0, 10.0, 20.0, 20.0);
    u_xlat16_4.xy = u_xlat3.xy * vec2(2.0, 2.0) + u_xlat16_4.xy;
    u_xlat16_22.xy = u_xlat3.xy * vec2(4.0, 4.0) + u_xlat16_4.zw;
    u_xlat18.xy = u_xlat0.zw * vec2(8.0, 8.0) + u_xlat16_22.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0) + u_xlat16_4.xy;
    u_xlat10_3 = texture2D(_CloudTex, u_xlat0.xy);
    u_xlat3 = u_xlat10_3 * vec4(0.800000012, 0.800000012, 0.800000012, 0.800000012);
    u_xlat16_2 = max(u_xlat10_2, u_xlat3);
    u_xlat10_0 = texture2D(_CloudTex, u_xlat18.xy);
    u_xlat0 = u_xlat10_0 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_0 = max(u_xlat0, u_xlat16_2);
    u_xlat16_2 = (-vec4(vec4(_CloudPower, _CloudPower, _CloudPower, _CloudPower))) * u_xlat16_0 + _CloudColor;
    u_xlat0 = u_xlat16_0 * vec4(vec4(_CloudPower, _CloudPower, _CloudPower, _CloudPower));
    u_xlat16_4.x = u_xlat0.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat2 = u_xlat2 * _Color;
    u_xlat16_3 = (-u_xlat2) * vs_COLOR0 + u_xlat16_0;
    u_xlat16_2 = u_xlat2 * vs_COLOR0;
    u_xlat16_4.x = u_xlat16_0.x * u_xlat16_2.w;
    u_xlat16_3 = u_xlat16_4.xxxx * u_xlat16_3 + u_xlat16_2;
    u_xlat0 = u_xlat16_2 * u_xlat16_0 + (-u_xlat16_3);
    u_xlat0 = vec4(_Guodu) * u_xlat0 + u_xlat16_3;
    u_xlat0 = u_xlat0 * _RenderColor;
    u_xlat0 = u_xlat0 * vec4(vec4(_Compare, _Compare, _Compare, _Compare));
    u_xlat5.xyz = vs_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx;
    u_xlat16_4.xyz = u_xlat1.yzx * u_xlat5.zxy + (-u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat10_6.xyz = texture2D(_bump, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_6.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = u_xlat16_2.z * _BunpZ;
    u_xlat16_4.y = dot(u_xlat16_4.xyz, u_xlat16_2.xyw);
    u_xlat16_4.z = dot(u_xlat1.xyz, u_xlat16_2.xyw);
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat16_2.xyw);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_31 = dot(vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ), vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ));
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ);
    u_xlat16_8.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = u_xlat16_31 * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = dot(u_xlat16_4.xyz, u_xlat16_7.xyz);
    u_xlat16_4.x = min(abs(u_xlat16_4.x), 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_13 = exp2(_SpeRange);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _SpeRange;
    u_xlat10_1.xyz = texture2D(_Specular, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _specularColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(_specularPower);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_31) + u_xlat1.xyz;
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
uniform 	vec4 _Time;
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
uniform 	float _high;
uniform 	vec3 _Direction;
uniform 	float _MoveSpeed;
uniform 	float _CloudPower;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _RenderColor;
uniform 	float _Guodu;
uniform 	float _Compare;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _Specular;
uniform lowp sampler2D _CloudTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
vec2 u_xlat18;
mediump vec2 u_xlat16_20;
vec2 u_xlat21;
mediump vec2 u_xlat16_22;
float u_xlat28;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = dot(_Direction.xxyz.yz, _Direction.xxyz.yz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _Direction.xxyz.yzyz;
    u_xlat0 = u_xlat0 * vec4(_MoveSpeed);
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_2.x = u_xlat1.z * u_xlat28 + 2.0;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_2.xy = u_xlat1.xy / u_xlat16_2.xx;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(10.0, 10.0);
    u_xlat16_20.xy = u_xlat16_2.xy * vec2(_high) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat16_2.xy * vec2(_high);
    u_xlat21.xy = u_xlat0.xy * _Time.xx + u_xlat16_20.xy;
    u_xlat0 = u_xlat0 * _Time.xxxx;
    u_xlat10_2 = texture2D(_CloudTex, u_xlat21.xy);
    u_xlat16_4 = vs_TEXCOORD0.xyxy * vec4(10.0, 10.0, 20.0, 20.0);
    u_xlat16_4.xy = u_xlat3.xy * vec2(2.0, 2.0) + u_xlat16_4.xy;
    u_xlat16_22.xy = u_xlat3.xy * vec2(4.0, 4.0) + u_xlat16_4.zw;
    u_xlat18.xy = u_xlat0.zw * vec2(8.0, 8.0) + u_xlat16_22.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0) + u_xlat16_4.xy;
    u_xlat10_3 = texture2D(_CloudTex, u_xlat0.xy);
    u_xlat3 = u_xlat10_3 * vec4(0.800000012, 0.800000012, 0.800000012, 0.800000012);
    u_xlat16_2 = max(u_xlat10_2, u_xlat3);
    u_xlat10_0 = texture2D(_CloudTex, u_xlat18.xy);
    u_xlat0 = u_xlat10_0 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_0 = max(u_xlat0, u_xlat16_2);
    u_xlat16_2 = (-vec4(vec4(_CloudPower, _CloudPower, _CloudPower, _CloudPower))) * u_xlat16_0 + _CloudColor;
    u_xlat0 = u_xlat16_0 * vec4(vec4(_CloudPower, _CloudPower, _CloudPower, _CloudPower));
    u_xlat16_4.x = u_xlat0.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat2 = u_xlat2 * _Color;
    u_xlat16_3 = (-u_xlat2) * vs_COLOR0 + u_xlat16_0;
    u_xlat16_2 = u_xlat2 * vs_COLOR0;
    u_xlat16_4.x = u_xlat16_0.x * u_xlat16_2.w;
    u_xlat16_3 = u_xlat16_4.xxxx * u_xlat16_3 + u_xlat16_2;
    u_xlat0 = u_xlat16_2 * u_xlat16_0 + (-u_xlat16_3);
    u_xlat0 = vec4(_Guodu) * u_xlat0 + u_xlat16_3;
    u_xlat0 = u_xlat0 * _RenderColor;
    u_xlat0 = u_xlat0 * vec4(vec4(_Compare, _Compare, _Compare, _Compare));
    u_xlat5.xyz = vs_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx;
    u_xlat16_4.xyz = u_xlat1.yzx * u_xlat5.zxy + (-u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat10_6.xyz = texture2D(_bump, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_6.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = u_xlat16_2.z * _BunpZ;
    u_xlat16_4.y = dot(u_xlat16_4.xyz, u_xlat16_2.xyw);
    u_xlat16_4.z = dot(u_xlat1.xyz, u_xlat16_2.xyw);
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat16_2.xyw);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_31 = dot(vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ), vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ));
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ);
    u_xlat16_8.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = u_xlat16_31 * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = dot(u_xlat16_4.xyz, u_xlat16_7.xyz);
    u_xlat16_4.x = min(abs(u_xlat16_4.x), 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_13 = exp2(_SpeRange);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _SpeRange;
    u_xlat10_1.xyz = texture2D(_Specular, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _specularColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(_specularPower);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_31) + u_xlat1.xyz;
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
uniform 	vec4 _Time;
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
uniform 	float _high;
uniform 	vec3 _Direction;
uniform 	float _MoveSpeed;
uniform 	float _CloudPower;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _RenderColor;
uniform 	float _Guodu;
uniform 	float _Compare;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _Specular;
uniform lowp sampler2D _CloudTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TANGENT0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
vec2 u_xlat18;
mediump vec2 u_xlat16_20;
vec2 u_xlat21;
mediump vec2 u_xlat16_22;
float u_xlat28;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = dot(_Direction.xxyz.yz, _Direction.xxyz.yz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _Direction.xxyz.yzyz;
    u_xlat0 = u_xlat0 * vec4(_MoveSpeed);
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_2.x = u_xlat1.z * u_xlat28 + 2.0;
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_2.xy = u_xlat1.xy / u_xlat16_2.xx;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(10.0, 10.0);
    u_xlat16_20.xy = u_xlat16_2.xy * vec2(_high) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat16_2.xy * vec2(_high);
    u_xlat21.xy = u_xlat0.xy * _Time.xx + u_xlat16_20.xy;
    u_xlat0 = u_xlat0 * _Time.xxxx;
    u_xlat10_2 = texture2D(_CloudTex, u_xlat21.xy);
    u_xlat16_4 = vs_TEXCOORD0.xyxy * vec4(10.0, 10.0, 20.0, 20.0);
    u_xlat16_4.xy = u_xlat3.xy * vec2(2.0, 2.0) + u_xlat16_4.xy;
    u_xlat16_22.xy = u_xlat3.xy * vec2(4.0, 4.0) + u_xlat16_4.zw;
    u_xlat18.xy = u_xlat0.zw * vec2(8.0, 8.0) + u_xlat16_22.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0) + u_xlat16_4.xy;
    u_xlat10_3 = texture2D(_CloudTex, u_xlat0.xy);
    u_xlat3 = u_xlat10_3 * vec4(0.800000012, 0.800000012, 0.800000012, 0.800000012);
    u_xlat16_2 = max(u_xlat10_2, u_xlat3);
    u_xlat10_0 = texture2D(_CloudTex, u_xlat18.xy);
    u_xlat0 = u_xlat10_0 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_0 = max(u_xlat0, u_xlat16_2);
    u_xlat16_2 = (-vec4(vec4(_CloudPower, _CloudPower, _CloudPower, _CloudPower))) * u_xlat16_0 + _CloudColor;
    u_xlat0 = u_xlat16_0 * vec4(vec4(_CloudPower, _CloudPower, _CloudPower, _CloudPower));
    u_xlat16_4.x = u_xlat0.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat2 = u_xlat2 * _Color;
    u_xlat16_3 = (-u_xlat2) * vs_COLOR0 + u_xlat16_0;
    u_xlat16_2 = u_xlat2 * vs_COLOR0;
    u_xlat16_4.x = u_xlat16_0.x * u_xlat16_2.w;
    u_xlat16_3 = u_xlat16_4.xxxx * u_xlat16_3 + u_xlat16_2;
    u_xlat0 = u_xlat16_2 * u_xlat16_0 + (-u_xlat16_3);
    u_xlat0 = vec4(_Guodu) * u_xlat0 + u_xlat16_3;
    u_xlat0 = u_xlat0 * _RenderColor;
    u_xlat0 = u_xlat0 * vec4(vec4(_Compare, _Compare, _Compare, _Compare));
    u_xlat5.xyz = vs_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx;
    u_xlat16_4.xyz = u_xlat1.yzx * u_xlat5.zxy + (-u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat10_6.xyz = texture2D(_bump, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_6.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.w = u_xlat16_2.z * _BunpZ;
    u_xlat16_4.y = dot(u_xlat16_4.xyz, u_xlat16_2.xyw);
    u_xlat16_4.z = dot(u_xlat1.xyz, u_xlat16_2.xyw);
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat16_2.xyw);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat16_31 = dot(vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ), vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ));
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * vec3(_SpecLightDirectionX, _SpecLightDirectionY, _SpecLightDirectionZ);
    u_xlat16_8.xyz = u_xlat1.xyz * vec3(u_xlat28) + u_xlat16_7.xyz;
    u_xlat16_31 = dot(u_xlat16_7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = u_xlat16_31 * 0.5 + 0.5;
    u_xlat16_7.x = dot(u_xlat16_8.xyz, u_xlat16_8.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz;
    u_xlat16_4.x = dot(u_xlat16_4.xyz, u_xlat16_7.xyz);
    u_xlat16_4.x = min(abs(u_xlat16_4.x), 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_13 = exp2(_SpeRange);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _SpeRange;
    u_xlat10_1.xyz = texture2D(_Specular, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _specularColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(_specularPower);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_31) + u_xlat1.xyz;
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