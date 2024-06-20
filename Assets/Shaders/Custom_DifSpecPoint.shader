//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/DifSpecPoint" {
Properties {
_MainTex ("贴图", 2D) = "white" { }
_AddColor ("叠加颜色", Color) = (0,0,0,0)
_AddPower ("叠加强度", Float) = 0
_MovSam ("采样", Vector) = (0,0,0,0)
_MoveTex ("移动贴图", 2D) = "black" { }
_moveSpeed ("移速", Float) = 50
_FrontColor ("前亮", Color) = (1,1,1,1)
_SideColor ("侧边亮", Color) = (0.5,0.5,0.5,0.5)
_BackColor ("后亮", Color) = (0.5,0.5,0.5,0.5)
_SpecPower ("高光亮度", Float) = 1
_Gloss ("高光光泽度", Float) = 0.6
_SpecFinal ("高光光斑扩散临界点", Float) = 10
_Spec ("Spec", Color) = (1,1,1,1)
_shadowColor ("阴影颜色", Color) = (0,0,0,1)
_refPower ("反射强度", Float) = 0.5
_move ("位移", Float) = 1
_GlassColor ("glasscolor", Color) = (1,1,0,0)
_toGlass ("toGlass", Range(0, 1)) = 0
_FarFogColor ("远度雾", Color) = (1,1,1,0)
_MinDistance ("雾最远距离", Float) = 30
_AddDistance ("雾叠加距离", Float) = 130
_HighFogColor ("高度雾", Color) = (1,0,0,0)
_highFogMinDis ("高度雾最低位置", Float) = -40
_highFogAddDis ("高度雾叠加高度", Float) = 10
_Diffuse ("Diffuse", Color) = (1,1,1,1)
_pos ("过渡距离", Float) = 0
_DissolveTex ("_DissolveTex", 2D) = "white" { }
_DissolveColor ("_DissolveColor", Color) = (1,1,1,1)
_DissolveWidth ("_DissolveWidth", Range(0, 0.5)) = 0.3
_DissolveValue ("_DissolveValue", Range(0, 1)) = 0
}
SubShader {
 Tags { "MobileShadow" = "Geometry" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "MobileShadow" = "Geometry" "QUEUE" = "Geometry" "RenderType" = "Geometry" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  GpuProgramID 65308
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform 	float _moveSpeed;
uniform 	vec4 _MovSam;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MoveTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
float u_xlat14;
float u_xlat15;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
bool u_xlatb25;
void main()
{
    u_xlat0.x = _pos * 10.0 + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x + 100.0;
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_0.xy = texture2D(_DissolveTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_DissolveValue);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat1.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat22 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat22);
    u_xlat1.w = sqrt(u_xlat22);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat16_2.xyz;
    u_xlat25 = dot(u_xlat7.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat7.xyz, u_xlat3.xyz);
    u_xlat3.x = -abs(u_xlat3.x) + 1.5;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat7.xyz, u_xlat10.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_2.x);
    u_xlat14 = exp2(_Gloss);
    u_xlat21 = u_xlat14 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat21;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat10.xyz = u_xlat7.xxx * u_xlat16_2.xyz;
    u_xlat7.xyz = vec3(u_xlat14) * u_xlat10.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat10.x = u_xlat25 + 1.0;
    u_xlat4.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb25 = u_xlat25<0.0;
    u_xlat16_2.xyz = (bool(u_xlatb25)) ? u_xlat10.xyz : u_xlat4.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz * _GlassColor.xyz + u_xlat7.xyz;
    u_xlat7.x = u_xlat3.x * _GlassColor.w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + -1.0;
    u_xlat7.x = _toGlass * u_xlat7.x + 1.0;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * _LightColor0.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat3.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat3.xyz * _DissolveColor.xyz;
    u_xlat3.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz + u_xlat4.xyz;
    u_xlat2.xyz = (-u_xlat0.xzw);
    u_xlat3.x = vs_TEXCOORD1.y * _MovSam.y;
    u_xlat10.x = _Time.x * _moveSpeed;
    u_xlat3.y = u_xlat3.x * 0.00999999978 + u_xlat10.x;
    u_xlat3.x = 0.400000006;
    u_xlat10_3 = texture2D(_MoveTex, u_xlat3.xy).x;
    u_xlat7.x = u_xlat10_3 * 0.5 + u_xlat7.x;
    u_xlat16_5.x = u_xlat7.x * 0.5;
    u_xlat2.w = (-u_xlat16_5.x);
    u_xlat2 = u_xlat2 + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat1.xz = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat7.x = u_xlat1.y + (-_highFogMinDis);
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat8.x = cos(u_xlat1.z);
    u_xlat15 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat8.x + u_xlat15;
    u_xlat1.xw = u_xlat1.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat1.x = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = (-u_xlat1.x) * u_xlat7.x + 1.0;
    u_xlat3.xyz = u_xlat7.xxx * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat3.w = u_xlat7.x * u_xlat2.w + u_xlat16_5.x;
    u_xlat0 = (-u_xlat3) + _FarFogColor;
    u_xlat1.x = float(1.0) / _AddDistance;
    u_xlat1.x = u_xlat1.x * u_xlat1.w;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat8.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat8.x;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat3;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    SV_Target0.w = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat0.xyz = u_xlat8.xyz * vec3(_PointPower) + u_xlat0.xyz;
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
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "MobileShadow" = "Geometry" "QUEUE" = "Geometry" "RenderType" = "Geometry" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Less
  GpuProgramID 92576
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _AddColor;
uniform 	float _AddPower;
uniform 	float _pos;
uniform 	vec4 _DissolveTex_ST;
uniform 	vec4 _DissolveColor;
uniform 	float _DissolveWidth;
uniform 	float _DissolveValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
float u_xlat6;
bool u_xlatb6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat13;
float u_xlat14;
float u_xlat19;
float u_xlat20;
mediump float u_xlat16_21;
float u_xlat22;
void main()
{
    u_xlat0.x = (-_pos) * 10.0 + vs_TEXCOORD1.z;
    u_xlatb6 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb6) * -1))!=0){discard;}
    u_xlat6 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * u_xlat6;
    u_xlat1.xy = vs_TEXCOORD2.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat10_1.xy = texture2D(_DissolveTex, u_xlat1.xy).xw;
    u_xlat1.x = u_xlat10_1.x * u_xlat10_1.y + (-_DissolveValue);
    u_xlat1.x = u_xlat1.x + 0.100000001;
    u_xlat7.x = float(1.0) / _DissolveWidth;
    u_xlat1.x = u_xlat7.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat7.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat7.x;
    u_xlat2.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat2.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat4.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat20);
    u_xlat2.w = sqrt(u_xlat20);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat16_3.xyz;
    u_xlat22 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat7.xyz, u_xlat4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat7.x = log2(u_xlat16_3.x);
    u_xlat13 = exp2(_Gloss);
    u_xlat19 = u_xlat13 * _SpecFinal;
    u_xlat7.x = u_xlat7.x * u_xlat19;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat16_3.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat4.xyz = u_xlat7.xxx * u_xlat16_3.xyz;
    u_xlat7.xyz = vec3(u_xlat13) * u_xlat4.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat10_4.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat7.xyz * vec3(0.100000001, 0.100000001, 0.100000001) + u_xlat10_4.xyz;
    u_xlat7.xyz = _AddColor.xyz * vec3(_AddPower) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat7.xyz * _DissolveColor.xyz;
    u_xlat7.xyz = (-u_xlat4.xyz) * vec3(2.0, 2.0, 2.0) + u_xlat7.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HighFogColor.xyz;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xz = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat19 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat8 = cos(u_xlat2.z);
    u_xlat14 = _highFogAddDis + _highFogMinDis;
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat2.xw = u_xlat2.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat2.x = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = (-u_xlat2.x) * u_xlat19 + 1.0;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _FarFogColor.xyz;
    u_xlat19 = float(1.0) / _AddDistance;
    u_xlat19 = u_xlat19 * u_xlat2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlat20 = u_xlat19 * -2.0 + 3.0;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz + _GlassColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = u_xlat0.www * u_xlat1.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat0;
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
Fallback "Diffuse"
}