//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ScanCircle" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("showColor", Color) = (1,0,0,1)
_alpha ("透明度", Range(0, 1)) = 1
_maxNiuqu ("扭曲强度", Range(0, 1)) = 1
_linerange ("内环半径", Float) = 50
_Scale ("实际大小", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  Cull Off
  GpuProgramID 53977
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _linerange;
uniform 	float _alpha;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat5;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.xy = sqrt(u_xlat1.xy);
    u_xlat5 = (-u_xlat1.x) + u_xlat1.y;
    u_xlatb5 = u_xlat5<0.0;
    if(((int(u_xlatb5) * -1))!=0){discard;}
    u_xlat5 = u_xlat1.y + (-_linerange);
    u_xlat1.xy = (-vec2(u_xlat5)) + u_xlat1.xy;
    u_xlat3.x = float(1.0) / u_xlat1.y;
    u_xlat1.x = u_xlat3.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat3.xxx * u_xlat1.xxx + u_xlat10_0.xyz;
    u_xlat1.x = u_xlat1.x * u_xlat3.x;
    u_xlat6 = u_xlat10_0.w * 4.0 + u_xlat1.x;
    SV_Target0.w = u_xlat6 * _alpha;
    SV_Target0.xyz = u_xlat0.xyz * _Color.xyz;
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
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _linerange;
uniform 	float _alpha;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat5;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.xy = sqrt(u_xlat1.xy);
    u_xlat5 = (-u_xlat1.x) + u_xlat1.y;
    u_xlatb5 = u_xlat5<0.0;
    if(((int(u_xlatb5) * -1))!=0){discard;}
    u_xlat5 = u_xlat1.y + (-_linerange);
    u_xlat1.xy = (-vec2(u_xlat5)) + u_xlat1.xy;
    u_xlat3.x = float(1.0) / u_xlat1.y;
    u_xlat1.x = u_xlat3.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat3.xxx * u_xlat1.xxx + u_xlat10_0.xyz;
    u_xlat1.x = u_xlat1.x * u_xlat3.x;
    u_xlat6 = u_xlat10_0.w * 4.0 + u_xlat1.x;
    SV_Target0.w = u_xlat6 * _alpha;
    SV_Target0.xyz = u_xlat0.xyz * _Color.xyz;
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
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _linerange;
uniform 	float _alpha;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat3;
float u_xlat5;
bool u_xlatb5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vec3(0.5, 0.5, 0.5);
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.xy = sqrt(u_xlat1.xy);
    u_xlat5 = (-u_xlat1.x) + u_xlat1.y;
    u_xlatb5 = u_xlat5<0.0;
    if(((int(u_xlatb5) * -1))!=0){discard;}
    u_xlat5 = u_xlat1.y + (-_linerange);
    u_xlat1.xy = (-vec2(u_xlat5)) + u_xlat1.xy;
    u_xlat3.x = float(1.0) / u_xlat1.y;
    u_xlat1.x = u_xlat3.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat3.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat0.xyz = u_xlat3.xxx * u_xlat1.xxx + u_xlat10_0.xyz;
    u_xlat1.x = u_xlat1.x * u_xlat3.x;
    u_xlat6 = u_xlat10_0.w * 4.0 + u_xlat1.x;
    SV_Target0.w = u_xlat6 * _alpha;
    SV_Target0.xyz = u_xlat0.xyz * _Color.xyz;
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