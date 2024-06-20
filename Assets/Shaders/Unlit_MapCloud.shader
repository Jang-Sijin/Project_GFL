//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/MapCloud" {
Properties {
_MainTex ("Texture", any) = "" { }
_ChangeColor ("选择变换区域颜色", Color) = (0,1,0,1)
_Snow ("雪量", Range(0, 0.5)) = 0
_Power ("地图亮度", Range(0, 1.5)) = 1
_CloudTex ("云", 2D) = "black" { }
_CloudColor ("云彩颜色", Color) = (1,1,1,1)
_Direction ("风向", Vector) = (0.5,0.5,1,1)
_OffsetX ("X平铺", Float) = 1
_OffsetY ("Y平铺", Float) = 1
_MoveSpeed ("高层云移动速度", Float) = 1
_Guodu ("黑天白天过渡", Range(0, 1)) = 0
_CloudPower ("云层浓度", Range(0, 1.5)) = 0
_RenderColor ("渲染颜色", Color) = (1,1,1,1)
_Compare ("光圈对比程度", Range(0.5, 1)) = 1
_high ("高度", Float) = 1
_show ("显示", Float) = 0
}
SubShader {
 Pass {
  Tags { "ForceSupported" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  Cull Off
  GpuProgramID 28370
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec4 in_NORMAL0;
attribute mediump vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    vs_TEXCOORD4.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
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
uniform 	vec4 _ChangeColor;
uniform 	float _Snow;
uniform 	float _Guodu;
uniform 	float _MoveSpeed;
uniform 	float _CloudPower;
uniform 	mediump vec4 _RenderColor;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _Direction;
uniform 	float _Compare;
uniform 	float _Power;
uniform 	float _high;
uniform 	float _OffsetX;
uniform 	float _OffsetY;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat8;
vec2 u_xlat17;
float u_xlat22;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD3.z;
    u_xlat16_0.y = vs_TEXCOORD4.z;
    u_xlat16_0.z = vs_TEXCOORD2.z;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat22 + 2.0;
    u_xlat16_2.x = vs_TEXCOORD3.x;
    u_xlat16_2.y = vs_TEXCOORD4.x;
    u_xlat16_2.z = vs_TEXCOORD2.x;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = vs_TEXCOORD3.y;
    u_xlat16_2.y = vs_TEXCOORD4.y;
    u_xlat16_2.z = vs_TEXCOORD2.y;
    u_xlat3.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_0 = u_xlat3.xyxy / u_xlat16_0.xxxx;
    u_xlat16_0 = u_xlat16_0 * vec4(10.0, 10.0, 10.0, 10.0);
    u_xlat0 = u_xlat16_0 * vec4(vec4(_high, _high, _high, _high));
    u_xlat1.xy = u_xlat0.zw * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat16_0 = u_xlat0 * vec4(4.0, 4.0, 8.0, 8.0);
    u_xlat16_2.x = dot(_Direction.xy, _Direction.xy);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2 = u_xlat16_2.xxxx * _Direction.xyxy;
    u_xlat2 = u_xlat16_2 * vec4(_MoveSpeed);
    u_xlat1.xy = u_xlat2.xy * _Time.xx + u_xlat1.xy;
    u_xlat2 = u_xlat2 * _Time.xxxx;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + u_xlat16_0.xy;
    u_xlat17.xy = vs_TEXCOORD0.xy * vec2(4.0, 4.0) + u_xlat16_0.zw;
    u_xlat17.xy = u_xlat2.zw * vec2(8.0, 8.0) + u_xlat17.xy;
    u_xlat3.xy = u_xlat2.xy * vec2(4.0, 4.0) + u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_4.xyz = texture2D(_CloudTex, u_xlat3.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(0.800000012, 0.800000012, 0.800000012);
    u_xlat16_5.xyz = max(u_xlat10_1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat17.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_5.xyz = max(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat16_5.xyz * vec3(vec3(_CloudPower, _CloudPower, _CloudPower));
    u_xlat16_26 = _CloudPower * u_xlat16_5.x + -0.300000012;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-vec3(vec3(_CloudPower, _CloudPower, _CloudPower))) * u_xlat16_5.xyz + _CloudColor.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.x = (-_Snow) + 1.0;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat8 = dot(u_xlat10_0.xyz, _ChangeColor.xyz);
    u_xlatb1 = u_xlat1.x<u_xlat8;
    u_xlat16_6.xyz = (bool(u_xlatb1)) ? vec3(0.899999976, 0.899999976, 0.899999976) : u_xlat10_0.xyz;
    u_xlat16_0.x = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_0.yzw = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_0.yzw) * vec3(vec3(_Power, _Power, _Power)) + u_xlat16_5.xyz;
    u_xlat0 = u_xlat16_0 * vec4(vec4(_Power, _Power, _Power, _Power));
    u_xlat16_26 = u_xlat0.x * u_xlat16_5.x;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat0.yzw;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat0.yzw + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_Guodu, _Guodu, _Guodu)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _RenderColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Compare);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_5.x = u_xlat0.z * u_xlat16_5.x;
    u_xlat0.w = u_xlat16_5.x * _Power;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec4 in_NORMAL0;
attribute mediump vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    vs_TEXCOORD4.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
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
uniform 	vec4 _ChangeColor;
uniform 	float _Snow;
uniform 	float _Guodu;
uniform 	float _MoveSpeed;
uniform 	float _CloudPower;
uniform 	mediump vec4 _RenderColor;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _Direction;
uniform 	float _Compare;
uniform 	float _Power;
uniform 	float _high;
uniform 	float _OffsetX;
uniform 	float _OffsetY;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat8;
vec2 u_xlat17;
float u_xlat22;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD3.z;
    u_xlat16_0.y = vs_TEXCOORD4.z;
    u_xlat16_0.z = vs_TEXCOORD2.z;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat22 + 2.0;
    u_xlat16_2.x = vs_TEXCOORD3.x;
    u_xlat16_2.y = vs_TEXCOORD4.x;
    u_xlat16_2.z = vs_TEXCOORD2.x;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = vs_TEXCOORD3.y;
    u_xlat16_2.y = vs_TEXCOORD4.y;
    u_xlat16_2.z = vs_TEXCOORD2.y;
    u_xlat3.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_0 = u_xlat3.xyxy / u_xlat16_0.xxxx;
    u_xlat16_0 = u_xlat16_0 * vec4(10.0, 10.0, 10.0, 10.0);
    u_xlat0 = u_xlat16_0 * vec4(vec4(_high, _high, _high, _high));
    u_xlat1.xy = u_xlat0.zw * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat16_0 = u_xlat0 * vec4(4.0, 4.0, 8.0, 8.0);
    u_xlat16_2.x = dot(_Direction.xy, _Direction.xy);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2 = u_xlat16_2.xxxx * _Direction.xyxy;
    u_xlat2 = u_xlat16_2 * vec4(_MoveSpeed);
    u_xlat1.xy = u_xlat2.xy * _Time.xx + u_xlat1.xy;
    u_xlat2 = u_xlat2 * _Time.xxxx;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + u_xlat16_0.xy;
    u_xlat17.xy = vs_TEXCOORD0.xy * vec2(4.0, 4.0) + u_xlat16_0.zw;
    u_xlat17.xy = u_xlat2.zw * vec2(8.0, 8.0) + u_xlat17.xy;
    u_xlat3.xy = u_xlat2.xy * vec2(4.0, 4.0) + u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_4.xyz = texture2D(_CloudTex, u_xlat3.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(0.800000012, 0.800000012, 0.800000012);
    u_xlat16_5.xyz = max(u_xlat10_1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat17.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_5.xyz = max(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat16_5.xyz * vec3(vec3(_CloudPower, _CloudPower, _CloudPower));
    u_xlat16_26 = _CloudPower * u_xlat16_5.x + -0.300000012;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-vec3(vec3(_CloudPower, _CloudPower, _CloudPower))) * u_xlat16_5.xyz + _CloudColor.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.x = (-_Snow) + 1.0;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat8 = dot(u_xlat10_0.xyz, _ChangeColor.xyz);
    u_xlatb1 = u_xlat1.x<u_xlat8;
    u_xlat16_6.xyz = (bool(u_xlatb1)) ? vec3(0.899999976, 0.899999976, 0.899999976) : u_xlat10_0.xyz;
    u_xlat16_0.x = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_0.yzw = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_0.yzw) * vec3(vec3(_Power, _Power, _Power)) + u_xlat16_5.xyz;
    u_xlat0 = u_xlat16_0 * vec4(vec4(_Power, _Power, _Power, _Power));
    u_xlat16_26 = u_xlat0.x * u_xlat16_5.x;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat0.yzw;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat0.yzw + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_Guodu, _Guodu, _Guodu)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _RenderColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Compare);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_5.x = u_xlat0.z * u_xlat16_5.x;
    u_xlat0.w = u_xlat16_5.x * _Power;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec4 in_NORMAL0;
attribute mediump vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat16_2.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * in_TANGENT0.www;
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    vs_TEXCOORD4.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
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
uniform 	vec4 _ChangeColor;
uniform 	float _Snow;
uniform 	float _Guodu;
uniform 	float _MoveSpeed;
uniform 	float _CloudPower;
uniform 	mediump vec4 _RenderColor;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _Direction;
uniform 	float _Compare;
uniform 	float _Power;
uniform 	float _high;
uniform 	float _OffsetX;
uniform 	float _OffsetY;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat8;
vec2 u_xlat17;
float u_xlat22;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD3.z;
    u_xlat16_0.y = vs_TEXCOORD4.z;
    u_xlat16_0.z = vs_TEXCOORD2.z;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat22 + 2.0;
    u_xlat16_2.x = vs_TEXCOORD3.x;
    u_xlat16_2.y = vs_TEXCOORD4.x;
    u_xlat16_2.z = vs_TEXCOORD2.x;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = vs_TEXCOORD3.y;
    u_xlat16_2.y = vs_TEXCOORD4.y;
    u_xlat16_2.z = vs_TEXCOORD2.y;
    u_xlat3.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_0 = u_xlat3.xyxy / u_xlat16_0.xxxx;
    u_xlat16_0 = u_xlat16_0 * vec4(10.0, 10.0, 10.0, 10.0);
    u_xlat0 = u_xlat16_0 * vec4(vec4(_high, _high, _high, _high));
    u_xlat1.xy = u_xlat0.zw * vec2(2.0, 2.0) + vs_TEXCOORD0.xy;
    u_xlat16_0 = u_xlat0 * vec4(4.0, 4.0, 8.0, 8.0);
    u_xlat16_2.x = dot(_Direction.xy, _Direction.xy);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2 = u_xlat16_2.xxxx * _Direction.xyxy;
    u_xlat2 = u_xlat16_2 * vec4(_MoveSpeed);
    u_xlat1.xy = u_xlat2.xy * _Time.xx + u_xlat1.xy;
    u_xlat2 = u_xlat2 * _Time.xxxx;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + u_xlat16_0.xy;
    u_xlat17.xy = vs_TEXCOORD0.xy * vec2(4.0, 4.0) + u_xlat16_0.zw;
    u_xlat17.xy = u_xlat2.zw * vec2(8.0, 8.0) + u_xlat17.xy;
    u_xlat3.xy = u_xlat2.xy * vec2(4.0, 4.0) + u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_4.xyz = texture2D(_CloudTex, u_xlat3.xy).xyz;
    u_xlat4.xyz = u_xlat10_4.xyz * vec3(0.800000012, 0.800000012, 0.800000012);
    u_xlat16_5.xyz = max(u_xlat10_1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat17.xy * vec2(_OffsetX, _OffsetY);
    u_xlat10_1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(0.5, 0.5, 0.5);
    u_xlat16_5.xyz = max(u_xlat1.xyz, u_xlat16_5.xyz);
    u_xlat1.xyz = u_xlat16_5.xyz * vec3(vec3(_CloudPower, _CloudPower, _CloudPower));
    u_xlat16_26 = _CloudPower * u_xlat16_5.x + -0.300000012;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = (-vec3(vec3(_CloudPower, _CloudPower, _CloudPower))) * u_xlat16_5.xyz + _CloudColor.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat1.xyz;
    u_xlat1.x = (-_Snow) + 1.0;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat8 = dot(u_xlat10_0.xyz, _ChangeColor.xyz);
    u_xlatb1 = u_xlat1.x<u_xlat8;
    u_xlat16_6.xyz = (bool(u_xlatb1)) ? vec3(0.899999976, 0.899999976, 0.899999976) : u_xlat10_0.xyz;
    u_xlat16_0.x = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_0.yzw = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_0.yzw) * vec3(vec3(_Power, _Power, _Power)) + u_xlat16_5.xyz;
    u_xlat0 = u_xlat16_0 * vec4(vec4(_Power, _Power, _Power, _Power));
    u_xlat16_26 = u_xlat0.x * u_xlat16_5.x;
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz + u_xlat0.yzw;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat0.yzw + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_Guodu, _Guodu, _Guodu)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _RenderColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_Compare);
    u_xlat16_5.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_5.x = u_xlat0.z * u_xlat16_5.x;
    u_xlat0.w = u_xlat16_5.x * _Power;
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