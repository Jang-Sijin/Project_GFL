//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/UI-LightCameraMove" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_ChangeTex ("Sprite Texture2", 2D) = "white" { }
_texlerp ("贴图过渡", Range(0, 1)) = 0
_BaseColor ("底图颜色", Color) = (1,1,1,1)
_ScreenWidth ("当前屏幕宽度(_ScreenWidth)", Float) = 2048
_ScreenHeight ("当前屏幕高度度(_ScreenHeight)", Float) = 1152
_lightX ("高光相对宽度位置(_lightX)", Range(-1, 1.5)) = 0
_lightY ("高光相对高度位置(_lightY)", Range(0, 1)) = 0
_SpecularLerp ("高光底图限制或高光图限制", Range(0, 1)) = 0
_Specular ("高光限制贴图", 2D) = "white" { }
_lightZ ("高光距离", Range(0, 50)) = 5
_SpecPower ("高光亮度", Range(0, 5)) = 1
_SpecColor ("高光颜色", Color) = (1,1,1,1)
_SpecGloss ("高光大小", Range(0, 5)) = 5
_SpecFinal ("高光扩散度", Range(0, 10)) = 2
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
  GpuProgramID 22955
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	float _texlerp;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BaseColor;
uniform 	float _ScreenWidth;
uniform 	float _ScreenHeight;
uniform 	mediump vec4 _SpecColor;
uniform 	float _SpecularLerp;
uniform 	float _lightY;
uniform 	float _lightX;
uniform 	float _lightZ;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _Specular;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChangeTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vec2(_ScreenWidth, _ScreenHeight) * vec2(_lightX, _lightY);
    u_xlat0.xy = (-u_xlat0.xy);
    u_xlat0.z = (-_lightZ);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_FragCoord.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat4.x = exp2((-_SpecGloss));
    u_xlat16_2 = u_xlat4.x * -40.0;
    u_xlat8 = u_xlat16_2 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) * u_xlat4.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_ChangeTex, u_xlat4.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4.xyz = texture2D(_Specular, u_xlat4.xy).xyz;
    u_xlat1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat1 = vec4(_texlerp) * u_xlat1 + u_xlat10_2;
    u_xlat4.xyz = u_xlat10_4.xyz + (-u_xlat1.xyz);
    u_xlat4.xyz = vec3(_SpecularLerp) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat2 = u_xlat1 * _BaseColor;
    u_xlat16_15 = u_xlat1.w * _SpecColor.w;
    u_xlat16_15 = dot(vec2(u_xlat16_15), u_xlat0.xx);
    u_xlat0.w = u_xlat16_15 * _SpecPower + u_xlat2.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat2.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	float _texlerp;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BaseColor;
uniform 	float _ScreenWidth;
uniform 	float _ScreenHeight;
uniform 	mediump vec4 _SpecColor;
uniform 	float _SpecularLerp;
uniform 	float _lightY;
uniform 	float _lightX;
uniform 	float _lightZ;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _Specular;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChangeTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vec2(_ScreenWidth, _ScreenHeight) * vec2(_lightX, _lightY);
    u_xlat0.xy = (-u_xlat0.xy);
    u_xlat0.z = (-_lightZ);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_FragCoord.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat4.x = exp2((-_SpecGloss));
    u_xlat16_2 = u_xlat4.x * -40.0;
    u_xlat8 = u_xlat16_2 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) * u_xlat4.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_ChangeTex, u_xlat4.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4.xyz = texture2D(_Specular, u_xlat4.xy).xyz;
    u_xlat1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat1 = vec4(_texlerp) * u_xlat1 + u_xlat10_2;
    u_xlat4.xyz = u_xlat10_4.xyz + (-u_xlat1.xyz);
    u_xlat4.xyz = vec3(_SpecularLerp) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat2 = u_xlat1 * _BaseColor;
    u_xlat16_15 = u_xlat1.w * _SpecColor.w;
    u_xlat16_15 = dot(vec2(u_xlat16_15), u_xlat0.xx);
    u_xlat0.w = u_xlat16_15 * _SpecPower + u_xlat2.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat2.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	float _texlerp;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BaseColor;
uniform 	float _ScreenWidth;
uniform 	float _ScreenHeight;
uniform 	mediump vec4 _SpecColor;
uniform 	float _SpecularLerp;
uniform 	float _lightY;
uniform 	float _lightX;
uniform 	float _lightZ;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _SpecGloss;
uniform lowp sampler2D _Specular;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ChangeTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vec2(_ScreenWidth, _ScreenHeight) * vec2(_lightX, _lightY);
    u_xlat0.xy = (-u_xlat0.xy);
    u_xlat0.z = (-_lightZ);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_FragCoord.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = _WorldSpaceCameraPos.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat4.x = exp2((-_SpecGloss));
    u_xlat16_2 = u_xlat4.x * -40.0;
    u_xlat8 = u_xlat16_2 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) * u_xlat4.x + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_ChangeTex, u_xlat4.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat10_4.xyz = texture2D(_Specular, u_xlat4.xy).xyz;
    u_xlat1 = u_xlat10_1 + (-u_xlat10_2);
    u_xlat1 = vec4(_texlerp) * u_xlat1 + u_xlat10_2;
    u_xlat4.xyz = u_xlat10_4.xyz + (-u_xlat1.xyz);
    u_xlat4.xyz = vec3(_SpecularLerp) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * _SpecColor.xyz;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat2 = u_xlat1 * _BaseColor;
    u_xlat16_15 = u_xlat1.w * _SpecColor.w;
    u_xlat16_15 = dot(vec2(u_xlat16_15), u_xlat0.xx);
    u_xlat0.w = u_xlat16_15 * _SpecPower + u_xlat2.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower)) + u_xlat2.xyz;
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