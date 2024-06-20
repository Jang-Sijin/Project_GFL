//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/GaussianBlur" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
radius ("Radius", Float) = 30
_TintColor ("Tint", Color) = (1,1,1,1)
resolution ("Resolution", Float) = 2000
hstep ("HorizontalStep", Range(0, 1)) = 0.5
vstep ("VerticalStep", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 22381
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TintColor;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _TintColor;
    vs_COLOR0 = u_xlat0;
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
uniform 	float radius;
uniform 	float resolution;
uniform 	float hstep;
uniform 	float vstep;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
void main()
{
    u_xlat0.x = radius / resolution;
    u_xlat5.xy = (-u_xlat0.xx) * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat0.xxx * vec3(0.25, 0.75, 0.5);
    u_xlat2.xy = u_xlat0.xx * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat3 = (-u_xlat5.yyzz) * vec4(hstep, vstep, hstep, vstep) + vs_TEXCOORD0.xyxy;
    u_xlat10_4 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.zw);
    u_xlat4 = u_xlat10_4 * vec4(0.0540540554, 0.0540540554, 0.0540540554, 0.0540540554);
    u_xlat1 = u_xlat10_1 * vec4(0.0162162166, 0.0162162166, 0.0162162166, 0.0162162166) + u_xlat4;
    u_xlat1 = u_xlat10_3 * vec4(0.121621624, 0.121621624, 0.121621624, 0.121621624) + u_xlat1;
    u_xlat3.xy = (-u_xlat5.xx) * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat1 = u_xlat10_3 * vec4(0.194594592, 0.194594592, 0.194594592, 0.194594592) + u_xlat1;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_3 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat1;
    u_xlat0.xy = u_xlat5.xx * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat3 = u_xlat5.zzyy * vec4(hstep, vstep, hstep, vstep) + vs_TEXCOORD0.xyxy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vec4(0.194594592, 0.194594592, 0.194594592, 0.194594592) + u_xlat1;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.zw);
    u_xlat0 = u_xlat10_1 * vec4(0.121621624, 0.121621624, 0.121621624, 0.121621624) + u_xlat0;
    u_xlat0 = u_xlat10_3 * vec4(0.0540540554, 0.0540540554, 0.0540540554, 0.0540540554) + u_xlat0;
    u_xlat0 = u_xlat10_2 * vec4(0.0162162166, 0.0162162166, 0.0162162166, 0.0162162166) + u_xlat0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	mediump vec4 _TintColor;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _TintColor;
    vs_COLOR0 = u_xlat0;
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
uniform 	float radius;
uniform 	float resolution;
uniform 	float hstep;
uniform 	float vstep;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
void main()
{
    u_xlat0.x = radius / resolution;
    u_xlat5.xy = (-u_xlat0.xx) * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat0.xxx * vec3(0.25, 0.75, 0.5);
    u_xlat2.xy = u_xlat0.xx * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat3 = (-u_xlat5.yyzz) * vec4(hstep, vstep, hstep, vstep) + vs_TEXCOORD0.xyxy;
    u_xlat10_4 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.zw);
    u_xlat4 = u_xlat10_4 * vec4(0.0540540554, 0.0540540554, 0.0540540554, 0.0540540554);
    u_xlat1 = u_xlat10_1 * vec4(0.0162162166, 0.0162162166, 0.0162162166, 0.0162162166) + u_xlat4;
    u_xlat1 = u_xlat10_3 * vec4(0.121621624, 0.121621624, 0.121621624, 0.121621624) + u_xlat1;
    u_xlat3.xy = (-u_xlat5.xx) * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat1 = u_xlat10_3 * vec4(0.194594592, 0.194594592, 0.194594592, 0.194594592) + u_xlat1;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_3 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat1;
    u_xlat0.xy = u_xlat5.xx * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat3 = u_xlat5.zzyy * vec4(hstep, vstep, hstep, vstep) + vs_TEXCOORD0.xyxy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vec4(0.194594592, 0.194594592, 0.194594592, 0.194594592) + u_xlat1;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.zw);
    u_xlat0 = u_xlat10_1 * vec4(0.121621624, 0.121621624, 0.121621624, 0.121621624) + u_xlat0;
    u_xlat0 = u_xlat10_3 * vec4(0.0540540554, 0.0540540554, 0.0540540554, 0.0540540554) + u_xlat0;
    u_xlat0 = u_xlat10_2 * vec4(0.0162162166, 0.0162162166, 0.0162162166, 0.0162162166) + u_xlat0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	mediump vec4 _TintColor;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _TintColor;
    vs_COLOR0 = u_xlat0;
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
uniform 	float radius;
uniform 	float resolution;
uniform 	float hstep;
uniform 	float vstep;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
void main()
{
    u_xlat0.x = radius / resolution;
    u_xlat5.xy = (-u_xlat0.xx) * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat0.xxx * vec3(0.25, 0.75, 0.5);
    u_xlat2.xy = u_xlat0.xx * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat3 = (-u_xlat5.yyzz) * vec4(hstep, vstep, hstep, vstep) + vs_TEXCOORD0.xyxy;
    u_xlat10_4 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.zw);
    u_xlat4 = u_xlat10_4 * vec4(0.0540540554, 0.0540540554, 0.0540540554, 0.0540540554);
    u_xlat1 = u_xlat10_1 * vec4(0.0162162166, 0.0162162166, 0.0162162166, 0.0162162166) + u_xlat4;
    u_xlat1 = u_xlat10_3 * vec4(0.121621624, 0.121621624, 0.121621624, 0.121621624) + u_xlat1;
    u_xlat3.xy = (-u_xlat5.xx) * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat1 = u_xlat10_3 * vec4(0.194594592, 0.194594592, 0.194594592, 0.194594592) + u_xlat1;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_3 * vec4(0.227027029, 0.227027029, 0.227027029, 0.227027029) + u_xlat1;
    u_xlat0.xy = u_xlat5.xx * vec2(hstep, vstep) + vs_TEXCOORD0.xy;
    u_xlat3 = u_xlat5.zzyy * vec4(hstep, vstep, hstep, vstep) + vs_TEXCOORD0.xyxy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vec4(0.194594592, 0.194594592, 0.194594592, 0.194594592) + u_xlat1;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat10_3 = texture2D(_MainTex, u_xlat3.zw);
    u_xlat0 = u_xlat10_1 * vec4(0.121621624, 0.121621624, 0.121621624, 0.121621624) + u_xlat0;
    u_xlat0 = u_xlat10_3 * vec4(0.0540540554, 0.0540540554, 0.0540540554, 0.0540540554) + u_xlat0;
    u_xlat0 = u_xlat10_2 * vec4(0.0162162166, 0.0162162166, 0.0162162166, 0.0162162166) + u_xlat0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
Fallback "Sprites/Default"
}