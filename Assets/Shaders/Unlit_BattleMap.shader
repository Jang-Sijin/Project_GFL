//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/BattleMap" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_AlphaTex ("透明图", 2D) = "white" { }
_ScreenTex ("扫描图", 2D) = "white" { }
_SColor ("扫描图色", Color) = (1,1,1,1)
_Bright ("亮度", Range(0, 2)) = 1
_ChangeColor ("选择变换区域颜色", Color) = (0,0,1,1)
_Snow ("雪量", Range(0, 0.5)) = 0
_FlashCoord ("FlashCoord", Range(0, 6)) = 2
_Compare ("对比度", Range(0, 1)) = 0
_Yup ("Y上限位移", Range(0, 1)) = 1
_Ydown ("Y下限位移", Range(0, 1)) = 0
_MoveSpeedX ("移动速度X", Float) = 0
_MoveSpeedY ("移动速度Y", Float) = 0
[Enum(Off, 0, On, 1)] _Lighting ("开启光源", Float) = 0
_Specular ("Specular", Color) = (1,1,1,1)
_Gloss ("Gloss", Range(8, 16)) = 20
_WorldLightX ("世界光源方向X", Range(-1, 1)) = 1
_WorldLightY ("世界光源方向Y", Range(-1, 1)) = 1
_WorldLightZ ("世界光源方向Z", Range(-1, 1)) = 1
_DarkColor ("暗处颜色", Color) = (1,1,1,1)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZTest Always
  GpuProgramID 55721
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTex_ST;
uniform 	vec4 _ScreenTex_ST;
uniform 	float _Lighting;
uniform 	mediump vec4 _Specular;
uniform 	float _Gloss;
uniform 	mediump float _WorldLightX;
uniform 	mediump float _WorldLightY;
uniform 	mediump float _WorldLightZ;
uniform 	mediump vec4 _DarkColor;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3.x = dot(vec3(_WorldLightX, _WorldLightY, _WorldLightZ), vec3(_WorldLightX, _WorldLightY, _WorldLightZ));
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_WorldLightX, _WorldLightY, _WorldLightZ);
    u_xlat12 = dot((-u_xlat16_3.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat16_3.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_3.x);
    u_xlat0.x = u_xlat0.x * _Gloss;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _Specular.xyz;
    u_xlat0.xyz = _DarkColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlatb12 = _Lighting==1.0;
    u_xlat16_0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat16_0 * in_COLOR0;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
    u_xlat1.xy = in_TEXCOORD2.xy * _ScreenTex_ST.xy + _ScreenTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
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
uniform 	float _Yup;
uniform 	float _Ydown;
uniform 	float _MoveSpeedX;
uniform 	float _Bright;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ScreenTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.x = _Time.x * 50.0;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat3 = _Time.x * 50.0 + -0.200000003;
    u_xlatb0.y = vs_TEXCOORD0.x>=u_xlat3;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3 = (-_Ydown) + _Yup;
    u_xlat1.y = vs_TEXCOORD0.y * u_xlat3 + _Ydown;
    u_xlat1.x = _Time.x * _MoveSpeedX + vs_TEXCOORD0.x;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_3 = texture2D(_AlphaTex, u_xlat1.xy).w;
    u_xlat1 = u_xlat10_2 * vec4(_Bright);
    u_xlat1 = u_xlat1 * _Color;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat6.x = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.y = _Time.x * 100.0 + (-u_xlat6.x);
    u_xlat2.x = 0.0;
    u_xlat6.xy = u_xlat2.xy + vs_TEXCOORD2.xy;
    u_xlat10_6 = texture2D(_ScreenTex, u_xlat6.xy).w;
    u_xlat2 = vec4(u_xlat10_6) * _SColor;
    u_xlat1 = u_xlat2 * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = vec4(u_xlat10_3) * u_xlat1;
    u_xlat0 = u_xlat0 * _Color.wwww;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTex_ST;
uniform 	vec4 _ScreenTex_ST;
uniform 	float _Lighting;
uniform 	mediump vec4 _Specular;
uniform 	float _Gloss;
uniform 	mediump float _WorldLightX;
uniform 	mediump float _WorldLightY;
uniform 	mediump float _WorldLightZ;
uniform 	mediump vec4 _DarkColor;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3.x = dot(vec3(_WorldLightX, _WorldLightY, _WorldLightZ), vec3(_WorldLightX, _WorldLightY, _WorldLightZ));
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_WorldLightX, _WorldLightY, _WorldLightZ);
    u_xlat12 = dot((-u_xlat16_3.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat16_3.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_3.x);
    u_xlat0.x = u_xlat0.x * _Gloss;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _Specular.xyz;
    u_xlat0.xyz = _DarkColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlatb12 = _Lighting==1.0;
    u_xlat16_0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat16_0 * in_COLOR0;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
    u_xlat1.xy = in_TEXCOORD2.xy * _ScreenTex_ST.xy + _ScreenTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
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
uniform 	float _Yup;
uniform 	float _Ydown;
uniform 	float _MoveSpeedX;
uniform 	float _Bright;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ScreenTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.x = _Time.x * 50.0;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat3 = _Time.x * 50.0 + -0.200000003;
    u_xlatb0.y = vs_TEXCOORD0.x>=u_xlat3;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3 = (-_Ydown) + _Yup;
    u_xlat1.y = vs_TEXCOORD0.y * u_xlat3 + _Ydown;
    u_xlat1.x = _Time.x * _MoveSpeedX + vs_TEXCOORD0.x;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_3 = texture2D(_AlphaTex, u_xlat1.xy).w;
    u_xlat1 = u_xlat10_2 * vec4(_Bright);
    u_xlat1 = u_xlat1 * _Color;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat6.x = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.y = _Time.x * 100.0 + (-u_xlat6.x);
    u_xlat2.x = 0.0;
    u_xlat6.xy = u_xlat2.xy + vs_TEXCOORD2.xy;
    u_xlat10_6 = texture2D(_ScreenTex, u_xlat6.xy).w;
    u_xlat2 = vec4(u_xlat10_6) * _SColor;
    u_xlat1 = u_xlat2 * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = vec4(u_xlat10_3) * u_xlat1;
    u_xlat0 = u_xlat0 * _Color.wwww;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTex_ST;
uniform 	vec4 _ScreenTex_ST;
uniform 	float _Lighting;
uniform 	mediump vec4 _Specular;
uniform 	float _Gloss;
uniform 	mediump float _WorldLightX;
uniform 	mediump float _WorldLightY;
uniform 	mediump float _WorldLightZ;
uniform 	mediump vec4 _DarkColor;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3.x = dot(vec3(_WorldLightX, _WorldLightY, _WorldLightZ), vec3(_WorldLightX, _WorldLightY, _WorldLightZ));
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_WorldLightX, _WorldLightY, _WorldLightZ);
    u_xlat12 = dot((-u_xlat16_3.xyz), u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + (-u_xlat16_3.xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat12 = u_xlat12 * 0.5 + 0.5;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_3.x);
    u_xlat0.x = u_xlat0.x * _Gloss;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * _Specular.xyz;
    u_xlat0.xyz = _DarkColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlatb12 = _Lighting==1.0;
    u_xlat16_0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : vec3(1.0, 1.0, 1.0);
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat16_0 * in_COLOR0;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
    phase0_Output0_2 = u_xlat0;
    u_xlat1.xy = in_TEXCOORD2.xy * _ScreenTex_ST.xy + _ScreenTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat1.xy;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
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
uniform 	float _Yup;
uniform 	float _Ydown;
uniform 	float _MoveSpeedX;
uniform 	float _Bright;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ScreenTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
    u_xlat0.x = _Time.x * 50.0;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat3 = _Time.x * 50.0 + -0.200000003;
    u_xlatb0.y = vs_TEXCOORD0.x>=u_xlat3;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3 = (-_Ydown) + _Yup;
    u_xlat1.y = vs_TEXCOORD0.y * u_xlat3 + _Ydown;
    u_xlat1.x = _Time.x * _MoveSpeedX + vs_TEXCOORD0.x;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_3 = texture2D(_AlphaTex, u_xlat1.xy).w;
    u_xlat1 = u_xlat10_2 * vec4(_Bright);
    u_xlat1 = u_xlat1 * _Color;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat6.x = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.y = _Time.x * 100.0 + (-u_xlat6.x);
    u_xlat2.x = 0.0;
    u_xlat6.xy = u_xlat2.xy + vs_TEXCOORD2.xy;
    u_xlat10_6 = texture2D(_ScreenTex, u_xlat6.xy).w;
    u_xlat2 = vec4(u_xlat10_6) * _SColor;
    u_xlat1 = u_xlat2 * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = vec4(u_xlat10_3) * u_xlat1;
    u_xlat0 = u_xlat0 * _Color.wwww;
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