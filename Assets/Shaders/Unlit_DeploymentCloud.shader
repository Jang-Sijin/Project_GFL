//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/DeploymentCloud" {
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
_showCloud ("显示云层", Range(0, 1)) = 0
_baseHigh ("基础高度", Float) = 50
_addHigh ("叠加高度", Float) = 10
_AddDistance ("maxDistance", Float) = 50
_MinDistance ("min distance", Float) = 200
_fogColor ("fog color", Color) = (1,1,1,1)
}
SubShader {
 Pass {
  Tags { "ForceSupported" = "true" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  GpuProgramID 327
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _AddDistance;
uniform 	float _MinDistance;
uniform 	mediump vec4 _fogColor;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_MinDistance);
    u_xlat1 = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat1 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = _fogColor.xyz;
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
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _AddDistance;
uniform 	float _MinDistance;
uniform 	mediump vec4 _fogColor;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_MinDistance);
    u_xlat1 = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat1 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = _fogColor.xyz;
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
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _AddDistance;
uniform 	float _MinDistance;
uniform 	mediump vec4 _fogColor;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_MinDistance);
    u_xlat1 = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat1 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = _fogColor.xyz;
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
  Tags { "ForceSupported" = "true" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 128596
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
uniform 	float _MoveSpeed;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _Direction;
uniform 	float _high;
uniform 	float _OffsetX;
uniform 	float _OffsetY;
uniform 	float _showCloud;
uniform 	float _AddDistance;
uniform 	float _MinDistance;
uniform lowp sampler2D _CloudTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 10.0);
    u_xlat1.xy = u_xlat16_0.xy * vec2(vec2(_high, _high)) + vs_TEXCOORD0.xy;
    u_xlat11.xy = u_xlat16_0.xy * vec2(vec2(_high, _high));
    u_xlat16_0.x = dot(_Direction.xy, _Direction.xy);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xy = u_xlat16_0.xx * _Direction.xy;
    u_xlat2.xy = u_xlat16_0.xy * vec2(_MoveSpeed);
    u_xlat2.xy = u_xlat2.xy * _Time.xx;
    u_xlat1.xy = u_xlat2.xy * vec2(0.300000012, 0.300000012) + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat0.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat16_3 = u_xlat0.x + -0.5;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat0.w = u_xlat16_3 * _showCloud;
    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(10.0, 10.0, 20.0, 20.0);
    u_xlat1.xy = u_xlat11.xy * vec2(2.0, 2.0) + u_xlat3.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(4.0, 4.0) + u_xlat3.zw;
    u_xlat11.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat1.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat2.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat1.xy = u_xlat11.xy * vec2(_OffsetX, _OffsetY);
    u_xlat1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat16_4 = u_xlat2.x + -0.400000006;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat2.w = u_xlat16_4 * _showCloud;
    u_xlat16_0 = u_xlat0 + u_xlat2;
    u_xlat16_4 = u_xlat1.x + -0.200000003;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.w = u_xlat16_4 * _showCloud;
    u_xlat16_0 = u_xlat16_0 + u_xlat1;
    u_xlat16_0 = u_xlat16_0 * _CloudColor;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_MinDistance);
    u_xlat6 = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat6 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1.x;
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
uniform 	float _MoveSpeed;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _Direction;
uniform 	float _high;
uniform 	float _OffsetX;
uniform 	float _OffsetY;
uniform 	float _showCloud;
uniform 	float _AddDistance;
uniform 	float _MinDistance;
uniform lowp sampler2D _CloudTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 10.0);
    u_xlat1.xy = u_xlat16_0.xy * vec2(vec2(_high, _high)) + vs_TEXCOORD0.xy;
    u_xlat11.xy = u_xlat16_0.xy * vec2(vec2(_high, _high));
    u_xlat16_0.x = dot(_Direction.xy, _Direction.xy);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xy = u_xlat16_0.xx * _Direction.xy;
    u_xlat2.xy = u_xlat16_0.xy * vec2(_MoveSpeed);
    u_xlat2.xy = u_xlat2.xy * _Time.xx;
    u_xlat1.xy = u_xlat2.xy * vec2(0.300000012, 0.300000012) + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat0.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat16_3 = u_xlat0.x + -0.5;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat0.w = u_xlat16_3 * _showCloud;
    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(10.0, 10.0, 20.0, 20.0);
    u_xlat1.xy = u_xlat11.xy * vec2(2.0, 2.0) + u_xlat3.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(4.0, 4.0) + u_xlat3.zw;
    u_xlat11.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat1.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat2.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat1.xy = u_xlat11.xy * vec2(_OffsetX, _OffsetY);
    u_xlat1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat16_4 = u_xlat2.x + -0.400000006;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat2.w = u_xlat16_4 * _showCloud;
    u_xlat16_0 = u_xlat0 + u_xlat2;
    u_xlat16_4 = u_xlat1.x + -0.200000003;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.w = u_xlat16_4 * _showCloud;
    u_xlat16_0 = u_xlat16_0 + u_xlat1;
    u_xlat16_0 = u_xlat16_0 * _CloudColor;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_MinDistance);
    u_xlat6 = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat6 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1.x;
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
uniform 	float _MoveSpeed;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump vec4 _Direction;
uniform 	float _high;
uniform 	float _OffsetX;
uniform 	float _OffsetY;
uniform 	float _showCloud;
uniform 	float _AddDistance;
uniform 	float _MinDistance;
uniform lowp sampler2D _CloudTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat6;
vec2 u_xlat11;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 10.0);
    u_xlat1.xy = u_xlat16_0.xy * vec2(vec2(_high, _high)) + vs_TEXCOORD0.xy;
    u_xlat11.xy = u_xlat16_0.xy * vec2(vec2(_high, _high));
    u_xlat16_0.x = dot(_Direction.xy, _Direction.xy);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xy = u_xlat16_0.xx * _Direction.xy;
    u_xlat2.xy = u_xlat16_0.xy * vec2(_MoveSpeed);
    u_xlat2.xy = u_xlat2.xy * _Time.xx;
    u_xlat1.xy = u_xlat2.xy * vec2(0.300000012, 0.300000012) + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat0.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat16_3 = u_xlat0.x + -0.5;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat0.w = u_xlat16_3 * _showCloud;
    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(10.0, 10.0, 20.0, 20.0);
    u_xlat1.xy = u_xlat11.xy * vec2(2.0, 2.0) + u_xlat3.xy;
    u_xlat11.xy = u_xlat11.xy * vec2(4.0, 4.0) + u_xlat3.zw;
    u_xlat11.xy = u_xlat2.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat1.xy = u_xlat2.xy * vec2(0.200000003, 0.200000003) + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(_OffsetX, _OffsetY);
    u_xlat2.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat1.xy = u_xlat11.xy * vec2(_OffsetX, _OffsetY);
    u_xlat1.xyz = texture2D(_CloudTex, u_xlat1.xy).xyz;
    u_xlat16_4 = u_xlat2.x + -0.400000006;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat2.w = u_xlat16_4 * _showCloud;
    u_xlat16_0 = u_xlat0 + u_xlat2;
    u_xlat16_4 = u_xlat1.x + -0.200000003;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.w = u_xlat16_4 * _showCloud;
    u_xlat16_0 = u_xlat16_0 + u_xlat1;
    u_xlat16_0 = u_xlat16_0 * _CloudColor;
    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_MinDistance);
    u_xlat6 = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat6 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1.x;
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