//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MobileShadow" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_FadeTex ("Fade Texture", 2D) = "white" { }
_MobileGlowTex ("Glow Texture", 2D) = "black" { }
_GlowColor ("Glow Color", Color) = (1,1,1,1)
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 17021
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump float _MobileShadowBlur;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = vec2(vec2(_MobileShadowBlur, _MobileShadowBlur));
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0_0_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec4(0.0205000006, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.324000001, 0.0, 0.0, 1.0);
	ImmCB_0_0_0[4] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[5] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[6] = vec4(0.0205000006, 0.0, 0.0, 0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump float _MobileShadowBlur;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = vec2(vec2(_MobileShadowBlur, _MobileShadowBlur));
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0_0_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec4(0.0205000006, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.324000001, 0.0, 0.0, 1.0);
	ImmCB_0_0_0[4] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[5] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[6] = vec4(0.0205000006, 0.0, 0.0, 0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump float _MobileShadowBlur;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = vec2(vec2(_MobileShadowBlur, _MobileShadowBlur));
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0_0_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec4(0.0205000006, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.324000001, 0.0, 0.0, 1.0);
	ImmCB_0_0_0[4] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[5] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[6] = vec4(0.0205000006, 0.0, 0.0, 0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 68819
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump float _MobileShadowBlur;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = vec2(vec2(_MobileShadowBlur, _MobileShadowBlur));
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0_0_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec4(0.0205000006, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.324000001, 0.0, 0.0, 1.0);
	ImmCB_0_0_0[4] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[5] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[6] = vec4(0.0205000006, 0.0, 0.0, 0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump float _MobileShadowBlur;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = vec2(vec2(_MobileShadowBlur, _MobileShadowBlur));
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0_0_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec4(0.0205000006, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.324000001, 0.0, 0.0, 1.0);
	ImmCB_0_0_0[4] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[5] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[6] = vec4(0.0205000006, 0.0, 0.0, 0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump float _MobileShadowBlur;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = vec2(vec2(_MobileShadowBlur, _MobileShadowBlur));
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0_0_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0_0_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0_0_0[i];
#else
#define d_ar ImmCB_0_0_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
	ImmCB_0_0_0[0] = vec4(0.0205000006, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.324000001, 0.0, 0.0, 1.0);
	ImmCB_0_0_0[4] = vec4(0.231999993, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[5] = vec4(0.0855000019, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[6] = vec4(0.0205000006, 0.0, 0.0, 0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0_0_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 148031
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FadeTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
lowp float u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_FadeTex, vs_TEXCOORD0.xy).x;
    SV_Target0 = u_xlat10_0 * vec4(u_xlat10_1);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FadeTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
lowp float u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_FadeTex, vs_TEXCOORD0.xy).x;
    SV_Target0 = u_xlat10_0 * vec4(u_xlat10_1);
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FadeTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
lowp float u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_FadeTex, vs_TEXCOORD0.xy).x;
    SV_Target0 = u_xlat10_0 * vec4(u_xlat10_1);
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 259093
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
uniform 	mediump float _GlowPower;
uniform 	mediump vec4 _GlowColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileGlowTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MobileGlowTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _GlowColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0 * vec4(_GlowPower) + u_xlat10_1;
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
uniform 	mediump float _GlowPower;
uniform 	mediump vec4 _GlowColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileGlowTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MobileGlowTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _GlowColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0 * vec4(_GlowPower) + u_xlat10_1;
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
uniform 	mediump float _GlowPower;
uniform 	mediump vec4 _GlowColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileGlowTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MobileGlowTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _GlowColor;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0 * vec4(_GlowPower) + u_xlat10_1;
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