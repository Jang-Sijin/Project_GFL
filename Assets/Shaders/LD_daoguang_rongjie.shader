//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "LD/daoguang_rongjie" {
Properties {
_Diffuse ("Diffuse", 2D) = "white" { }
_Noise ("Noise", 2D) = "white" { }
_0_ ("0_勾边大小", Float) = 0.1
_1_ ("1_勾边亮度", Float) = 100
_2_diffuse ("2_diffuse强度", Float) = 10
_3_color ("3_color", Color) = (0.8,0.3,0.1,1)
_4_ ("4_扭曲强度", Range(0, 1)) = 0.2
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Overlay" "RenderType" = "Transparent" }
 GrabPass {
}
 Pass {
  Name "ForwardBase"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Overlay" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 57757
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _Diffuse_ST;
uniform 	vec4 _Noise_ST;
uniform 	float _0_;
uniform 	float _1_;
uniform 	float _2_diffuse;
uniform 	vec4 _3_color;
uniform 	float _4_;
uniform lowp sampler2D _Diffuse;
uniform lowp sampler2D _GrabTexture;
uniform lowp sampler2D _Noise;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
float u_xlat5;
float u_xlat6;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat0.x * u_xlat1.y;
    u_xlat0.xy = u_xlat1.xz * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat6 = _4_ * 0.100000001;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Diffuse_ST.xy + _Diffuse_ST.zw;
    u_xlat10_1 = texture2D(_Diffuse, u_xlat1.xy);
    u_xlat2.xy = u_xlat10_1.xy * vs_COLOR0.ww;
    u_xlat2.xy = u_xlat10_1.ww * u_xlat2.xy;
    u_xlat0.xy = u_xlat2.xy * vec2(u_xlat6) + u_xlat0.xy;
    u_xlat10_0.xyz = texture2D(_GrabTexture, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _3_color.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_2_diffuse, _2_diffuse, _2_diffuse));
    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_1.xxx + (-u_xlat10_0.xyz);
    u_xlat2.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat9 = texture2D(_Noise, u_xlat2.xy).x;
    u_xlatb2.x = u_xlat9>=vs_COLOR0.x;
    u_xlatb2.y = vs_COLOR0.x>=u_xlat9;
    u_xlat2.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = (u_xlatb2.y) ? 0.0 : u_xlat2.x;
    u_xlat2.x = u_xlat2.x + u_xlat2.z;
    u_xlat5 = vs_COLOR0.x + _0_;
    u_xlatb8 = u_xlat9>=u_xlat5;
    u_xlatb9 = u_xlat5>=u_xlat9;
    u_xlat5 = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat8 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat5 = u_xlat8 * u_xlat5;
    u_xlat9 = (u_xlatb9) ? 0.0 : u_xlat5;
    u_xlat9 = u_xlat9 + u_xlat8;
    u_xlat2.x = (-u_xlat2.x) + u_xlat9;
    u_xlat9 = u_xlat2.x * _1_ + u_xlat9;
    u_xlat9 = u_xlat9 * u_xlat10_1.w;
    u_xlat9 = u_xlat9 * vs_COLOR0.w;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}