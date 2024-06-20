//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/SkeletonGhost" {
Properties {
_Alpha ("Color Fade", Range(0, 1)) = 1
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" { }
_AlphaTex ("Alpha图", 2D) = "white" { }
_TextureFade ("Texture Fade Out", Range(0, 1)) = 0
_AlphaControl ("透明度控制(_AlphaControl)", Range(0, 1)) = 1
_AddControl ("叠加颜色控制(_AddControl)", Range(0, 1)) = 0
_ControlColor ("叠加颜色(_ControlColor)", Color) = (0,0,0,0)
_AddLoopDuration ("叠加颜色动效持续时间_AddLoopDuration", Float) = 0
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 0
_AnimTexture ("动画贴图（_AnimTexture）", 2D) = "black" { }
_R_Channel_Speed ("R Channel Speed", Range(-5, 5)) = 0
_R_Channel_Factor ("R Channel Factor", Vector) = (0,0,0,0)
[Enum(Off, 0, On, 1)] _useFog ("使用雾", Float) = 0
_FarFogColor ("远度雾", Color) = (0.5,0.5,0.5,0)
_FarMinDistance ("雾最远距离", Float) = 25
_FarAddDistance ("雾叠加距离", Float) = 30
[MaterialToggle] _Use2DMask ("Use2DMask", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "False" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 38280
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump float u_xlat16_10;
float u_xlat11;
float u_xlat19;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4 = sin(u_xlat1.x);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    u_xlat16_10 = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_10 + _R_Channel_Factor.w;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4;
    u_xlatb1.x = u_xlat1.x>=0.00999999978;
    u_xlat16_4 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * vec4(u_xlat16_4) + u_xlat0;
    u_xlat1.xyz = (-vec3(_AlphaControl)) * u_xlat16_0.xyz + _FarFogColor.xyz;
    u_xlat2 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat19 = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_FarMinDistance);
    u_xlat11 = float(1.0) / _FarAddDistance;
    u_xlat5.x = u_xlat11 * u_xlat5.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat11 = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat11;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.w = u_xlat5.x * u_xlat19 + u_xlat2.w;
    u_xlatb1.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _useFog), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_0 = (u_xlatb1.x) ? u_xlat0 : u_xlat2;
    u_xlatb1.xz = greaterThanEqual(vs_TEXCOORD1.xxyx, _ClipRect.xxyx).xz;
    u_xlat1.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xz));
    u_xlatb5.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlat1.xz = u_xlat1.xz * u_xlat5.xy;
    u_xlat1.x = u_xlat1.z * u_xlat1.x;
    u_xlat16_4 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.w = (u_xlatb1.y) ? u_xlat1.x : u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlatb1.x = u_xlat16_4<0.0;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    if(((int(u_xlatb1.x) * -1))!=0){discard;}
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
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump float u_xlat16_10;
float u_xlat11;
float u_xlat19;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4 = sin(u_xlat1.x);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    u_xlat16_10 = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_10 + _R_Channel_Factor.w;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4;
    u_xlatb1.x = u_xlat1.x>=0.00999999978;
    u_xlat16_4 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * vec4(u_xlat16_4) + u_xlat0;
    u_xlat1.xyz = (-vec3(_AlphaControl)) * u_xlat16_0.xyz + _FarFogColor.xyz;
    u_xlat2 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat19 = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_FarMinDistance);
    u_xlat11 = float(1.0) / _FarAddDistance;
    u_xlat5.x = u_xlat11 * u_xlat5.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat11 = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat11;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.w = u_xlat5.x * u_xlat19 + u_xlat2.w;
    u_xlatb1.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _useFog), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_0 = (u_xlatb1.x) ? u_xlat0 : u_xlat2;
    u_xlatb1.xz = greaterThanEqual(vs_TEXCOORD1.xxyx, _ClipRect.xxyx).xz;
    u_xlat1.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xz));
    u_xlatb5.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlat1.xz = u_xlat1.xz * u_xlat5.xy;
    u_xlat1.x = u_xlat1.z * u_xlat1.x;
    u_xlat16_4 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.w = (u_xlatb1.y) ? u_xlat1.x : u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlatb1.x = u_xlat16_4<0.0;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    if(((int(u_xlatb1.x) * -1))!=0){discard;}
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
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump float u_xlat16_10;
float u_xlat11;
float u_xlat19;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4 = sin(u_xlat1.x);
    u_xlat16_4 = u_xlat16_4 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 0.5;
    u_xlat16_10 = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_10 + _R_Channel_Factor.w;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4;
    u_xlatb1.x = u_xlat1.x>=0.00999999978;
    u_xlat16_4 = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * vec4(u_xlat16_4) + u_xlat0;
    u_xlat1.xyz = (-vec3(_AlphaControl)) * u_xlat16_0.xyz + _FarFogColor.xyz;
    u_xlat2 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat19 = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_FarMinDistance);
    u_xlat11 = float(1.0) / _FarAddDistance;
    u_xlat5.x = u_xlat11 * u_xlat5.x;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat11 = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat11;
    u_xlat0.xyz = u_xlat5.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.w = u_xlat5.x * u_xlat19 + u_xlat2.w;
    u_xlatb1.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _useFog), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_0 = (u_xlatb1.x) ? u_xlat0 : u_xlat2;
    u_xlatb1.xz = greaterThanEqual(vs_TEXCOORD1.xxyx, _ClipRect.xxyx).xz;
    u_xlat1.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xz));
    u_xlatb5.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlat1.xz = u_xlat1.xz * u_xlat5.xy;
    u_xlat1.x = u_xlat1.z * u_xlat1.x;
    u_xlat16_4 = u_xlat16_0.w * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat16_0.w * u_xlat1.x;
    SV_Target0.w = (u_xlatb1.y) ? u_xlat1.x : u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlatb1.x = u_xlat16_4<0.0;
    u_xlatb1.x = u_xlatb1.y && u_xlatb1.x;
    if(((int(u_xlatb1.x) * -1))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CHARACTER" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	mediump vec4 _MobileShadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MobileShadowTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
bvec4 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat13;
bvec2 u_xlatb13;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4.x = sin(u_xlat1.x);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat16_10.x = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10.x + _R_Channel_Factor.w;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4.x;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_4.xxxx + u_xlat0;
    u_xlat1.x = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat0 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x + (-_FarMinDistance);
    u_xlat13 = float(1.0) / _FarAddDistance;
    u_xlat7.x = u_xlat13 * u_xlat7.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + u_xlat0.w;
    u_xlatb13.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _Use2DMask), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_4.x = (u_xlatb13.x) ? u_xlat1.x : u_xlat0.w;
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb5.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
    u_xlat5.xy = u_xlat5.zw * u_xlat5.xy;
    u_xlat1.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_10.x = u_xlat16_4.x * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat1.x * u_xlat16_4.x;
    SV_Target0.w = (u_xlatb13.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlatb1 = u_xlat16_10.x<0.0;
    u_xlatb1 = u_xlatb13.y && u_xlatb1;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat10_1.xw = texture2D(_MobileShadowTexture, vs_TEXCOORD2.xy).xz;
    u_xlat16_4.x = u_xlat10_1.w + u_xlat10_1.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * _MobileShadowOpacity;
    u_xlat16_4.x = (-u_xlat16_4.x) * vs_TEXCOORD2.z + 1.0;
    u_xlat16_10.xyz = (-_MobileShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_10.xyz + _MobileShadowColor.xyz;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat16_4.xyz + _FarFogColor.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat7.xxx * u_xlat5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb13.x) ? u_xlat1.xyw : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CHARACTER" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	mediump vec4 _MobileShadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MobileShadowTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
bvec4 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat13;
bvec2 u_xlatb13;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4.x = sin(u_xlat1.x);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat16_10.x = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10.x + _R_Channel_Factor.w;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4.x;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_4.xxxx + u_xlat0;
    u_xlat1.x = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat0 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x + (-_FarMinDistance);
    u_xlat13 = float(1.0) / _FarAddDistance;
    u_xlat7.x = u_xlat13 * u_xlat7.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + u_xlat0.w;
    u_xlatb13.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _Use2DMask), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_4.x = (u_xlatb13.x) ? u_xlat1.x : u_xlat0.w;
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb5.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
    u_xlat5.xy = u_xlat5.zw * u_xlat5.xy;
    u_xlat1.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_10.x = u_xlat16_4.x * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat1.x * u_xlat16_4.x;
    SV_Target0.w = (u_xlatb13.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlatb1 = u_xlat16_10.x<0.0;
    u_xlatb1 = u_xlatb13.y && u_xlatb1;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat10_1.xw = texture2D(_MobileShadowTexture, vs_TEXCOORD2.xy).xz;
    u_xlat16_4.x = u_xlat10_1.w + u_xlat10_1.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * _MobileShadowOpacity;
    u_xlat16_4.x = (-u_xlat16_4.x) * vs_TEXCOORD2.z + 1.0;
    u_xlat16_10.xyz = (-_MobileShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_10.xyz + _MobileShadowColor.xyz;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat16_4.xyz + _FarFogColor.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat7.xxx * u_xlat5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb13.x) ? u_xlat1.xyw : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CHARACTER" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	mediump vec4 _MobileShadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MobileShadowTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
bvec4 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat13;
bvec2 u_xlatb13;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4.x = sin(u_xlat1.x);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat16_10.x = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10.x + _R_Channel_Factor.w;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4.x;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_4.xxxx + u_xlat0;
    u_xlat1.x = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat0 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x + (-_FarMinDistance);
    u_xlat13 = float(1.0) / _FarAddDistance;
    u_xlat7.x = u_xlat13 * u_xlat7.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + u_xlat0.w;
    u_xlatb13.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _Use2DMask), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_4.x = (u_xlatb13.x) ? u_xlat1.x : u_xlat0.w;
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb5.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
    u_xlat5.xy = u_xlat5.zw * u_xlat5.xy;
    u_xlat1.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_10.x = u_xlat16_4.x * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat1.x * u_xlat16_4.x;
    SV_Target0.w = (u_xlatb13.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlatb1 = u_xlat16_10.x<0.0;
    u_xlatb1 = u_xlatb13.y && u_xlatb1;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat10_1.xw = texture2D(_MobileShadowTexture, vs_TEXCOORD2.xy).xz;
    u_xlat16_4.x = u_xlat10_1.w + u_xlat10_1.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * _MobileShadowOpacity;
    u_xlat16_4.x = (-u_xlat16_4.x) * vs_TEXCOORD2.z + 1.0;
    u_xlat16_10.xyz = (-_MobileShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_10.xyz + _MobileShadowColor.xyz;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat16_4.xyz + _FarFogColor.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat7.xxx * u_xlat5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb13.x) ? u_xlat1.xyw : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "GROUND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	mediump vec4 _MobileShadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MobileShadowTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec3 u_xlat10_5;
bvec4 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat13;
bvec2 u_xlatb13;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4.x = sin(u_xlat1.x);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat16_10.x = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10.x + _R_Channel_Factor.w;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4.x;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_4.xxxx + u_xlat0;
    u_xlat1.x = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat0 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x + (-_FarMinDistance);
    u_xlat13 = float(1.0) / _FarAddDistance;
    u_xlat7.x = u_xlat13 * u_xlat7.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + u_xlat0.w;
    u_xlatb13.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _Use2DMask), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_4.x = (u_xlatb13.x) ? u_xlat1.x : u_xlat0.w;
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb5.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
    u_xlat5.xy = u_xlat5.zw * u_xlat5.xy;
    u_xlat1.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_10.x = u_xlat16_4.x * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat1.x * u_xlat16_4.x;
    SV_Target0.w = (u_xlatb13.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlatb1 = u_xlat16_10.x<0.0;
    u_xlatb1 = u_xlatb13.y && u_xlatb1;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat10_5.xyz = texture2D(_MobileShadowTexture, vs_TEXCOORD2.xy).xyz;
    u_xlat16_4.x = u_xlat10_5.y + u_xlat10_5.x;
    u_xlat16_4.x = u_xlat10_5.z + u_xlat16_4.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * _MobileShadowOpacity;
    u_xlat16_4.x = (-u_xlat16_4.x) * vs_TEXCOORD2.z + 1.0;
    u_xlat16_10.xyz = (-_MobileShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_10.xyz + _MobileShadowColor.xyz;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat16_4.xyz + _FarFogColor.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat7.xxx * u_xlat5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb13.x) ? u_xlat1.xyw : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "GROUND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	mediump vec4 _MobileShadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MobileShadowTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec3 u_xlat10_5;
bvec4 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat13;
bvec2 u_xlatb13;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4.x = sin(u_xlat1.x);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat16_10.x = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10.x + _R_Channel_Factor.w;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4.x;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_4.xxxx + u_xlat0;
    u_xlat1.x = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat0 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x + (-_FarMinDistance);
    u_xlat13 = float(1.0) / _FarAddDistance;
    u_xlat7.x = u_xlat13 * u_xlat7.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + u_xlat0.w;
    u_xlatb13.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _Use2DMask), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_4.x = (u_xlatb13.x) ? u_xlat1.x : u_xlat0.w;
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb5.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
    u_xlat5.xy = u_xlat5.zw * u_xlat5.xy;
    u_xlat1.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_10.x = u_xlat16_4.x * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat1.x * u_xlat16_4.x;
    SV_Target0.w = (u_xlatb13.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlatb1 = u_xlat16_10.x<0.0;
    u_xlatb1 = u_xlatb13.y && u_xlatb1;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat10_5.xyz = texture2D(_MobileShadowTexture, vs_TEXCOORD2.xy).xyz;
    u_xlat16_4.x = u_xlat10_5.y + u_xlat10_5.x;
    u_xlat16_4.x = u_xlat10_5.z + u_xlat16_4.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * _MobileShadowOpacity;
    u_xlat16_4.x = (-u_xlat16_4.x) * vs_TEXCOORD2.z + 1.0;
    u_xlat16_10.xyz = (-_MobileShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_10.xyz + _MobileShadowColor.xyz;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat16_4.xyz + _FarFogColor.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat7.xxx * u_xlat5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb13.x) ? u_xlat1.xyw : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "GROUND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ControlColor;
uniform 	mediump float _TextureFade;
uniform 	mediump float _Alpha;
uniform 	float _AlphaControl;
uniform 	float _AddControl;
uniform 	float _AddLoopDuration;
uniform 	mediump vec4 _MobileShadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	float _R_Channel_Speed;
uniform 	mediump vec4 _R_Channel_Factor;
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float _useFog;
uniform 	float _Use2DMask;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AnimTexture;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _MobileShadowTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec3 u_xlat10_5;
bvec4 u_xlatb5;
lowp float u_xlat10_6;
bool u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat13;
bvec2 u_xlatb13;
void main()
{
    u_xlat0.x = _Time.y / _AddLoopDuration;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _AddLoopDuration;
    u_xlat0.x = u_xlat0.x * 3.14159274;
    u_xlat0.x = u_xlat0.x / _AddLoopDuration;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AddControl;
    u_xlatb6 = 0.0<_AddLoopDuration;
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : _AddControl;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_6 = texture2D(_AlphaTex, vs_TEXCOORD0.xy).w;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = u_xlat10_1.wwww * _ControlColor;
    u_xlat16_2 = vec4(u_xlat10_6) * u_xlat16_2;
    u_xlat2 = u_xlat0.xxxx * u_xlat16_2;
    u_xlat16_3.xyz = max(u_xlat10_1.xyz, vec3(_TextureFade));
    u_xlat3.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat3.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _Color;
    u_xlat1 = u_xlat10_1.wwww * u_xlat3;
    u_xlat0 = vec4(u_xlat10_6) * u_xlat1;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha)) + u_xlat2;
    u_xlat1.x = _Time.y * _R_Channel_Speed;
    u_xlat1.x = u_xlat1.x * 6.28318548;
    u_xlat16_4.x = sin(u_xlat1.x);
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * 0.5;
    u_xlat16_10.x = (-_R_Channel_Factor.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_10.x + _R_Channel_Factor.w;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat1.x = texture2D(_AnimTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat1.x * u_xlat16_4.x;
    u_xlatb1 = u_xlat1.x>=0.00999999978;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xyz = u_xlat16_2.www * _R_Channel_Factor.xyz;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_4.xxxx + u_xlat0;
    u_xlat1.x = (-_AlphaControl) * u_xlat16_0.w + 1.0;
    u_xlat0 = u_xlat16_0 * vec4(_AlphaControl);
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x + (-_FarMinDistance);
    u_xlat13 = float(1.0) / _FarAddDistance;
    u_xlat7.x = u_xlat13 * u_xlat7.x;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13 = u_xlat7.x * -2.0 + 3.0;
    u_xlat7.x = u_xlat7.x * u_xlat7.x;
    u_xlat7.x = u_xlat7.x * u_xlat13;
    u_xlat1.x = u_xlat7.x * u_xlat1.x + u_xlat0.w;
    u_xlatb13.xy = equal(vec4(_useFog, _Use2DMask, _useFog, _Use2DMask), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16_4.x = (u_xlatb13.x) ? u_xlat1.x : u_xlat0.w;
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb5.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
    u_xlat5.xy = u_xlat5.zw * u_xlat5.xy;
    u_xlat1.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_10.x = u_xlat16_4.x * u_xlat1.x + -0.00100000005;
    u_xlat1.x = u_xlat1.x * u_xlat16_4.x;
    SV_Target0.w = (u_xlatb13.y) ? u_xlat1.x : u_xlat16_4.x;
    u_xlatb1 = u_xlat16_10.x<0.0;
    u_xlatb1 = u_xlatb13.y && u_xlatb1;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat10_5.xyz = texture2D(_MobileShadowTexture, vs_TEXCOORD2.xy).xyz;
    u_xlat16_4.x = u_xlat10_5.y + u_xlat10_5.x;
    u_xlat16_4.x = u_xlat10_5.z + u_xlat16_4.x;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_4.x * _MobileShadowOpacity;
    u_xlat16_4.x = (-u_xlat16_4.x) * vs_TEXCOORD2.z + 1.0;
    u_xlat16_10.xyz = (-_MobileShadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_10.xyz + _MobileShadowColor.xyz;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat16_4.xyz + _FarFogColor.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * u_xlat16_4.xyz;
    u_xlat1.xyw = u_xlat7.xxx * u_xlat5.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = (u_xlatb13.x) ? u_xlat1.xyw : u_xlat16_4.xyz;
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
SubProgram "gles hw_tier00 " {
Keywords { "CHARACTER" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CHARACTER" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CHARACTER" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "GROUND" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "GROUND" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "GROUND" }
""
}
}
}
}
CustomEditor "ShadowLitGUI"
}