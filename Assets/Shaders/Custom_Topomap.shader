//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/Topomap" {
Properties {
_MainTex ("贴图", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_bump ("法线贴图", 2D) = "bump" { }
_SpecColor ("高光颜色", Color) = (1,1,1,1)
_SpeRange ("高光柔光", Float) = 1
_hightlightMap ("高光贴图", 2D) = "white" { }
_guodu ("过渡到通透", Range(0, 1)) = 0
_quadTex ("方框贴图", 2D) = "black" { }
_quadNum ("方块数量", Float) = 10
_quadColor ("方块颜色", Color) = (0,1,0,1)
_p0 ("移动控制", Vector) = (0,1,0,1)
_upDir ("变换方向", Vector) = (1,1,0,1)
_width ("宽度", Float) = 0.5
_scanColor ("扫描颜色", Color) = (1,1,1,0)
_type2Color ("模式2底色", Color) = (0,0,1,1)
_FarFogColor ("远度雾", Color) = (1,1,1,0)
_MinDistance ("雾最远距离", Float) = 30
_AddDistance ("雾叠加距离", Float) = 130
_HighFogColor ("高度雾", Color) = (1,0,0,0)
_highFogMinDis ("高度雾最低位置", Float) = -40
_highFogAddDis ("高度雾叠加高度", Float) = 10
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  GpuProgramID 51648
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
varying highp vec3 vs_TANGENT0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _FarFogColor;
uniform 	vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
uniform 	vec4 _quadColor;
uniform 	float _quadNum;
uniform 	vec4 _p0;
uniform 	vec4 _upDir;
uniform 	float _width;
uniform 	vec4 _scanColor;
uniform 	vec4 _type2Color;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _quadTex;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat15 = u_xlat0.y + (-_highFogMinDis);
    u_xlat1.xy = vec2(1.0, 1.0) / vec2(_AddDistance, _highFogAddDis);
    u_xlat15 = u_xlat15 * u_xlat1.y;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat6.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = (-u_xlat6.x) * u_xlat15 + 1.0;
    u_xlat6.xy = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat6.xy);
    u_xlat10_6.xyz = texture2D(_bump, u_xlat6.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4 = u_xlat10_2 * _Color;
    u_xlat2 = (-u_xlat10_2) * _Color + _HighFogColor;
    u_xlat2 = vec4(u_xlat15) * u_xlat2 + u_xlat4;
    u_xlat4 = (-u_xlat2) + _FarFogColor;
    u_xlat6.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_p0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, _upDir.xyz);
    u_xlat5 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat10 = sqrt(u_xlat5);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat6.xyz;
    u_xlat5 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5 = -abs(u_xlat5) * 1.20000005 + 1.0;
    u_xlat10 = u_xlat10 + (-_MinDistance);
    u_xlat10 = u_xlat1.x * u_xlat10;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat15 = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat15;
    u_xlat1 = vec4(u_xlat10) * u_xlat4 + u_xlat2;
    u_xlat10 = u_xlat0.x / _width;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(_quadNum);
    u_xlat10_2 = texture2D(_quadTex, u_xlat2.xy);
    u_xlat3.w = u_xlat10 * u_xlat10_2.w;
    u_xlat3.xyz = u_xlat10_2.xyz * _quadColor.xyz;
    u_xlat2 = u_xlat3.wwww * u_xlat3;
    u_xlat2 = _type2Color * vec4(u_xlat5) + u_xlat2;
    u_xlat2 = _scanColor * vec4(u_xlat10) + u_xlat2;
    u_xlat5 = (-_scanColor.w) * u_xlat10 + 1.0;
    u_xlat3 = u_xlat1 + (-u_xlat2);
    u_xlat2 = vec4(u_xlat5) * u_xlat3 + u_xlat2;
    SV_Target0 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
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
varying highp vec3 vs_TANGENT0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _FarFogColor;
uniform 	vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
uniform 	vec4 _quadColor;
uniform 	float _quadNum;
uniform 	vec4 _p0;
uniform 	vec4 _upDir;
uniform 	float _width;
uniform 	vec4 _scanColor;
uniform 	vec4 _type2Color;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _quadTex;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat15 = u_xlat0.y + (-_highFogMinDis);
    u_xlat1.xy = vec2(1.0, 1.0) / vec2(_AddDistance, _highFogAddDis);
    u_xlat15 = u_xlat15 * u_xlat1.y;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat6.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = (-u_xlat6.x) * u_xlat15 + 1.0;
    u_xlat6.xy = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat6.xy);
    u_xlat10_6.xyz = texture2D(_bump, u_xlat6.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4 = u_xlat10_2 * _Color;
    u_xlat2 = (-u_xlat10_2) * _Color + _HighFogColor;
    u_xlat2 = vec4(u_xlat15) * u_xlat2 + u_xlat4;
    u_xlat4 = (-u_xlat2) + _FarFogColor;
    u_xlat6.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_p0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, _upDir.xyz);
    u_xlat5 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat10 = sqrt(u_xlat5);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat6.xyz;
    u_xlat5 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5 = -abs(u_xlat5) * 1.20000005 + 1.0;
    u_xlat10 = u_xlat10 + (-_MinDistance);
    u_xlat10 = u_xlat1.x * u_xlat10;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat15 = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat15;
    u_xlat1 = vec4(u_xlat10) * u_xlat4 + u_xlat2;
    u_xlat10 = u_xlat0.x / _width;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(_quadNum);
    u_xlat10_2 = texture2D(_quadTex, u_xlat2.xy);
    u_xlat3.w = u_xlat10 * u_xlat10_2.w;
    u_xlat3.xyz = u_xlat10_2.xyz * _quadColor.xyz;
    u_xlat2 = u_xlat3.wwww * u_xlat3;
    u_xlat2 = _type2Color * vec4(u_xlat5) + u_xlat2;
    u_xlat2 = _scanColor * vec4(u_xlat10) + u_xlat2;
    u_xlat5 = (-_scanColor.w) * u_xlat10 + 1.0;
    u_xlat3 = u_xlat1 + (-u_xlat2);
    u_xlat2 = vec4(u_xlat5) * u_xlat3 + u_xlat2;
    SV_Target0 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
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
varying highp vec3 vs_TANGENT0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _FarFogColor;
uniform 	vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
uniform 	vec4 _quadColor;
uniform 	float _quadNum;
uniform 	vec4 _p0;
uniform 	vec4 _upDir;
uniform 	float _width;
uniform 	vec4 _scanColor;
uniform 	vec4 _type2Color;
uniform lowp sampler2D _bump;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _quadTex;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat15 = u_xlat0.y + (-_highFogMinDis);
    u_xlat1.xy = vec2(1.0, 1.0) / vec2(_AddDistance, _highFogAddDis);
    u_xlat15 = u_xlat15 * u_xlat1.y;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat6.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = (-u_xlat6.x) * u_xlat15 + 1.0;
    u_xlat6.xy = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2 = texture2D(_MainTex, u_xlat6.xy);
    u_xlat10_6.xyz = texture2D(_bump, u_xlat6.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_6.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4 = u_xlat10_2 * _Color;
    u_xlat2 = (-u_xlat10_2) * _Color + _HighFogColor;
    u_xlat2 = vec4(u_xlat15) * u_xlat2 + u_xlat4;
    u_xlat4 = (-u_xlat2) + _FarFogColor;
    u_xlat6.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_p0.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, _upDir.xyz);
    u_xlat5 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat10 = sqrt(u_xlat5);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat6.xyz;
    u_xlat5 = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5 = -abs(u_xlat5) * 1.20000005 + 1.0;
    u_xlat10 = u_xlat10 + (-_MinDistance);
    u_xlat10 = u_xlat1.x * u_xlat10;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat15 = u_xlat10 * -2.0 + 3.0;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat10 = u_xlat10 * u_xlat15;
    u_xlat1 = vec4(u_xlat10) * u_xlat4 + u_xlat2;
    u_xlat10 = u_xlat0.x / _width;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(_quadNum);
    u_xlat10_2 = texture2D(_quadTex, u_xlat2.xy);
    u_xlat3.w = u_xlat10 * u_xlat10_2.w;
    u_xlat3.xyz = u_xlat10_2.xyz * _quadColor.xyz;
    u_xlat2 = u_xlat3.wwww * u_xlat3;
    u_xlat2 = _type2Color * vec4(u_xlat5) + u_xlat2;
    u_xlat2 = _scanColor * vec4(u_xlat10) + u_xlat2;
    u_xlat5 = (-_scanColor.w) * u_xlat10 + 1.0;
    u_xlat3 = u_xlat1 + (-u_xlat2);
    u_xlat2 = vec4(u_xlat5) * u_xlat3 + u_xlat2;
    SV_Target0 = (bool(u_xlatb0)) ? u_xlat2 : u_xlat1;
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