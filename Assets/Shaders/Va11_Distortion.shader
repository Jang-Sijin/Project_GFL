//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Va11/Distortion" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_NoiseTex ("扭曲图_NoiseTex", 2D) = "white" { }
_Range ("幅度_Range", Range(0, 1)) = 0
_UVScale ("UV缩放_UVScale", Range(0.001, 1)) = 1
_Alpha ("透明度", Float) = 0.5
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IngnoreProjector" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IngnoreProjector" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 24672
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_0;
varying mediump float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = _Time.x * 43758.5469;
    u_xlat0.z = sin(u_xlat0.x);
    u_xlat0.xy = in_TEXCOORD0.xy;
    phase0_Output0_0.xyz = u_xlat0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_0.xy;
vs_TEXCOORD1 = phase0_Output0_0.z;
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
uniform 	mediump float _Range;
uniform 	mediump float _UVScale;
uniform 	float _Alpha;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0.y = vs_TEXCOORD1;
    u_xlat16_0.x = float(0.0);
    u_xlat16_6.y = float(0.0);
    u_xlat16_0.xy = u_xlat16_0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_UVScale, _UVScale));
    u_xlat10_1.x = texture2D(_NoiseTex, u_xlat16_0.xy).x;
    u_xlat16_0.x = u_xlat10_1.x * _Range;
    u_xlat16_6.x = u_xlat16_0.x * vs_TEXCOORD1;
    u_xlat16_0.xy = u_xlat16_6.xy + vs_TEXCOORD0.xy;
    u_xlat1.xy = vec2(_Range) * vec2(0.100000001, -0.100000001) + u_xlat16_0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(0.0, 1.0, 0.5);
    u_xlat16_2.w = u_xlat10_1.w * _Alpha;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(1.0, 0.0, 0.5);
    u_xlat16_1.w = u_xlat10_0.w * _Alpha;
    u_xlat16_0 = u_xlat16_2 + u_xlat16_1;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_0;
varying mediump float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = _Time.x * 43758.5469;
    u_xlat0.z = sin(u_xlat0.x);
    u_xlat0.xy = in_TEXCOORD0.xy;
    phase0_Output0_0.xyz = u_xlat0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_0.xy;
vs_TEXCOORD1 = phase0_Output0_0.z;
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
uniform 	mediump float _Range;
uniform 	mediump float _UVScale;
uniform 	float _Alpha;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0.y = vs_TEXCOORD1;
    u_xlat16_0.x = float(0.0);
    u_xlat16_6.y = float(0.0);
    u_xlat16_0.xy = u_xlat16_0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_UVScale, _UVScale));
    u_xlat10_1.x = texture2D(_NoiseTex, u_xlat16_0.xy).x;
    u_xlat16_0.x = u_xlat10_1.x * _Range;
    u_xlat16_6.x = u_xlat16_0.x * vs_TEXCOORD1;
    u_xlat16_0.xy = u_xlat16_6.xy + vs_TEXCOORD0.xy;
    u_xlat1.xy = vec2(_Range) * vec2(0.100000001, -0.100000001) + u_xlat16_0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(0.0, 1.0, 0.5);
    u_xlat16_2.w = u_xlat10_1.w * _Alpha;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(1.0, 0.0, 0.5);
    u_xlat16_1.w = u_xlat10_0.w * _Alpha;
    u_xlat16_0 = u_xlat16_2 + u_xlat16_1;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_0;
varying mediump float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = _Time.x * 43758.5469;
    u_xlat0.z = sin(u_xlat0.x);
    u_xlat0.xy = in_TEXCOORD0.xy;
    phase0_Output0_0.xyz = u_xlat0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_0.xy;
vs_TEXCOORD1 = phase0_Output0_0.z;
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
uniform 	mediump float _Range;
uniform 	mediump float _UVScale;
uniform 	float _Alpha;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat16_0.y = vs_TEXCOORD1;
    u_xlat16_0.x = float(0.0);
    u_xlat16_6.y = float(0.0);
    u_xlat16_0.xy = u_xlat16_0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_UVScale, _UVScale));
    u_xlat10_1.x = texture2D(_NoiseTex, u_xlat16_0.xy).x;
    u_xlat16_0.x = u_xlat10_1.x * _Range;
    u_xlat16_6.x = u_xlat16_0.x * vs_TEXCOORD1;
    u_xlat16_0.xy = u_xlat16_6.xy + vs_TEXCOORD0.xy;
    u_xlat1.xy = vec2(_Range) * vec2(0.100000001, -0.100000001) + u_xlat16_0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(0.0, 1.0, 0.5);
    u_xlat16_2.w = u_xlat10_1.w * _Alpha;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(1.0, 0.0, 0.5);
    u_xlat16_1.w = u_xlat10_0.w * _Alpha;
    u_xlat16_0 = u_xlat16_2 + u_xlat16_1;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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