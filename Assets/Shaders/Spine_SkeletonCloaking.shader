//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/SkeletonCloaking" {
Properties {
_Cutoff ("cutoff(_Cutoff)", Range(0, 10)) = 5
_lineColor ("lineColor", Color) = (1,1,1,1)
_MainTex ("Texture to blend", 2D) = "black" { }
_NoiseTex ("条纹图", 2D) = "white" { }
_NoiseSize ("条纹密度", Range(1, 10)) = 1
_NoiseMoveSpeed ("条纹移动速度", Range(1, 10)) = 1
_TransTex ("过渡图", 2D) = "white" { }
_TransSize ("过渡密度", Range(0.01, 0.1)) = 0.1
_TransWidth ("中间过渡宽度(_TransWidth)", Range(0, 1)) = 1
_ShowEffect ("效果过度(_ShowEffect)", Range(0, 1)) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 8
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 6935
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _lineColor;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(_TransSize);
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlatb3 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb3) * -1))!=0){discard;}
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.wwww * u_xlat1;
    u_xlat2 = u_xlat16_2 * _lineColor;
    u_xlat2 = u_xlat2 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1.wwww + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _lineColor;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(_TransSize);
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlatb3 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb3) * -1))!=0){discard;}
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.wwww * u_xlat1;
    u_xlat2 = u_xlat16_2 * _lineColor;
    u_xlat2 = u_xlat2 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1.wwww + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _lineColor;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(_TransSize);
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlatb3 = u_xlat0.x<0.0;
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    if(((int(u_xlatb3) * -1))!=0){discard;}
    u_xlat3.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.wwww * u_xlat1;
    u_xlat2 = u_xlat16_2 * _lineColor;
    u_xlat2 = u_xlat2 + u_xlat2;
    u_xlat1 = u_xlat1 * u_xlat1.wwww + (-u_xlat2);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
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
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 73039
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _NoiseSize;
uniform 	float _NoiseMoveSpeed;
uniform 	vec4 _lineColor;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(_TransSize);
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = _Time.x * _NoiseMoveSpeed;
    u_xlat1.y = vs_TEXCOORD0.y * _NoiseSize + u_xlat3;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat10_3 = texture2D(_NoiseTex, u_xlat1.xy).x;
    u_xlat10_6 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat6 = u_xlat10_6 * vs_COLOR0.w;
    u_xlat16_2 = u_xlat6 * u_xlat10_3;
    u_xlat0.x = u_xlat0.x * (-u_xlat16_2) + u_xlat16_2;
    u_xlat0 = u_xlat0.xxxx * _lineColor;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _NoiseSize;
uniform 	float _NoiseMoveSpeed;
uniform 	vec4 _lineColor;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(_TransSize);
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = _Time.x * _NoiseMoveSpeed;
    u_xlat1.y = vs_TEXCOORD0.y * _NoiseSize + u_xlat3;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat10_3 = texture2D(_NoiseTex, u_xlat1.xy).x;
    u_xlat10_6 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat6 = u_xlat10_6 * vs_COLOR0.w;
    u_xlat16_2 = u_xlat6 * u_xlat10_3;
    u_xlat0.x = u_xlat0.x * (-u_xlat16_2) + u_xlat16_2;
    u_xlat0 = u_xlat0.xxxx * _lineColor;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _NoiseSize;
uniform 	float _NoiseMoveSpeed;
uniform 	vec4 _lineColor;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
lowp float u_xlat10_3;
float u_xlat6;
lowp float u_xlat10_6;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(_TransSize);
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = _Time.x * _NoiseMoveSpeed;
    u_xlat1.y = vs_TEXCOORD0.y * _NoiseSize + u_xlat3;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat10_3 = texture2D(_NoiseTex, u_xlat1.xy).x;
    u_xlat10_6 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat6 = u_xlat10_6 * vs_COLOR0.w;
    u_xlat16_2 = u_xlat6 * u_xlat10_3;
    u_xlat0.x = u_xlat0.x * (-u_xlat16_2) + u_xlat16_2;
    u_xlat0 = u_xlat0.xxxx * _lineColor;
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
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 177061
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _Cutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _lineColor;
uniform 	float _TransWidth;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vec2(_Cutoff) * _MainTex_TexelSize.yx;
    u_xlat0.yz = (-u_xlat0.xy);
    u_xlat0.x = float(-0.0);
    u_xlat0.w = float(-0.0);
    u_xlat1.xw = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = u_xlat0 + u_xlat1.xwxw;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat10_4 = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat1.yz = _MainTex_TexelSize.yx * vec2(_Cutoff) + u_xlat1.wx;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xw);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat10_8 = texture2D(_MainTex, u_xlat1.xy).w;
    u_xlat10_12 = texture2D(_MainTex, u_xlat1.zw).w;
    u_xlat16_3.x = min(u_xlat10_0.x, u_xlat10_8);
    u_xlat16_3.x = min(u_xlat10_12, u_xlat16_3.x);
    u_xlat16_3.x = min(u_xlat10_4, u_xlat16_3.x);
    u_xlat16_7 = max(u_xlat2.y, u_xlat2.x);
    u_xlat16_3.y = max(u_xlat2.z, u_xlat16_7);
    u_xlat0.xy = u_xlat16_3.xy + (-vec2(_TransWidth));
    u_xlat8 = u_xlat16_3.x * (-u_xlat16_3.y) + u_xlat16_3.y;
    u_xlat1.xyz = vec3(u_xlat8) * _lineColor.xyz;
    u_xlat4 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(vec2(_TransSize, _TransSize));
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat1.w = u_xlat0.x * (-u_xlat16_3.x) + u_xlat16_3.x;
    SV_Target0 = u_xlat1;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _Cutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _lineColor;
uniform 	float _TransWidth;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vec2(_Cutoff) * _MainTex_TexelSize.yx;
    u_xlat0.yz = (-u_xlat0.xy);
    u_xlat0.x = float(-0.0);
    u_xlat0.w = float(-0.0);
    u_xlat1.xw = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = u_xlat0 + u_xlat1.xwxw;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat10_4 = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat1.yz = _MainTex_TexelSize.yx * vec2(_Cutoff) + u_xlat1.wx;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xw);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat10_8 = texture2D(_MainTex, u_xlat1.xy).w;
    u_xlat10_12 = texture2D(_MainTex, u_xlat1.zw).w;
    u_xlat16_3.x = min(u_xlat10_0.x, u_xlat10_8);
    u_xlat16_3.x = min(u_xlat10_12, u_xlat16_3.x);
    u_xlat16_3.x = min(u_xlat10_4, u_xlat16_3.x);
    u_xlat16_7 = max(u_xlat2.y, u_xlat2.x);
    u_xlat16_3.y = max(u_xlat2.z, u_xlat16_7);
    u_xlat0.xy = u_xlat16_3.xy + (-vec2(_TransWidth));
    u_xlat8 = u_xlat16_3.x * (-u_xlat16_3.y) + u_xlat16_3.y;
    u_xlat1.xyz = vec3(u_xlat8) * _lineColor.xyz;
    u_xlat4 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(vec2(_TransSize, _TransSize));
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat1.w = u_xlat0.x * (-u_xlat16_3.x) + u_xlat16_3.x;
    SV_Target0 = u_xlat1;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	float _Cutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _lineColor;
uniform 	float _TransWidth;
uniform 	float _TransSize;
uniform 	float _ShowEffect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _TransTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
float u_xlat4;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
float u_xlat8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vec2(_Cutoff) * _MainTex_TexelSize.yx;
    u_xlat0.yz = (-u_xlat0.xy);
    u_xlat0.x = float(-0.0);
    u_xlat0.w = float(-0.0);
    u_xlat1.xw = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = u_xlat0 + u_xlat1.xwxw;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat10_4 = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat1.yz = _MainTex_TexelSize.yx * vec2(_Cutoff) + u_xlat1.wx;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xw);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat10_8 = texture2D(_MainTex, u_xlat1.xy).w;
    u_xlat10_12 = texture2D(_MainTex, u_xlat1.zw).w;
    u_xlat16_3.x = min(u_xlat10_0.x, u_xlat10_8);
    u_xlat16_3.x = min(u_xlat10_12, u_xlat16_3.x);
    u_xlat16_3.x = min(u_xlat10_4, u_xlat16_3.x);
    u_xlat16_7 = max(u_xlat2.y, u_xlat2.x);
    u_xlat16_3.y = max(u_xlat2.z, u_xlat16_7);
    u_xlat0.xy = u_xlat16_3.xy + (-vec2(_TransWidth));
    u_xlat8 = u_xlat16_3.x * (-u_xlat16_3.y) + u_xlat16_3.y;
    u_xlat1.xyz = vec3(u_xlat8) * _lineColor.xyz;
    u_xlat4 = float(1.0) / u_xlat0.y;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(vec2(_TransSize, _TransSize));
    u_xlat10_0.xy = texture2D(_TransTex, u_xlat0.xy).xw;
    u_xlat0.x = u_xlat10_0.x * u_xlat10_0.y + (-_ShowEffect);
    u_xlat0.x = u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat0.x * 5.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat1.w = u_xlat0.x * (-u_xlat16_3.x) + u_xlat16_3.x;
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
}
}
}
}