//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Legacy Shaders/Lightmapped/MotherBaseQuad" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_lerp ("lerp", Range(0, 1)) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_highFogMin ("高度雾最低位置", Float) = -40
_highFogAdd ("高度雾叠加高度", Float) = 10
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Less
  Cull Off
  GpuProgramID 47207
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _Color;
uniform 	float _lerp;
uniform 	float _highFogMin;
uniform 	float _highFogAdd;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * vs_TEXCOORD0.x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * vs_TEXCOORD0.z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * vs_TEXCOORD0.w + u_xlat0;
    u_xlat0 = u_xlat0 + (-_highFogMin);
    u_xlat2.x = float(1.0) / _highFogAdd;
    u_xlat0 = u_xlat2.x * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat2.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = (-u_xlat2.x) * u_xlat0 + 1.0;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat2.z * _Color.w;
    u_xlat4 = u_xlat16_1 * u_xlat2.y + (-u_xlat2.x);
    u_xlat0 = u_xlat0 * u_xlat4 + u_xlat2.x;
    u_xlat2.x = vs_TEXCOORD1.x + -0.5;
    u_xlat2.x = abs(u_xlat2.x) + -0.5;
    u_xlat2.x = abs(u_xlat2.x) * 10.0;
    u_xlat0 = u_xlat2.x * u_xlat0;
    u_xlat0 = u_xlat0 * _lerp;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = _Color.xyz;
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
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _Color;
uniform 	float _lerp;
uniform 	float _highFogMin;
uniform 	float _highFogAdd;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * vs_TEXCOORD0.x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * vs_TEXCOORD0.z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * vs_TEXCOORD0.w + u_xlat0;
    u_xlat0 = u_xlat0 + (-_highFogMin);
    u_xlat2.x = float(1.0) / _highFogAdd;
    u_xlat0 = u_xlat2.x * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat2.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = (-u_xlat2.x) * u_xlat0 + 1.0;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat2.z * _Color.w;
    u_xlat4 = u_xlat16_1 * u_xlat2.y + (-u_xlat2.x);
    u_xlat0 = u_xlat0 * u_xlat4 + u_xlat2.x;
    u_xlat2.x = vs_TEXCOORD1.x + -0.5;
    u_xlat2.x = abs(u_xlat2.x) + -0.5;
    u_xlat2.x = abs(u_xlat2.x) * 10.0;
    u_xlat0 = u_xlat2.x * u_xlat0;
    u_xlat0 = u_xlat0 * _lerp;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = _Color.xyz;
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
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _Color;
uniform 	float _lerp;
uniform 	float _highFogMin;
uniform 	float _highFogAdd;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * vs_TEXCOORD0.x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * vs_TEXCOORD0.z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * vs_TEXCOORD0.w + u_xlat0;
    u_xlat0 = u_xlat0 + (-_highFogMin);
    u_xlat2.x = float(1.0) / _highFogAdd;
    u_xlat0 = u_xlat2.x * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat2.x = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = (-u_xlat2.x) * u_xlat0 + 1.0;
    u_xlat10_2.xyz = texture2D(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat2.z * _Color.w;
    u_xlat4 = u_xlat16_1 * u_xlat2.y + (-u_xlat2.x);
    u_xlat0 = u_xlat0 * u_xlat4 + u_xlat2.x;
    u_xlat2.x = vs_TEXCOORD1.x + -0.5;
    u_xlat2.x = abs(u_xlat2.x) + -0.5;
    u_xlat2.x = abs(u_xlat2.x) * 10.0;
    u_xlat0 = u_xlat2.x * u_xlat0;
    u_xlat0 = u_xlat0 * _lerp;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = _Color.xyz;
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