//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Mica/UI5/ShadowImage" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_BlurRadius ("BlurRadius", Range(0, 2.5)) = 0
_Scale ("Scale", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_MaskPos ("Mask Pos", Vector) = (0,0,512,0)
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 50873
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat10_0.x = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_2 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat3.x = texture2D(_MaskTex, u_xlat16_2.xy).w;
    u_xlat3.y = texture2D(_MaskTex, u_xlat16_2.zw).w;
    u_xlat3.xy = u_xlat3.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y + u_xlat0.x;
    u_xlat3.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat3.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat3.xy = u_xlat3.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_4.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat10_0.x = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_2 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat3.x = texture2D(_MaskTex, u_xlat16_2.xy).w;
    u_xlat3.y = texture2D(_MaskTex, u_xlat16_2.zw).w;
    u_xlat3.xy = u_xlat3.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y + u_xlat0.x;
    u_xlat3.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat3.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat3.xy = u_xlat3.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_4.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat10_0.x = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_2 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat3.x = texture2D(_MaskTex, u_xlat16_2.xy).w;
    u_xlat3.y = texture2D(_MaskTex, u_xlat16_2.zw).w;
    u_xlat3.xy = u_xlat3.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y + u_xlat0.x;
    u_xlat3.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat3.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat3.xy = u_xlat3.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = u_xlat3.y + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_4.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat10_2 = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat2 = u_xlat10_2 + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_3 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat6.x = texture2D(_MaskTex, u_xlat16_3.xy).w;
    u_xlat6.y = texture2D(_MaskTex, u_xlat16_3.zw).w;
    u_xlat6.xy = u_xlat6.xy + _TextureSampleAdd.ww;
    u_xlat2 = u_xlat6.x + u_xlat2;
    u_xlat2 = u_xlat6.y + u_xlat2;
    u_xlat6.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat6.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat6.xy = u_xlat6.xy + _TextureSampleAdd.ww;
    u_xlat2 = u_xlat6.x + u_xlat2;
    u_xlat2 = u_xlat6.y + u_xlat2;
    u_xlat16_1.x = u_xlat2 * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat10_2 = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat2 = u_xlat10_2 + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_3 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat6.x = texture2D(_MaskTex, u_xlat16_3.xy).w;
    u_xlat6.y = texture2D(_MaskTex, u_xlat16_3.zw).w;
    u_xlat6.xy = u_xlat6.xy + _TextureSampleAdd.ww;
    u_xlat2 = u_xlat6.x + u_xlat2;
    u_xlat2 = u_xlat6.y + u_xlat2;
    u_xlat6.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat6.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat6.xy = u_xlat6.xy + _TextureSampleAdd.ww;
    u_xlat2 = u_xlat6.x + u_xlat2;
    u_xlat2 = u_xlat6.y + u_xlat2;
    u_xlat16_1.x = u_xlat2 * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1.x = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb2 = u_xlat16_1.x<0.0;
    if(((int(u_xlatb2) * -1))!=0){discard;}
    u_xlat10_2 = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat2 = u_xlat10_2 + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_3 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat6.x = texture2D(_MaskTex, u_xlat16_3.xy).w;
    u_xlat6.y = texture2D(_MaskTex, u_xlat16_3.zw).w;
    u_xlat6.xy = u_xlat6.xy + _TextureSampleAdd.ww;
    u_xlat2 = u_xlat6.x + u_xlat2;
    u_xlat2 = u_xlat6.y + u_xlat2;
    u_xlat6.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat6.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat6.xy = u_xlat6.xy + _TextureSampleAdd.ww;
    u_xlat2 = u_xlat6.x + u_xlat2;
    u_xlat2 = u_xlat6.y + u_xlat2;
    u_xlat16_1.x = u_xlat2 * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump vec4 _ClipRect;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat10_0.x = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_2 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat4.x = texture2D(_MaskTex, u_xlat16_2.xy).w;
    u_xlat4.y = texture2D(_MaskTex, u_xlat16_2.zw).w;
    u_xlat4.xy = u_xlat4.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat0.x = u_xlat4.y + u_xlat0.x;
    u_xlat4.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat4.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat4.xy = u_xlat4.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat0.x = u_xlat4.y + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb3.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat3.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump vec4 _ClipRect;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat10_0.x = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_2 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat4.x = texture2D(_MaskTex, u_xlat16_2.xy).w;
    u_xlat4.y = texture2D(_MaskTex, u_xlat16_2.zw).w;
    u_xlat4.xy = u_xlat4.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat0.x = u_xlat4.y + u_xlat0.x;
    u_xlat4.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat4.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat4.xy = u_xlat4.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat0.x = u_xlat4.y + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb3.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat3.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump vec4 _ClipRect;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat10_0.x = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_2 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat4.x = texture2D(_MaskTex, u_xlat16_2.xy).w;
    u_xlat4.y = texture2D(_MaskTex, u_xlat16_2.zw).w;
    u_xlat4.xy = u_xlat4.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat0.x = u_xlat4.y + u_xlat0.x;
    u_xlat4.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat4.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat4.xy = u_xlat4.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat0.x = u_xlat4.y + u_xlat0.x;
    u_xlat16_1.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_5.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb3.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat3.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump vec4 _ClipRect;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat2 = u_xlat1 * vs_COLOR0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_18 = u_xlat2.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_18<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    u_xlat10_0 = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0 + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_4 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat5.x = texture2D(_MaskTex, u_xlat16_4.xy).w;
    u_xlat5.y = texture2D(_MaskTex, u_xlat16_4.zw).w;
    u_xlat5.xy = u_xlat5.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat5.x + u_xlat0.x;
    u_xlat0.x = u_xlat5.y + u_xlat0.x;
    u_xlat5.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat5.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat5.xy = u_xlat5.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat5.x + u_xlat0.x;
    u_xlat0.x = u_xlat5.y + u_xlat0.x;
    u_xlat16_18 = u_xlat0.x * 0.200000003;
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump vec4 _ClipRect;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat2 = u_xlat1 * vs_COLOR0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_18 = u_xlat2.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_18<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    u_xlat10_0 = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0 + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_4 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat5.x = texture2D(_MaskTex, u_xlat16_4.xy).w;
    u_xlat5.y = texture2D(_MaskTex, u_xlat16_4.zw).w;
    u_xlat5.xy = u_xlat5.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat5.x + u_xlat0.x;
    u_xlat0.x = u_xlat5.y + u_xlat0.x;
    u_xlat5.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat5.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat5.xy = u_xlat5.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat5.x + u_xlat0.x;
    u_xlat0.x = u_xlat5.y + u_xlat0.x;
    u_xlat16_18 = u_xlat0.x * 0.200000003;
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MaskPos;
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.xy = in_POSITION0.xy + (-_MaskPos.xy);
    u_xlat16_8 = _MaskPos.z * _Scale;
    u_xlat0.xy = vec2(u_xlat16_8) * vec2(0.5, 0.5) + u_xlat16_2.xy;
    u_xlat0.zw = u_xlat0.xy / vec2(u_xlat16_8);
    u_xlat0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump vec4 _ClipRect;
uniform 	mediump float _BlurRadius;
uniform 	mediump vec4 _MaskTex_TexelSize;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat2 = u_xlat1 * vs_COLOR0;
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_18 = u_xlat2.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat2.w;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_18<0.0;
    if(((int(u_xlatb0.x) * -1))!=0){discard;}
    u_xlat10_0 = texture2D(_MaskTex, vs_TEXCOORD0.zw).w;
    u_xlat0.x = u_xlat10_0 + _TextureSampleAdd.w;
    u_xlat16_1 = vec4(_BlurRadius) * _MaskTex_TexelSize.xyxy;
    u_xlat16_4 = u_xlat16_1.zwzw * vec4(0.0, 2.0, 0.0, -1.0) + vs_TEXCOORD0.zwzw;
    u_xlat16_1 = u_xlat16_1 * vec4(1.0, 0.0, -1.0, 0.0) + vs_TEXCOORD0.zwzw;
    u_xlat5.x = texture2D(_MaskTex, u_xlat16_4.xy).w;
    u_xlat5.y = texture2D(_MaskTex, u_xlat16_4.zw).w;
    u_xlat5.xy = u_xlat5.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat5.x + u_xlat0.x;
    u_xlat0.x = u_xlat5.y + u_xlat0.x;
    u_xlat5.x = texture2D(_MaskTex, u_xlat16_1.xy).w;
    u_xlat5.y = texture2D(_MaskTex, u_xlat16_1.zw).w;
    u_xlat5.xy = u_xlat5.xy + _TextureSampleAdd.ww;
    u_xlat0.x = u_xlat5.x + u_xlat0.x;
    u_xlat0.x = u_xlat5.y + u_xlat0.x;
    u_xlat16_18 = u_xlat0.x * 0.200000003;
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * u_xlat16_3.xyz;
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
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
""
}
}
}
}
}