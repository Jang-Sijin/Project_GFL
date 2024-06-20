//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/SkyUseBox1" {
Properties {
_OneColor ("一边颜色", Color) = (0.5,0.5,0.5,0.5)
_OtherSideColor ("另一边颜色", Color) = (0,0,0,0)
_Direct ("方向", Vector) = (0,0,0,0)
_control ("控制", Float) = 1
_control1 ("控制1", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  Fog {
   Mode Off
  }
  GpuProgramID 49288
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump vec4 _Direct;
uniform 	mediump vec4 _OneColor;
uniform 	mediump vec4 _OtherSideColor;
uniform 	float _control;
uniform 	float _control1;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz + (-_Direct.xyz);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat16_0.xyz), _Direct.xyz);
    u_xlat1 = u_xlat16_0.x * _control + _control1;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_0 = _OneColor + (-_OtherSideColor);
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_0 + _OtherSideColor;
    u_xlat16_2 = u_xlat16_0.w * 0.200000003 + -1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_2<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
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
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump vec4 _Direct;
uniform 	mediump vec4 _OneColor;
uniform 	mediump vec4 _OtherSideColor;
uniform 	float _control;
uniform 	float _control1;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz + (-_Direct.xyz);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat16_0.xyz), _Direct.xyz);
    u_xlat1 = u_xlat16_0.x * _control + _control1;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_0 = _OneColor + (-_OtherSideColor);
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_0 + _OtherSideColor;
    u_xlat16_2 = u_xlat16_0.w * 0.200000003 + -1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_2<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
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
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump vec4 _Direct;
uniform 	mediump vec4 _OneColor;
uniform 	mediump vec4 _OtherSideColor;
uniform 	float _control;
uniform 	float _control1;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz + (-_Direct.xyz);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat16_0.xyz), _Direct.xyz);
    u_xlat1 = u_xlat16_0.x * _control + _control1;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_0 = _OneColor + (-_OtherSideColor);
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_0 + _OtherSideColor;
    u_xlat16_2 = u_xlat16_0.w * 0.200000003 + -1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003);
    SV_Target0 = u_xlat16_0;
    u_xlatb1 = u_xlat16_2<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
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