//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ZheZhao" {
Properties {
_Radius ("边界半径", Float) = 0
_Alpha ("alpha", Range(0, 1)) = 1
_CenterColor ("中间颜色", Color) = (0.63,0.69,1,1)
_MainTex ("Texture", 2D) = "white" { }
_InRadius ("内径", Float) = 0.27
_BrightRadius ("明亮半径", Float) = 0.4
_Convert ("反转", Range(0, 1)) = 0
}
SubShader {
 Tags { "ForceSupported" = "true" "RenderType" = "Transparent" }
 Pass {
  Tags { "ForceSupported" = "true" "RenderType" = "Transparent" }
  Blend SrcColor OneMinusSrcColor, SrcColor OneMinusSrcColor
  ZTest Always
  GpuProgramID 32613
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Radius;
uniform 	float _InRadius;
uniform 	float _BrightRadius;
uniform 	vec4 _CenterColor;
uniform 	float _Convert;
uniform 	float _Alpha;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xy, vs_TEXCOORD1.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.xy = (-u_xlat0.xx) + vec2(_Radius, _BrightRadius);
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = (-_InRadius) + _BrightRadius;
    u_xlat0.x = u_xlat0.y / u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = u_xlat0.xxxx * (-_CenterColor) + _CenterColor;
    u_xlat1 = (-u_xlat0.xxxx) * _CenterColor + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * _CenterColor;
    u_xlat0 = vec4(_Convert) * u_xlat1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha));
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
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Radius;
uniform 	float _InRadius;
uniform 	float _BrightRadius;
uniform 	vec4 _CenterColor;
uniform 	float _Convert;
uniform 	float _Alpha;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xy, vs_TEXCOORD1.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.xy = (-u_xlat0.xx) + vec2(_Radius, _BrightRadius);
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = (-_InRadius) + _BrightRadius;
    u_xlat0.x = u_xlat0.y / u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = u_xlat0.xxxx * (-_CenterColor) + _CenterColor;
    u_xlat1 = (-u_xlat0.xxxx) * _CenterColor + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * _CenterColor;
    u_xlat0 = vec4(_Convert) * u_xlat1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha));
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
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	float _Radius;
uniform 	float _InRadius;
uniform 	float _BrightRadius;
uniform 	vec4 _CenterColor;
uniform 	float _Convert;
uniform 	float _Alpha;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xy, vs_TEXCOORD1.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.xy = (-u_xlat0.xx) + vec2(_Radius, _BrightRadius);
    u_xlatb0 = u_xlat0.x<0.0;
    if(((int(u_xlatb0) * -1))!=0){discard;}
    u_xlat0.x = (-_InRadius) + _BrightRadius;
    u_xlat0.x = u_xlat0.y / u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat1 = u_xlat0.xxxx * (-_CenterColor) + _CenterColor;
    u_xlat1 = (-u_xlat0.xxxx) * _CenterColor + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * _CenterColor;
    u_xlat0 = vec4(_Convert) * u_xlat1 + u_xlat0;
    u_xlat0 = u_xlat0 * vec4(vec4(_Alpha, _Alpha, _Alpha, _Alpha));
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