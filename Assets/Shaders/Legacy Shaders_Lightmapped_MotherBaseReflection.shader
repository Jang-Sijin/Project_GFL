//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Legacy Shaders/Lightmapped/MotherBaseReflection" {
Properties {
_Color ("Color Tint", Color) = (1,1,1,1)
_ReflectColor ("Reflect Color", Color) = (1,1,1,1)
_ReflectAmount ("Reflect Amount", Range(0, 1)) = 1
_Cubemap ("Reflection Cubemap", Cube) = "_Skybox" { }
_FarFogColor ("远度雾", Color) = (1,1,1,0)
_MinDistance ("雾最远距离", Float) = 30
_AddDistance ("雾叠加距离", Float) = 130
_HighFogColor ("高度雾", Color) = (1,0,0,0)
_highFogMinDis ("高度雾最低位置", Float) = -40
_highFogAddDis ("高度雾叠加高度", Float) = 10
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 16259
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_3 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat0.xyz);
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
float u_xlat10;
float u_xlat15;
mediump float u_xlat16_16;
float u_xlat18;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = glstate_lightmodel_ambient.xyz * vec3(2.0, 2.0, 2.0) + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat3.xyz = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = u_xlat15 + (-_MinDistance);
    u_xlat18 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat18 = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat18;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat13;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    u_xlat16_3 = dot((-u_xlat2.xyz), u_xlat1.xyz);
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    vs_TEXCOORD3.xyz = u_xlat1.xyz * (-vec3(u_xlat16_3)) + (-u_xlat2.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ReflectColor;
uniform 	float _ReflectAmount;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp samplerCube _Cubemap;
uniform highp sampler2D _ShadowMapTexture;
varying mediump vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat13;
bool u_xlatb13;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = vs_TEXCOORD1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = cos(u_xlat0.y);
    u_xlat10 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat5.x + u_xlat10;
    u_xlat0.x = u_xlat0.x + (-_highFogMinDis);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.x = vs_TEXCOORD1.y + (-_highFogMinDis);
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat5.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat5.x) * u_xlat0.x + 1.0;
    u_xlat16_1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * vs_TEXCOORD0.xyz;
    u_xlat16_16 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_2.xyz = vec3(u_xlat16_16) * _WorldSpaceLightPos0.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
    u_xlat10_5.xyz = textureCube(_Cubemap, vs_TEXCOORD3.xyz).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _ReflectColor.xyz + (-u_xlat16_1.xyz);
    u_xlat5.xyz = vec3(_ReflectAmount) * u_xlat5.xyz + u_xlat16_1.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
    u_xlat3.y = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat3.xy = sqrt(u_xlat3.xy);
    u_xlat8.x = u_xlat3.y + (-_MinDistance);
    u_xlat3.x = (-u_xlat4.x) + u_xlat3.x;
    u_xlat3.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat4.x;
    u_xlat3.x = u_xlat3.x * _LightShadowData.z + _LightShadowData.w;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat13 = texture2D(_ShadowMapTexture, vs_TEXCOORD4.xy).x;
    u_xlatb13 = vs_TEXCOORD4.z<u_xlat13;
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat13 = max(u_xlat13, _LightShadowData.x);
    u_xlat16_1.x = (-u_xlat13) + 1.0;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + u_xlat13;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat16_1.xxx + u_xlat16_6.xyz;
    u_xlat3.xzw = (-u_xlat5.xyz) + _HighFogColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xzw + u_xlat5.xyz;
    u_xlat3.xzw = (-u_xlat0.xyz) + _FarFogColor.xyz;
    u_xlat15 = float(1.0) / _AddDistance;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat8.x = u_xlat15 * -2.0 + 3.0;
    u_xlat15 = u_xlat15 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat8.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat3.xzw + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "Reflective/VertexLit"
}