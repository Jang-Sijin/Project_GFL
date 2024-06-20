//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "LXL/MasK_add_UV" {
Properties {
_color ("color", Color) = (0.5,0.5,0.5,1)
_diffuse ("diffuse", 2D) = "white" { }
_mask ("mask", 2D) = "white" { }
_diffuse_light ("diffuse_light", Range(0, 5)) = 3.886719
_v_speed ("v_speed", Range(-2, 2)) = -2
_u_speed ("u_speed", Range(-2, 2)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend One OneMinusSrcColor, One OneMinusSrcColor
  ZWrite Off
  Cull Off
  GpuProgramID 37205
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _TimeEditor;
uniform 	vec4 _diffuse_ST;
uniform 	vec4 _mask_ST;
uniform 	float _u_speed;
uniform 	float _v_speed;
uniform 	float _diffuse_light;
uniform 	vec4 _color;
uniform lowp sampler2D _diffuse;
uniform lowp sampler2D _mask;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.x = _Time.y + _TimeEditor.y;
    u_xlat0 = u_xlat0.xxxx * vec4(_u_speed, _u_speed, _v_speed, _v_speed);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, 0.0) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.zw * vec2(0.0, 1.0) + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _diffuse_ST.xy + _diffuse_ST.zw;
    u_xlat10_0 = texture2D(_diffuse, u_xlat0.xy);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _mask_ST.xy + _mask_ST.zw;
    u_xlat10_1 = texture2D(_mask, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.www * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_diffuse_light, _diffuse_light, _diffuse_light));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.xyz = u_xlat0.xyz * _color.xyz;
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
CustomEditor "ShaderForgeMaterialInspector"
}