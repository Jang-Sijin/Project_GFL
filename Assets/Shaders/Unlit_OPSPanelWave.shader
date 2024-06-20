//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/OPSPanelWave" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_MoveTex ("MoveTexture", 2D) = "black" { }
_Color ("BaseColor", Color) = (1,1,1,1)
_HighColor ("顶层颜色", Color) = (1,1,1,1)
_LowColor ("底部颜色", Color) = (1,1,1,1)
_Control ("变化控制", Float) = 1
_NoiseAmp ("噪音抖动幅度附加", Range(0, 10)) = 1
_Noise ("噪音抖动频率", Float) = 1
_Amp ("增幅", Range(0, 10)) = 1
_CheckX ("X频率", Float) = 1
_CheckY ("Y频率", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 56952
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _HighColor;
uniform 	mediump vec4 _LowColor;
uniform 	float _Control;
uniform 	float _Amp;
uniform 	float _CheckX;
uniform 	float _CheckY;
uniform 	float _Noise;
uniform 	float _NoiseAmp;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(_CheckX, _CheckY);
    u_xlat10.x = _Control * 0.100000001;
    u_xlat0.xy = u_xlat0.xy * vec2(8.0, 8.0) + (-u_xlat10.xx);
    u_xlat10.xy = vec2(_CheckX, _CheckY) * in_TEXCOORD0.xy + u_xlat10.xx;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat1.y = sin(u_xlat0.y);
    u_xlat0.x = sin(u_xlat10.x);
    u_xlat0.y = cos(u_xlat10.y);
    u_xlat0.xy = u_xlat1.xy + u_xlat0.xy;
    u_xlat10.xy = u_xlat0.xy * vec2(_Noise);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat1.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat11.x = dot(u_xlat1.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat1.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat11.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat0.xy * vec2(_Noise) + (-u_xlat10.xy);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat2.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat5 = dot(u_xlat1.xy, u_xlat2.xy);
    u_xlat2 = u_xlat10.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.zw, vec2(127.099998, 311.700012));
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat12.x = dot(u_xlat2.zw, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat12.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat11.xyxy + vec4(-1.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat5 = u_xlat5 + (-u_xlat1.x);
    u_xlat12.xy = u_xlat11.xy * u_xlat11.xy;
    u_xlat13.xy = (-u_xlat11.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat12.xy = u_xlat12.xy * u_xlat13.xy;
    u_xlat5 = u_xlat12.x * u_xlat5 + u_xlat1.x;
    u_xlat1.x = dot(u_xlat10.xy, vec2(127.099998, 311.700012));
    u_xlat10.x = dot(u_xlat10.xy, vec2(269.5, 183.300003));
    u_xlat4.y = sin(u_xlat10.x);
    u_xlat4.x = sin(u_xlat1.x);
    u_xlat10.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat11.xy);
    u_xlat15 = dot(u_xlat2.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat2.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat15);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat15 = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat12.x * u_xlat15 + u_xlat10.x;
    u_xlat5 = (-u_xlat10.x) + u_xlat5;
    u_xlat5 = u_xlat12.y * u_xlat5 + u_xlat10.x;
    u_xlat5 = u_xlat5 * _NoiseAmp;
    u_xlat0.x = _Amp * u_xlat0.x + u_xlat5;
    u_xlat5 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2 = u_xlat5;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = _HighColor + (-_LowColor);
    vs_TEXCOORD1 = vec4(u_xlat5) * u_xlat1 + _LowColor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.y = u_xlat0.x * 0.400000006 + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.x * 10.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + u_xlat0.xx;
    u_xlat1.x = sin(u_xlat0.x);
    u_xlat1.y = cos(u_xlat0.y);
    u_xlat10_0 = texture2D(_MoveTex, u_xlat1.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat0 * vs_TEXCOORD1;
    u_xlat0 = u_xlat0 * vec4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
    u_xlat1.x = vs_TEXCOORD2 + -1.0;
    u_xlat1.x = u_xlat0.w * abs(u_xlat1.x);
    u_xlat0.w = u_xlat1.x * 0.100000001;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_1 * vs_TEXCOORD1 + u_xlat0;
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
uniform 	mediump vec4 _HighColor;
uniform 	mediump vec4 _LowColor;
uniform 	float _Control;
uniform 	float _Amp;
uniform 	float _CheckX;
uniform 	float _CheckY;
uniform 	float _Noise;
uniform 	float _NoiseAmp;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(_CheckX, _CheckY);
    u_xlat10.x = _Control * 0.100000001;
    u_xlat0.xy = u_xlat0.xy * vec2(8.0, 8.0) + (-u_xlat10.xx);
    u_xlat10.xy = vec2(_CheckX, _CheckY) * in_TEXCOORD0.xy + u_xlat10.xx;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat1.y = sin(u_xlat0.y);
    u_xlat0.x = sin(u_xlat10.x);
    u_xlat0.y = cos(u_xlat10.y);
    u_xlat0.xy = u_xlat1.xy + u_xlat0.xy;
    u_xlat10.xy = u_xlat0.xy * vec2(_Noise);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat1.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat11.x = dot(u_xlat1.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat1.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat11.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat0.xy * vec2(_Noise) + (-u_xlat10.xy);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat2.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat5 = dot(u_xlat1.xy, u_xlat2.xy);
    u_xlat2 = u_xlat10.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.zw, vec2(127.099998, 311.700012));
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat12.x = dot(u_xlat2.zw, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat12.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat11.xyxy + vec4(-1.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat5 = u_xlat5 + (-u_xlat1.x);
    u_xlat12.xy = u_xlat11.xy * u_xlat11.xy;
    u_xlat13.xy = (-u_xlat11.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat12.xy = u_xlat12.xy * u_xlat13.xy;
    u_xlat5 = u_xlat12.x * u_xlat5 + u_xlat1.x;
    u_xlat1.x = dot(u_xlat10.xy, vec2(127.099998, 311.700012));
    u_xlat10.x = dot(u_xlat10.xy, vec2(269.5, 183.300003));
    u_xlat4.y = sin(u_xlat10.x);
    u_xlat4.x = sin(u_xlat1.x);
    u_xlat10.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat11.xy);
    u_xlat15 = dot(u_xlat2.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat2.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat15);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat15 = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat12.x * u_xlat15 + u_xlat10.x;
    u_xlat5 = (-u_xlat10.x) + u_xlat5;
    u_xlat5 = u_xlat12.y * u_xlat5 + u_xlat10.x;
    u_xlat5 = u_xlat5 * _NoiseAmp;
    u_xlat0.x = _Amp * u_xlat0.x + u_xlat5;
    u_xlat5 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2 = u_xlat5;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = _HighColor + (-_LowColor);
    vs_TEXCOORD1 = vec4(u_xlat5) * u_xlat1 + _LowColor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.y = u_xlat0.x * 0.400000006 + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.x * 10.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + u_xlat0.xx;
    u_xlat1.x = sin(u_xlat0.x);
    u_xlat1.y = cos(u_xlat0.y);
    u_xlat10_0 = texture2D(_MoveTex, u_xlat1.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat0 * vs_TEXCOORD1;
    u_xlat0 = u_xlat0 * vec4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
    u_xlat1.x = vs_TEXCOORD2 + -1.0;
    u_xlat1.x = u_xlat0.w * abs(u_xlat1.x);
    u_xlat0.w = u_xlat1.x * 0.100000001;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_1 * vs_TEXCOORD1 + u_xlat0;
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
uniform 	mediump vec4 _HighColor;
uniform 	mediump vec4 _LowColor;
uniform 	float _Control;
uniform 	float _Amp;
uniform 	float _CheckX;
uniform 	float _CheckY;
uniform 	float _Noise;
uniform 	float _NoiseAmp;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(_CheckX, _CheckY);
    u_xlat10.x = _Control * 0.100000001;
    u_xlat0.xy = u_xlat0.xy * vec2(8.0, 8.0) + (-u_xlat10.xx);
    u_xlat10.xy = vec2(_CheckX, _CheckY) * in_TEXCOORD0.xy + u_xlat10.xx;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat1.y = sin(u_xlat0.y);
    u_xlat0.x = sin(u_xlat10.x);
    u_xlat0.y = cos(u_xlat10.y);
    u_xlat0.xy = u_xlat1.xy + u_xlat0.xy;
    u_xlat10.xy = u_xlat0.xy * vec2(_Noise);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat1.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat11.x = dot(u_xlat1.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat1.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat11.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat0.xy * vec2(_Noise) + (-u_xlat10.xy);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat2.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat5 = dot(u_xlat1.xy, u_xlat2.xy);
    u_xlat2 = u_xlat10.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.zw, vec2(127.099998, 311.700012));
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat12.x = dot(u_xlat2.zw, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat12.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat11.xyxy + vec4(-1.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat5 = u_xlat5 + (-u_xlat1.x);
    u_xlat12.xy = u_xlat11.xy * u_xlat11.xy;
    u_xlat13.xy = (-u_xlat11.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat12.xy = u_xlat12.xy * u_xlat13.xy;
    u_xlat5 = u_xlat12.x * u_xlat5 + u_xlat1.x;
    u_xlat1.x = dot(u_xlat10.xy, vec2(127.099998, 311.700012));
    u_xlat10.x = dot(u_xlat10.xy, vec2(269.5, 183.300003));
    u_xlat4.y = sin(u_xlat10.x);
    u_xlat4.x = sin(u_xlat1.x);
    u_xlat10.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat11.xy);
    u_xlat15 = dot(u_xlat2.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat2.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat15);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat15 = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat12.x * u_xlat15 + u_xlat10.x;
    u_xlat5 = (-u_xlat10.x) + u_xlat5;
    u_xlat5 = u_xlat12.y * u_xlat5 + u_xlat10.x;
    u_xlat5 = u_xlat5 * _NoiseAmp;
    u_xlat0.x = _Amp * u_xlat0.x + u_xlat5;
    u_xlat5 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2 = u_xlat5;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = _HighColor + (-_LowColor);
    vs_TEXCOORD1 = vec4(u_xlat5) * u_xlat1 + _LowColor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.y = u_xlat0.x * 0.400000006 + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.x * 10.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + u_xlat0.xx;
    u_xlat1.x = sin(u_xlat0.x);
    u_xlat1.y = cos(u_xlat0.y);
    u_xlat10_0 = texture2D(_MoveTex, u_xlat1.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat0 * vs_TEXCOORD1;
    u_xlat0 = u_xlat0 * vec4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
    u_xlat1.x = vs_TEXCOORD2 + -1.0;
    u_xlat1.x = u_xlat0.w * abs(u_xlat1.x);
    u_xlat0.w = u_xlat1.x * 0.100000001;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_1 * vs_TEXCOORD1 + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _HighColor;
uniform 	mediump vec4 _LowColor;
uniform 	float _Control;
uniform 	float _Amp;
uniform 	float _CheckX;
uniform 	float _CheckY;
uniform 	float _Noise;
uniform 	float _NoiseAmp;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(_CheckX, _CheckY);
    u_xlat10.x = _Control * 0.100000001;
    u_xlat0.xy = u_xlat0.xy * vec2(8.0, 8.0) + (-u_xlat10.xx);
    u_xlat10.xy = vec2(_CheckX, _CheckY) * in_TEXCOORD0.xy + u_xlat10.xx;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat1.y = sin(u_xlat0.y);
    u_xlat0.x = sin(u_xlat10.x);
    u_xlat0.y = cos(u_xlat10.y);
    u_xlat0.xy = u_xlat1.xy + u_xlat0.xy;
    u_xlat10.xy = u_xlat0.xy * vec2(_Noise);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat1.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat11.x = dot(u_xlat1.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat1.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat11.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat0.xy * vec2(_Noise) + (-u_xlat10.xy);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat2.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat5 = dot(u_xlat1.xy, u_xlat2.xy);
    u_xlat2 = u_xlat10.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.zw, vec2(127.099998, 311.700012));
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat12.x = dot(u_xlat2.zw, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat12.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat11.xyxy + vec4(-1.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat5 = u_xlat5 + (-u_xlat1.x);
    u_xlat12.xy = u_xlat11.xy * u_xlat11.xy;
    u_xlat13.xy = (-u_xlat11.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat12.xy = u_xlat12.xy * u_xlat13.xy;
    u_xlat5 = u_xlat12.x * u_xlat5 + u_xlat1.x;
    u_xlat1.x = dot(u_xlat10.xy, vec2(127.099998, 311.700012));
    u_xlat10.x = dot(u_xlat10.xy, vec2(269.5, 183.300003));
    u_xlat4.y = sin(u_xlat10.x);
    u_xlat4.x = sin(u_xlat1.x);
    u_xlat10.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat11.xy);
    u_xlat15 = dot(u_xlat2.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat2.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat15);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat15 = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat12.x * u_xlat15 + u_xlat10.x;
    u_xlat5 = (-u_xlat10.x) + u_xlat5;
    u_xlat5 = u_xlat12.y * u_xlat5 + u_xlat10.x;
    u_xlat5 = u_xlat5 * _NoiseAmp;
    u_xlat0.x = _Amp * u_xlat0.x + u_xlat5;
    u_xlat5 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2 = u_xlat5;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = _HighColor + (-_LowColor);
    vs_TEXCOORD1 = vec4(u_xlat5) * u_xlat1 + _LowColor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.y = u_xlat0.x * 0.400000006 + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.x * 10.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + u_xlat0.xx;
    u_xlat1.x = sin(u_xlat0.x);
    u_xlat1.y = cos(u_xlat0.y);
    u_xlat10_0 = texture2D(_MoveTex, u_xlat1.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat0 * vs_TEXCOORD1;
    u_xlat0 = u_xlat0 * vec4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
    u_xlat1.x = vs_TEXCOORD2 + -1.0;
    u_xlat1.x = u_xlat0.w * abs(u_xlat1.x);
    u_xlat0.w = u_xlat1.x * 0.100000001;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_1 * vs_TEXCOORD1 + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _HighColor;
uniform 	mediump vec4 _LowColor;
uniform 	float _Control;
uniform 	float _Amp;
uniform 	float _CheckX;
uniform 	float _CheckY;
uniform 	float _Noise;
uniform 	float _NoiseAmp;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(_CheckX, _CheckY);
    u_xlat10.x = _Control * 0.100000001;
    u_xlat0.xy = u_xlat0.xy * vec2(8.0, 8.0) + (-u_xlat10.xx);
    u_xlat10.xy = vec2(_CheckX, _CheckY) * in_TEXCOORD0.xy + u_xlat10.xx;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat1.y = sin(u_xlat0.y);
    u_xlat0.x = sin(u_xlat10.x);
    u_xlat0.y = cos(u_xlat10.y);
    u_xlat0.xy = u_xlat1.xy + u_xlat0.xy;
    u_xlat10.xy = u_xlat0.xy * vec2(_Noise);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat1.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat11.x = dot(u_xlat1.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat1.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat11.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat0.xy * vec2(_Noise) + (-u_xlat10.xy);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat2.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat5 = dot(u_xlat1.xy, u_xlat2.xy);
    u_xlat2 = u_xlat10.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.zw, vec2(127.099998, 311.700012));
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat12.x = dot(u_xlat2.zw, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat12.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat11.xyxy + vec4(-1.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat5 = u_xlat5 + (-u_xlat1.x);
    u_xlat12.xy = u_xlat11.xy * u_xlat11.xy;
    u_xlat13.xy = (-u_xlat11.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat12.xy = u_xlat12.xy * u_xlat13.xy;
    u_xlat5 = u_xlat12.x * u_xlat5 + u_xlat1.x;
    u_xlat1.x = dot(u_xlat10.xy, vec2(127.099998, 311.700012));
    u_xlat10.x = dot(u_xlat10.xy, vec2(269.5, 183.300003));
    u_xlat4.y = sin(u_xlat10.x);
    u_xlat4.x = sin(u_xlat1.x);
    u_xlat10.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat11.xy);
    u_xlat15 = dot(u_xlat2.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat2.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat15);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat15 = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat12.x * u_xlat15 + u_xlat10.x;
    u_xlat5 = (-u_xlat10.x) + u_xlat5;
    u_xlat5 = u_xlat12.y * u_xlat5 + u_xlat10.x;
    u_xlat5 = u_xlat5 * _NoiseAmp;
    u_xlat0.x = _Amp * u_xlat0.x + u_xlat5;
    u_xlat5 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2 = u_xlat5;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = _HighColor + (-_LowColor);
    vs_TEXCOORD1 = vec4(u_xlat5) * u_xlat1 + _LowColor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.y = u_xlat0.x * 0.400000006 + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.x * 10.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + u_xlat0.xx;
    u_xlat1.x = sin(u_xlat0.x);
    u_xlat1.y = cos(u_xlat0.y);
    u_xlat10_0 = texture2D(_MoveTex, u_xlat1.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat0 * vs_TEXCOORD1;
    u_xlat0 = u_xlat0 * vec4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
    u_xlat1.x = vs_TEXCOORD2 + -1.0;
    u_xlat1.x = u_xlat0.w * abs(u_xlat1.x);
    u_xlat0.w = u_xlat1.x * 0.100000001;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_1 * vs_TEXCOORD1 + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _HighColor;
uniform 	mediump vec4 _LowColor;
uniform 	float _Control;
uniform 	float _Amp;
uniform 	float _CheckX;
uniform 	float _CheckY;
uniform 	float _Noise;
uniform 	float _NoiseAmp;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec2 u_xlat10;
vec2 u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(_CheckX, _CheckY);
    u_xlat10.x = _Control * 0.100000001;
    u_xlat0.xy = u_xlat0.xy * vec2(8.0, 8.0) + (-u_xlat10.xx);
    u_xlat10.xy = vec2(_CheckX, _CheckY) * in_TEXCOORD0.xy + u_xlat10.xx;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat1.y = sin(u_xlat0.y);
    u_xlat0.x = sin(u_xlat10.x);
    u_xlat0.y = cos(u_xlat10.y);
    u_xlat0.xy = u_xlat1.xy + u_xlat0.xy;
    u_xlat10.xy = u_xlat0.xy * vec2(_Noise);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat1.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat11.x = dot(u_xlat1.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat1.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat11.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat0.xy * vec2(_Noise) + (-u_xlat10.xy);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat2.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat5 = dot(u_xlat1.xy, u_xlat2.xy);
    u_xlat2 = u_xlat10.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.zw, vec2(127.099998, 311.700012));
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat12.x = dot(u_xlat2.zw, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat12.x);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat11.xyxy + vec4(-1.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat5 = u_xlat5 + (-u_xlat1.x);
    u_xlat12.xy = u_xlat11.xy * u_xlat11.xy;
    u_xlat13.xy = (-u_xlat11.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat12.xy = u_xlat12.xy * u_xlat13.xy;
    u_xlat5 = u_xlat12.x * u_xlat5 + u_xlat1.x;
    u_xlat1.x = dot(u_xlat10.xy, vec2(127.099998, 311.700012));
    u_xlat10.x = dot(u_xlat10.xy, vec2(269.5, 183.300003));
    u_xlat4.y = sin(u_xlat10.x);
    u_xlat4.x = sin(u_xlat1.x);
    u_xlat10.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.x = dot(u_xlat10.xy, u_xlat11.xy);
    u_xlat15 = dot(u_xlat2.xy, vec2(127.099998, 311.700012));
    u_xlat1.x = dot(u_xlat2.xy, vec2(269.5, 183.300003));
    u_xlat1.y = sin(u_xlat1.x);
    u_xlat1.x = sin(u_xlat15);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat15 = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat15 = (-u_xlat10.x) + u_xlat15;
    u_xlat10.x = u_xlat12.x * u_xlat15 + u_xlat10.x;
    u_xlat5 = (-u_xlat10.x) + u_xlat5;
    u_xlat5 = u_xlat12.y * u_xlat5 + u_xlat10.x;
    u_xlat5 = u_xlat5 * _NoiseAmp;
    u_xlat0.x = _Amp * u_xlat0.x + u_xlat5;
    u_xlat5 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2 = u_xlat5;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = _HighColor + (-_LowColor);
    vs_TEXCOORD1 = vec4(u_xlat5) * u_xlat1 + _LowColor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.y = u_xlat0.x * 0.400000006 + u_xlat1.y;
    gl_Position.xzw = u_xlat1.xzw;
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
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MoveTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.x * 10.0;
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + u_xlat0.xx;
    u_xlat1.x = sin(u_xlat0.x);
    u_xlat1.y = cos(u_xlat0.y);
    u_xlat10_0 = texture2D(_MoveTex, u_xlat1.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0 = u_xlat0 * vs_TEXCOORD1;
    u_xlat0 = u_xlat0 * vec4(0.300000012, 0.300000012, 0.300000012, 0.300000012);
    u_xlat1.x = vs_TEXCOORD2 + -1.0;
    u_xlat1.x = u_xlat0.w * abs(u_xlat1.x);
    u_xlat0.w = u_xlat1.x * 0.100000001;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_1 * vs_TEXCOORD1 + u_xlat0;
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