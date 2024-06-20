//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/RoomQuad" {
Properties {
_FrontColor ("前亮", Color) = (1,1,1,1)
_BackColor ("后亮", Color) = (0.5,0.5,0.5,0.5)
_SpecPower ("高光亮度", Float) = 1
_Spec ("Spec", Color) = (1,1,1,1)
_shadowColor ("阴影颜色", Color) = (0,0,0,1)
_refPower ("反射强度", Float) = 0.5
_GlassColor ("glasscolor", Color) = (1,1,0,0)
_toGlass ("toGlass", Range(0, 1)) = 0
_FarFogColor ("远度雾", Color) = (1,1,1,0)
_MinDistance ("雾最远距离", Float) = 30
_AddDistance ("雾叠加距离", Float) = 130
_HighFogColor ("高度雾", Color) = (1,0,0,0)
_highFogMinDis ("高度雾最低位置", Float) = -40
_highFogAddDis ("高度雾叠加高度", Float) = 10
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Less
  Cull Front
  GpuProgramID 39640
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
bool u_xlatb7;
float u_xlat8;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat21 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat21)) + (-u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat4.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat4.xyz = (-vec3(u_xlat21)) * u_xlat4.xyz + _LightColor0.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat5.xyz = vec3(u_xlat21) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlatb7 = u_xlat21<0.0;
    u_xlat14 = u_xlat21 * 0.200000003;
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
    u_xlat14 = u_xlat14 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat14;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_6.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_6.xyz) + u_xlat0.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_6.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat15 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat15 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat8) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	float _refPower;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
bool u_xlatb8;
float u_xlat9;
float u_xlat16;
float u_xlat17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
float u_xlat27;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat24 = dot((-u_xlat16_2.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat16_2.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat4.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat25);
    u_xlat1.w = sqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat3.x = (-u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.xyz = u_xlat3.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_refPower);
    u_xlat3.xyz = u_xlat3.xyz * _FrontColor.xyz;
    u_xlat5.xyz = (-_LightColor0.xyz) + _BackColor.xyz;
    u_xlat5.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz + _LightColor0.xyz;
    u_xlat6.xyz = (-_LightColor0.xyz) + _FrontColor.xyz;
    u_xlat6.xyz = vec3(u_xlat24) * u_xlat6.xyz + _LightColor0.xyz;
    u_xlatb8 = u_xlat24<0.0;
    u_xlat16 = u_xlat24 * 0.200000003;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat16 = u_xlat16 * _LightColor0.x;
    u_xlat0.x = u_xlat0.x * _GlassColor.w + u_xlat16;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.w = _toGlass * u_xlat0.x + 1.0;
    u_xlat16_7.xyz = (bool(u_xlatb8)) ? u_xlat5.xyz : u_xlat6.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = (-u_xlat16_7.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat24 + (-u_xlat3.x);
    u_xlat24 = unity_ShadowFadeCenterAndType.w * u_xlat24 + u_xlat3.x;
    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.x = texture2D(_ShadowMapTexture, vs_TEXCOORD1.xy).x;
    u_xlatb3 = vs_TEXCOORD1.z<u_xlat3.x;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = max(u_xlat3.x, _LightShadowData.x);
    u_xlat16_7.x = (-u_xlat3.x) + 1.0;
    u_xlat16_7.x = u_xlat24 * u_xlat16_7.x + u_xlat3.x;
    u_xlat3.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = u_xlat16_7.xxx * u_xlat3.xyz + _shadowColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat3.xyz;
    u_xlat0 = (-u_xlat2) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat17 = cos(u_xlat1.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat17 + u_xlat3.x;
    u_xlat1.xyw = u_xlat1.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat1.y;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat9) * u_xlat1.x + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat2;
    u_xlat2 = (-u_xlat0) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat9 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat0 = u_xlat1.xxxx * u_xlat2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "Diffuse"
}