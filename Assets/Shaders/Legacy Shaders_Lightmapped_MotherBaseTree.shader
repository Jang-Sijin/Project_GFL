//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Legacy Shaders/Lightmapped/MotherBaseTree" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_FarFogColor ("远度雾", Color) = (1,1,1,0)
_MinDistance ("雾最远距离", Float) = 30
_AddDistance ("雾叠加距离", Float) = 130
_HighFogColor ("高度雾", Color) = (1,0,0,0)
_highFogMinDis ("高度雾最低位置", Float) = -40
_highFogAddDis ("高度雾叠加高度", Float) = 10
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  GpuProgramID 40942
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat7;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat1.x = u_xlat10_0.w * _Color.w + (-_Cutoff);
    u_xlatb1 = u_xlat1.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat1.xy = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat1.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4 = cos(u_xlat1.y);
    u_xlat7 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat4 + u_xlat7;
    u_xlat1.x = u_xlat1.x + (-_highFogMinDis);
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat4 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat7 = u_xlat7 + (-_MinDistance);
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat4) * u_xlat1.x + 1.0;
    u_xlat2.xyz = (-u_xlat10_0.xyz) * _Color.xyz + _HighFogColor.xyz;
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat1.xyw) + _FarFogColor.xyz;
    u_xlat11 = float(1.0) / _AddDistance;
    u_xlat7 = u_xlat7 * u_xlat11;
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat11 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat11;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat2.xyz + u_xlat1.xyw;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat7;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat1.x = u_xlat10_0.w * _Color.w + (-_Cutoff);
    u_xlatb1 = u_xlat1.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat1.xy = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat1.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4 = cos(u_xlat1.y);
    u_xlat7 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat4 + u_xlat7;
    u_xlat1.x = u_xlat1.x + (-_highFogMinDis);
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat4 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat7 = u_xlat7 + (-_MinDistance);
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat4) * u_xlat1.x + 1.0;
    u_xlat2.xyz = (-u_xlat10_0.xyz) * _Color.xyz + _HighFogColor.xyz;
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat1.xyw) + _FarFogColor.xyz;
    u_xlat11 = float(1.0) / _AddDistance;
    u_xlat7 = u_xlat7 * u_xlat11;
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat11 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat11;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat2.xyz + u_xlat1.xyw;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _Color;
uniform 	float _Cutoff;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat7;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat1.x = u_xlat10_0.w * _Color.w + (-_Cutoff);
    u_xlatb1 = u_xlat1.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat2.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
    u_xlat1.xy = u_xlat2.xz * vec2(0.300000012, 0.300000012) + u_xlat1.xy;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat4 = cos(u_xlat1.y);
    u_xlat7 = _highFogAddDis + _highFogMinDis;
    u_xlat1.x = u_xlat1.x * u_xlat4 + u_xlat7;
    u_xlat1.x = u_xlat1.x + (-_highFogMinDis);
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat4 = u_xlat2.y + (-_highFogMinDis);
    u_xlat2.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat7 = u_xlat7 + (-_MinDistance);
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = (-u_xlat4) * u_xlat1.x + 1.0;
    u_xlat2.xyz = (-u_xlat10_0.xyz) * _Color.xyz + _HighFogColor.xyz;
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat1.xyw) + _FarFogColor.xyz;
    u_xlat11 = float(1.0) / _AddDistance;
    u_xlat7 = u_xlat7 * u_xlat11;
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat11 = u_xlat7 * -2.0 + 3.0;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat11;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat2.xyz + u_xlat1.xyw;
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
Fallback "Transparent/Cutout/VertexLit"
}