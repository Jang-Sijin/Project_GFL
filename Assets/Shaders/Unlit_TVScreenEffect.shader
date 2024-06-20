//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/TVScreenEffect" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Tint ("Tint", Color) = (1,1,1,1)
_ScanTex ("_ScanTex", 2D) = "black" { }
_ScanDisturb ("扫描干扰_ScanDisturb", Range(0, 0.2)) = 0.1
_ScanDistance ("扫描间距_ScanDistance", Float) = 1
_ScanSpeed ("扫描速度_ScanSpeed", Float) = 1
_NoiseAmount ("噪声量_NoiseAmount", Range(0, 1)) = 0
_dis ("鱼眼层度", Float) = 0
_disColor ("鱼眼周边颜色", Color) = (0,0,0,0)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 60787
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
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
uniform 	vec4 _ScanTex_ST;
uniform 	float _ScanDistance;
uniform 	float _ScanSpeed;
uniform 	float _ScanDisturb;
uniform 	float _NoiseAmount;
uniform 	mediump vec4 _Tint;
uniform 	float _dis;
uniform 	vec4 _disColor;
uniform lowp sampler2D _ScanTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
lowp float u_xlat10_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.z = 1.0;
    u_xlat1 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat1 = log2(u_xlat1);
    u_xlat1 = u_xlat1 * _dis;
    u_xlat1 = exp2(u_xlat1);
    u_xlat5.x = _Time.x * _ScanSpeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ScanTex_ST.xy + _ScanTex_ST.zw;
    u_xlat2.z = u_xlat2.y * _ScanDistance + u_xlat5.x;
    u_xlat10_5 = texture2D(_ScanTex, u_xlat2.xz).x;
    u_xlat5.xy = vec2(u_xlat10_5) * vec2(vec2(_ScanDisturb, _ScanDisturb)) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat5.xy * vec2(9999.0, 9999.0);
    u_xlat10_0 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat5.xy = floor(u_xlat2.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.x = dot(u_xlat5.xy, vec2(12.9898005, 78.2330017));
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * 43758.5469;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat2.xyz = u_xlat5.xxx * vec3(vec3(_NoiseAmount, _NoiseAmount, _NoiseAmount));
    u_xlat2.w = _NoiseAmount;
    u_xlat5.x = (-_NoiseAmount) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat5.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * _Tint;
    u_xlat5.xyz = u_xlat2.xyz * _disColor.xyz;
    u_xlat3.xyz = u_xlat0.xyz * _Tint.xyz + (-u_xlat5.xyz);
    u_xlat2.xyz = vec3(u_xlat1) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0 = u_xlat2;
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
attribute highp vec4 in_COLOR0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
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
uniform 	vec4 _ScanTex_ST;
uniform 	float _ScanDistance;
uniform 	float _ScanSpeed;
uniform 	float _ScanDisturb;
uniform 	float _NoiseAmount;
uniform 	mediump vec4 _Tint;
uniform 	float _dis;
uniform 	vec4 _disColor;
uniform lowp sampler2D _ScanTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
lowp float u_xlat10_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.z = 1.0;
    u_xlat1 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat1 = log2(u_xlat1);
    u_xlat1 = u_xlat1 * _dis;
    u_xlat1 = exp2(u_xlat1);
    u_xlat5.x = _Time.x * _ScanSpeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ScanTex_ST.xy + _ScanTex_ST.zw;
    u_xlat2.z = u_xlat2.y * _ScanDistance + u_xlat5.x;
    u_xlat10_5 = texture2D(_ScanTex, u_xlat2.xz).x;
    u_xlat5.xy = vec2(u_xlat10_5) * vec2(vec2(_ScanDisturb, _ScanDisturb)) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat5.xy * vec2(9999.0, 9999.0);
    u_xlat10_0 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat5.xy = floor(u_xlat2.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.x = dot(u_xlat5.xy, vec2(12.9898005, 78.2330017));
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * 43758.5469;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat2.xyz = u_xlat5.xxx * vec3(vec3(_NoiseAmount, _NoiseAmount, _NoiseAmount));
    u_xlat2.w = _NoiseAmount;
    u_xlat5.x = (-_NoiseAmount) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat5.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * _Tint;
    u_xlat5.xyz = u_xlat2.xyz * _disColor.xyz;
    u_xlat3.xyz = u_xlat0.xyz * _Tint.xyz + (-u_xlat5.xyz);
    u_xlat2.xyz = vec3(u_xlat1) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0 = u_xlat2;
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
attribute highp vec4 in_COLOR0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
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
uniform 	vec4 _ScanTex_ST;
uniform 	float _ScanDistance;
uniform 	float _ScanSpeed;
uniform 	float _ScanDisturb;
uniform 	float _NoiseAmount;
uniform 	mediump vec4 _Tint;
uniform 	float _dis;
uniform 	vec4 _disColor;
uniform lowp sampler2D _ScanTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
lowp float u_xlat10_5;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.z = 1.0;
    u_xlat1 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat1 = log2(u_xlat1);
    u_xlat1 = u_xlat1 * _dis;
    u_xlat1 = exp2(u_xlat1);
    u_xlat5.x = _Time.x * _ScanSpeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ScanTex_ST.xy + _ScanTex_ST.zw;
    u_xlat2.z = u_xlat2.y * _ScanDistance + u_xlat5.x;
    u_xlat10_5 = texture2D(_ScanTex, u_xlat2.xz).x;
    u_xlat5.xy = vec2(u_xlat10_5) * vec2(vec2(_ScanDisturb, _ScanDisturb)) + vs_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat5.xy * vec2(9999.0, 9999.0);
    u_xlat10_0 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat5.xy = floor(u_xlat2.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.x = dot(u_xlat5.xy, vec2(12.9898005, 78.2330017));
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * 43758.5469;
    u_xlat5.x = fract(u_xlat5.x);
    u_xlat2.xyz = u_xlat5.xxx * vec3(vec3(_NoiseAmount, _NoiseAmount, _NoiseAmount));
    u_xlat2.w = _NoiseAmount;
    u_xlat5.x = (-_NoiseAmount) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat5.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * _Tint;
    u_xlat5.xyz = u_xlat2.xyz * _disColor.xyz;
    u_xlat3.xyz = u_xlat0.xyz * _Tint.xyz + (-u_xlat5.xyz);
    u_xlat2.xyz = vec3(u_xlat1) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0 = u_xlat2;
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