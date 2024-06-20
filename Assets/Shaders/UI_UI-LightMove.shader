//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/UI-LightMove" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_BaseColor ("底图颜色", Color) = (1,1,1,1)
_ScreenWidth ("当前屏幕宽度(_ScreenWidth)", Float) = 2048
_ScreenHeight ("当前屏幕高度度(_ScreenHeight)", Float) = 1152
_lightX ("高光相对宽度位置(_lightX)", Range(-1, 1.5)) = 0
_lightY ("高光相对高度位置(_lightY)", Range(0, 1)) = 0
_lightZ ("高光距离", Range(0, 5)) = 5
_SpecPower ("高光亮度", Range(0, 5)) = 1
_SpecColor ("高光颜色", Color) = (1,1,1,1)
_SpecGloss ("高光大小", Range(0, 5)) = 5
_SpecFinal ("高光扩散度", Range(0, 10)) = 2
_ControlX ("间隔(_ControlX)", Range(0, 5)) = 1
_Speed ("移动速度(_Speed)", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
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
  GpuProgramID 51805
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BaseColor;
uniform 	float _ScreenWidth;
uniform 	float _ScreenHeight;
uniform 	mediump vec4 _SpecColor;
uniform 	float _Speed;
uniform 	float _lightY;
uniform 	float _lightX;
uniform 	float _lightZ;
uniform 	float _ControlX;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_11;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.x = _Time.x * _Speed;
    u_xlat3.xy = vec2(_ScreenWidth, _ScreenHeight) * vec2(_lightX, _lightY);
    u_xlat0.x = u_xlat0.x * 1000.0 + u_xlat3.x;
    u_xlat1.y = (-u_xlat3.y);
    u_xlat0.x = u_xlat0.x + _lightX;
    u_xlat3.x = _ScreenWidth * _ControlX;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x);
    u_xlat1.z = (-_lightZ);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_FragCoord.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlat0.x = log2((-u_xlat0.x));
    u_xlat3.x = exp2((-_SpecGloss));
    u_xlat16_2.x = u_xlat3.x * -40.0;
    u_xlat6 = u_xlat16_2.x * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) * u_xlat3.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_2 = u_xlat10_1 * _SpecColor;
    u_xlat1 = u_xlat10_1 * _BaseColor;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = dot(u_xlat16_2.ww, u_xlat0.xx);
    u_xlat0.w = u_xlat16_11 * _SpecPower + u_xlat1.w;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BaseColor;
uniform 	float _ScreenWidth;
uniform 	float _ScreenHeight;
uniform 	mediump vec4 _SpecColor;
uniform 	float _Speed;
uniform 	float _lightY;
uniform 	float _lightX;
uniform 	float _lightZ;
uniform 	float _ControlX;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_11;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.x = _Time.x * _Speed;
    u_xlat3.xy = vec2(_ScreenWidth, _ScreenHeight) * vec2(_lightX, _lightY);
    u_xlat0.x = u_xlat0.x * 1000.0 + u_xlat3.x;
    u_xlat1.y = (-u_xlat3.y);
    u_xlat0.x = u_xlat0.x + _lightX;
    u_xlat3.x = _ScreenWidth * _ControlX;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x);
    u_xlat1.z = (-_lightZ);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_FragCoord.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlat0.x = log2((-u_xlat0.x));
    u_xlat3.x = exp2((-_SpecGloss));
    u_xlat16_2.x = u_xlat3.x * -40.0;
    u_xlat6 = u_xlat16_2.x * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) * u_xlat3.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_2 = u_xlat10_1 * _SpecColor;
    u_xlat1 = u_xlat10_1 * _BaseColor;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = dot(u_xlat16_2.ww, u_xlat0.xx);
    u_xlat0.w = u_xlat16_11 * _SpecPower + u_xlat1.w;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BaseColor;
uniform 	float _ScreenWidth;
uniform 	float _ScreenHeight;
uniform 	mediump vec4 _SpecColor;
uniform 	float _Speed;
uniform 	float _lightY;
uniform 	float _lightX;
uniform 	float _lightZ;
uniform 	float _ControlX;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_11;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.x = _Time.x * _Speed;
    u_xlat3.xy = vec2(_ScreenWidth, _ScreenHeight) * vec2(_lightX, _lightY);
    u_xlat0.x = u_xlat0.x * 1000.0 + u_xlat3.x;
    u_xlat1.y = (-u_xlat3.y);
    u_xlat0.x = u_xlat0.x + _lightX;
    u_xlat3.x = _ScreenWidth * _ControlX;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x);
    u_xlat1.z = (-_lightZ);
    u_xlat0.xyz = u_xlat1.xyz + hlslcc_FragCoord.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlat0.x = log2((-u_xlat0.x));
    u_xlat3.x = exp2((-_SpecGloss));
    u_xlat16_2.x = u_xlat3.x * -40.0;
    u_xlat6 = u_xlat16_2.x * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) * u_xlat3.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_2 = u_xlat10_1 * _SpecColor;
    u_xlat1 = u_xlat10_1 * _BaseColor;
    u_xlat16_2.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_11 = dot(u_xlat16_2.ww, u_xlat0.xx);
    u_xlat0.w = u_xlat16_11 * _SpecPower + u_xlat1.w;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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