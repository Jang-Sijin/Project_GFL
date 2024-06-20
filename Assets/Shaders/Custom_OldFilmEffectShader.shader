//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/OldFilmEffectShader" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_NoiseTex ("Noise Tex (RGB)", 2D) = "black" { }
_NoiseAnmSpeed ("Noise Animation Speed", Float) = 1
_NoiseStrength ("Noise Strength", Float) = 1
__PixelColor ("_Pixel Color", Color) = (1,1,1,1)
_EffectAmount ("Old Film Effect Amount", Range(0, 1)) = 1
_RandomValue ("Random Value", Float) = 1
}
SubShader {
 Pass {
  GpuProgramID 50555
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseAnmSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5508, 43758.5508);
    u_xlat4.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat0.zw = u_xlat4.xy * vec2(43758.5508, 43758.5508);
    u_xlat0 = fract(u_xlat0);
    u_xlat0.xy = u_xlat0.zw + u_xlat0.xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(_NoiseAnmSpeed) + u_xlat4.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _PixelColor;
uniform 	mediump float _NoiseStrength;
uniform 	mediump float _EffectAmount;
uniform 	mediump float _RandomValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture2D(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) * vec3(vec3(_NoiseStrength, _NoiseStrength, _NoiseStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0 = vec4(vec4(_RandomValue, _RandomValue, _RandomValue, _RandomValue)) * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + _PixelColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_13 = dot(vec3(0.298999995, 0.287, 0.114), u_xlat10_2.xyz);
    u_xlat16_0 = u_xlat16_0 + vec4(u_xlat16_13);
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0 = (-u_xlat10_2) + u_xlat16_0;
    SV_Target0 = vec4(vec4(_EffectAmount, _EffectAmount, _EffectAmount, _EffectAmount)) * u_xlat16_0 + u_xlat10_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseAnmSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5508, 43758.5508);
    u_xlat4.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat0.zw = u_xlat4.xy * vec2(43758.5508, 43758.5508);
    u_xlat0 = fract(u_xlat0);
    u_xlat0.xy = u_xlat0.zw + u_xlat0.xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(_NoiseAnmSpeed) + u_xlat4.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _PixelColor;
uniform 	mediump float _NoiseStrength;
uniform 	mediump float _EffectAmount;
uniform 	mediump float _RandomValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture2D(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) * vec3(vec3(_NoiseStrength, _NoiseStrength, _NoiseStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0 = vec4(vec4(_RandomValue, _RandomValue, _RandomValue, _RandomValue)) * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + _PixelColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_13 = dot(vec3(0.298999995, 0.287, 0.114), u_xlat10_2.xyz);
    u_xlat16_0 = u_xlat16_0 + vec4(u_xlat16_13);
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0 = (-u_xlat10_2) + u_xlat16_0;
    SV_Target0 = vec4(vec4(_EffectAmount, _EffectAmount, _EffectAmount, _EffectAmount)) * u_xlat16_0 + u_xlat10_2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseAnmSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5508, 43758.5508);
    u_xlat4.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat0.zw = u_xlat4.xy * vec2(43758.5508, 43758.5508);
    u_xlat0 = fract(u_xlat0);
    u_xlat0.xy = u_xlat0.zw + u_xlat0.xy;
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(_NoiseAnmSpeed) + u_xlat4.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _PixelColor;
uniform 	mediump float _NoiseStrength;
uniform 	mediump float _EffectAmount;
uniform 	mediump float _RandomValue;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.xyz = texture2D(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) * vec3(vec3(_NoiseStrength, _NoiseStrength, _NoiseStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0 = vec4(vec4(_RandomValue, _RandomValue, _RandomValue, _RandomValue)) * vec4(0.00999999978, 0.00999999978, 0.00999999978, 0.00999999978) + _PixelColor;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_13 = dot(vec3(0.298999995, 0.287, 0.114), u_xlat10_2.xyz);
    u_xlat16_0 = u_xlat16_0 + vec4(u_xlat16_13);
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0 = (-u_xlat10_2) + u_xlat16_0;
    SV_Target0 = vec4(vec4(_EffectAmount, _EffectAmount, _EffectAmount, _EffectAmount)) * u_xlat16_0 + u_xlat10_2;
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