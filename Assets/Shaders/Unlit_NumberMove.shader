//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/NumberMove" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MoveSpeed ("移动速度", Float) = 200
_MainTex ("Particle Texture", 2D) = "white" { }
_Num ("数量", Float) = 10
_AddTex ("叠加贴图", 2D) = "black" { }
_AddMove ("叠加移动速度", Float) = 200
_XLength ("最终X拉伸", Float) = 1
_YLength ("最终Y拉伸", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 21646
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Num;
uniform 	float _XLength;
uniform 	float _YLength;
uniform 	float _MoveSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_2;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat2.xyz = in_TEXCOORD0.xxy * _MainTex_ST.xxy + _MainTex_ST.zzw;
    u_xlat0.x = u_xlat2.z * _Num + u_xlat0.x;
    phase0_Output0_2.xzw = u_xlat2.xyz;
    u_xlat0.x = floor(u_xlat0.x);
    phase0_Output0_2.y = u_xlat0.x / _Num;
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
uniform 	mediump vec4 _TintColor;
uniform 	float _AddMove;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AddTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
float u_xlat9;
void main()
{
    u_xlat0.y = (-_Time.x) * _AddMove + vs_TEXCOORD1.y;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat10_0.xyz = texture2D(_AddTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _TintColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat9 = (-vs_TEXCOORD1.y) + 0.5;
    u_xlat9 = -abs(u_xlat9) * 2.0 + 1.0;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat1 = vs_COLOR0 * _TintColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Num;
uniform 	float _XLength;
uniform 	float _YLength;
uniform 	float _MoveSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_2;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat2.xyz = in_TEXCOORD0.xxy * _MainTex_ST.xxy + _MainTex_ST.zzw;
    u_xlat0.x = u_xlat2.z * _Num + u_xlat0.x;
    phase0_Output0_2.xzw = u_xlat2.xyz;
    u_xlat0.x = floor(u_xlat0.x);
    phase0_Output0_2.y = u_xlat0.x / _Num;
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
uniform 	mediump vec4 _TintColor;
uniform 	float _AddMove;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AddTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
float u_xlat9;
void main()
{
    u_xlat0.y = (-_Time.x) * _AddMove + vs_TEXCOORD1.y;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat10_0.xyz = texture2D(_AddTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _TintColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat9 = (-vs_TEXCOORD1.y) + 0.5;
    u_xlat9 = -abs(u_xlat9) * 2.0 + 1.0;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat1 = vs_COLOR0 * _TintColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Num;
uniform 	float _XLength;
uniform 	float _YLength;
uniform 	float _MoveSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_2;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat2.xyz = in_TEXCOORD0.xxy * _MainTex_ST.xxy + _MainTex_ST.zzw;
    u_xlat0.x = u_xlat2.z * _Num + u_xlat0.x;
    phase0_Output0_2.xzw = u_xlat2.xyz;
    u_xlat0.x = floor(u_xlat0.x);
    phase0_Output0_2.y = u_xlat0.x / _Num;
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
uniform 	mediump vec4 _TintColor;
uniform 	float _AddMove;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AddTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
float u_xlat9;
void main()
{
    u_xlat0.y = (-_Time.x) * _AddMove + vs_TEXCOORD1.y;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat10_0.xyz = texture2D(_AddTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _TintColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat9 = (-vs_TEXCOORD1.y) + 0.5;
    u_xlat9 = -abs(u_xlat9) * 2.0 + 1.0;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat1 = vs_COLOR0 * _TintColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Num;
uniform 	float _XLength;
uniform 	float _YLength;
uniform 	float _MoveSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_2;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat2.xyz = in_TEXCOORD0.xxy * _MainTex_ST.xxy + _MainTex_ST.zzw;
    u_xlat0.x = u_xlat2.z * _Num + u_xlat0.x;
    phase0_Output0_2.xzw = u_xlat2.xyz;
    u_xlat0.x = floor(u_xlat0.x);
    phase0_Output0_2.y = u_xlat0.x / _Num;
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
uniform 	mediump vec4 _TintColor;
uniform 	float _AddMove;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AddTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
float u_xlat9;
void main()
{
    u_xlat0.y = (-_Time.x) * _AddMove + vs_TEXCOORD1.y;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat10_0.xyz = texture2D(_AddTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _TintColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat9 = (-vs_TEXCOORD1.y) + 0.5;
    u_xlat9 = -abs(u_xlat9) * 2.0 + 1.0;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat1 = vs_COLOR0 * _TintColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Num;
uniform 	float _XLength;
uniform 	float _YLength;
uniform 	float _MoveSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_2;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat2.xyz = in_TEXCOORD0.xxy * _MainTex_ST.xxy + _MainTex_ST.zzw;
    u_xlat0.x = u_xlat2.z * _Num + u_xlat0.x;
    phase0_Output0_2.xzw = u_xlat2.xyz;
    u_xlat0.x = floor(u_xlat0.x);
    phase0_Output0_2.y = u_xlat0.x / _Num;
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
uniform 	mediump vec4 _TintColor;
uniform 	float _AddMove;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AddTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
float u_xlat9;
void main()
{
    u_xlat0.y = (-_Time.x) * _AddMove + vs_TEXCOORD1.y;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat10_0.xyz = texture2D(_AddTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _TintColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat9 = (-vs_TEXCOORD1.y) + 0.5;
    u_xlat9 = -abs(u_xlat9) * 2.0 + 1.0;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat1 = vs_COLOR0 * _TintColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _Num;
uniform 	float _XLength;
uniform 	float _YLength;
uniform 	float _MoveSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp  vec4 phase0_Output0_2;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xy = u_xlat0.xy * vec2(_XLength, _YLength);
    gl_Position.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _MoveSpeed;
    u_xlat2.xyz = in_TEXCOORD0.xxy * _MainTex_ST.xxy + _MainTex_ST.zzw;
    u_xlat0.x = u_xlat2.z * _Num + u_xlat0.x;
    phase0_Output0_2.xzw = u_xlat2.xyz;
    u_xlat0.x = floor(u_xlat0.x);
    phase0_Output0_2.y = u_xlat0.x / _Num;
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
uniform 	mediump vec4 _TintColor;
uniform 	float _AddMove;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AddTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
float u_xlat9;
void main()
{
    u_xlat0.y = (-_Time.x) * _AddMove + vs_TEXCOORD1.y;
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat10_0.xyz = texture2D(_AddTex, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _TintColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat9 = (-vs_TEXCOORD1.y) + 0.5;
    u_xlat9 = -abs(u_xlat9) * 2.0 + 1.0;
    u_xlat9 = max(u_xlat9, 0.0);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat1 = vs_COLOR0 * _TintColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0 = u_xlat1;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
}
}
}
}