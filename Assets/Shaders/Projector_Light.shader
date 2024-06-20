//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Projector/Light" {
Properties {
_FarColor ("FarColor", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Distance ("Distance", Float) = 100
_ShadowTex ("Cookie", 2D) = "" { }
_FalloffTex ("FallOff", 2D) = "" { }
_Bright ("Bright", Float) = 1
_Control ("Control", Float) = 0
_MoveSpeed ("MoveSpeed", Float) = -200
_Hight ("hight", Float) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ColorMask RGB 0
  ZWrite Off
  Offset -1, -1
  GpuProgramID 23343
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_NORMAL0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_Projector[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FarColor;
uniform 	float _MoveSpeed;
uniform 	float _Bright;
uniform 	float _Control;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _FalloffTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat13;
lowp float u_xlat10_13;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_4.x = vs_NORMAL0.y * u_xlat16_0.x + -0.00999999978;
    u_xlat16_0.xzw = u_xlat16_0.xxx * vs_NORMAL0.xyz;
    u_xlatb1 = u_xlat16_4.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.xyz = (-hlslcc_FragCoord.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_0.x = dot((-u_xlat1.xyz), u_xlat16_0.xzw);
    u_xlat1.xyz = _Color.xyz + (-_FarColor.xyz);
    u_xlat1.xyz = abs(u_xlat16_0.xxx) * u_xlat1.xyz + _FarColor.xyz;
    u_xlat13 = _Time.x * _MoveSpeed + _Control;
    u_xlat2.xy = vec2(u_xlat13) + vs_TEXCOORD0.xy;
    u_xlat13 = u_xlat13 * 0.200000003 + vs_TEXCOORD0.x;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_Projector[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[0].xyw * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[2].xyw * vs_TEXCOORD0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[3].xyw * vs_TEXCOORD0.www + u_xlat2.xyz;
    u_xlat16_0.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat10_2.xyz = texture2D(_ShadowTex, u_xlat16_0.xy).xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_Projector[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[0].xyw * vec3(u_xlat13) + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[2].xyw * vs_TEXCOORD0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[3].xyw * vs_TEXCOORD0.www + u_xlat3.xyz;
    u_xlat16_0.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture2D(_ShadowTex, u_xlat16_0.xy).xyz;
    u_xlat10_13 = texture2D(_FalloffTex, u_xlat16_0.xy).w;
    u_xlat16_0.xyz = u_xlat10_2.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat10_13) * u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat16_0.x * 0.5;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(vec3(_Bright, _Bright, _Bright)) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x;
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
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_NORMAL0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_Projector[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FarColor;
uniform 	float _MoveSpeed;
uniform 	float _Bright;
uniform 	float _Control;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _FalloffTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat13;
lowp float u_xlat10_13;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_4.x = vs_NORMAL0.y * u_xlat16_0.x + -0.00999999978;
    u_xlat16_0.xzw = u_xlat16_0.xxx * vs_NORMAL0.xyz;
    u_xlatb1 = u_xlat16_4.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.xyz = (-hlslcc_FragCoord.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_0.x = dot((-u_xlat1.xyz), u_xlat16_0.xzw);
    u_xlat1.xyz = _Color.xyz + (-_FarColor.xyz);
    u_xlat1.xyz = abs(u_xlat16_0.xxx) * u_xlat1.xyz + _FarColor.xyz;
    u_xlat13 = _Time.x * _MoveSpeed + _Control;
    u_xlat2.xy = vec2(u_xlat13) + vs_TEXCOORD0.xy;
    u_xlat13 = u_xlat13 * 0.200000003 + vs_TEXCOORD0.x;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_Projector[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[0].xyw * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[2].xyw * vs_TEXCOORD0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[3].xyw * vs_TEXCOORD0.www + u_xlat2.xyz;
    u_xlat16_0.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat10_2.xyz = texture2D(_ShadowTex, u_xlat16_0.xy).xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_Projector[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[0].xyw * vec3(u_xlat13) + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[2].xyw * vs_TEXCOORD0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[3].xyw * vs_TEXCOORD0.www + u_xlat3.xyz;
    u_xlat16_0.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture2D(_ShadowTex, u_xlat16_0.xy).xyz;
    u_xlat10_13 = texture2D(_FalloffTex, u_xlat16_0.xy).w;
    u_xlat16_0.xyz = u_xlat10_2.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat10_13) * u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat16_0.x * 0.5;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(vec3(_Bright, _Bright, _Bright)) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x;
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
attribute mediump vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_NORMAL0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_Projector[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FarColor;
uniform 	float _MoveSpeed;
uniform 	float _Bright;
uniform 	float _Control;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _FalloffTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat13;
lowp float u_xlat10_13;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.x = dot(vs_NORMAL0.xyz, vs_NORMAL0.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_4.x = vs_NORMAL0.y * u_xlat16_0.x + -0.00999999978;
    u_xlat16_0.xzw = u_xlat16_0.xxx * vs_NORMAL0.xyz;
    u_xlatb1 = u_xlat16_4.x<0.0;
    if(((int(u_xlatb1) * -1))!=0){discard;}
    u_xlat1.xyz = (-hlslcc_FragCoord.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_0.x = dot((-u_xlat1.xyz), u_xlat16_0.xzw);
    u_xlat1.xyz = _Color.xyz + (-_FarColor.xyz);
    u_xlat1.xyz = abs(u_xlat16_0.xxx) * u_xlat1.xyz + _FarColor.xyz;
    u_xlat13 = _Time.x * _MoveSpeed + _Control;
    u_xlat2.xy = vec2(u_xlat13) + vs_TEXCOORD0.xy;
    u_xlat13 = u_xlat13 * 0.200000003 + vs_TEXCOORD0.x;
    u_xlat6.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_Projector[1].xyw;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[0].xyw * u_xlat2.xxx + u_xlat6.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[2].xyw * vs_TEXCOORD0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_Projector[3].xyw * vs_TEXCOORD0.www + u_xlat2.xyz;
    u_xlat16_0.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat10_2.xyz = texture2D(_ShadowTex, u_xlat16_0.xy).xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_Projector[1].xyw;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[0].xyw * vec3(u_xlat13) + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[2].xyw * vs_TEXCOORD0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_Projector[3].xyw * vs_TEXCOORD0.www + u_xlat3.xyz;
    u_xlat16_0.xy = u_xlat3.xy / u_xlat3.zz;
    u_xlat10_3.xyz = texture2D(_ShadowTex, u_xlat16_0.xy).xyz;
    u_xlat10_13 = texture2D(_FalloffTex, u_xlat16_0.xy).w;
    u_xlat16_0.xyz = u_xlat10_2.xyz + u_xlat10_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat10_13) * u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat16_0.x * 0.5;
    u_xlat1.xyz = u_xlat16_4.xyz * vec3(vec3(_Bright, _Bright, _Bright)) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat1.xyz;
    SV_Target0.w = u_xlat16_0.x;
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