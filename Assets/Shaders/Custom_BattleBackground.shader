//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/BattleBackground" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Blend Mode", Float) = 10
_GlowTex ("Emission Map", 2D) = "white" { }
_GlowColor ("Emission Color", Color) = (1,1,1,1)
_GlowStrength ("Emission Tint", Float) = 0
_AlphaTex ("透明图", 2D) = "white" { }
_ScreenTex ("扫描图", 2D) = "white" { }
_SColor ("扫描图色", Color) = (1,1,1,1)
_Bright ("亮度", Range(0, 2)) = 1
_ChangeColor ("选择变换区域颜色", Color) = (0,0,1,1)
_Compare ("对比度", Range(0, 1)) = 0
_Yup ("Y上限位移", Range(0, 1)) = 1
_Ydown ("Y下限位移", Range(0, 1)) = 0
_MoveSpeed ("移动速度", Float) = 0
_MoveSpeedY ("上下移动速度", Float) = 0
[Enum(Off, 0, On, 1)] _useDeffuseLighting ("使用光源", Float) = 0
_strange ("面对光当前强度", Float) = 1
_FrontColor ("面对光色", Color) = (1,1,1,1)
_BackColor ("背对光色", Color) = (0,0,0,1)
[Enum(Off, 0, On, 1)] _Lighting ("开启高光", Float) = 0
_diffuse ("高光深暗对比", Float) = 1
_Specular ("Specular", Color) = (1,1,1,1)
_Gloss ("Gloss", Range(0.1, 50)) = 20
_WorldLightX ("世界光源方向X", Range(-1, 1)) = 1
_WorldLightY ("世界光源方向Y", Range(-1, 1)) = 1
_WorldLightZ ("世界光源方向Z", Range(-1, 1)) = 1
_DarkColor ("暗处颜色", Color) = (1,1,1,1)
_OffsetFactor ("Offset Factor", Float) = 0
_OffsetUnits ("Offset Units", Float) = 0
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 0
[Enum(Off, 0, On, 1)] UseFog ("使用雾", Float) = 1
_FarFogColor ("远度雾", Color) = (0.5,0.5,0.5,0)
_FarMinDistance ("雾最远距离", Float) = 25
_FarAddDistance ("雾叠加距离", Float) = 30
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZTest Off
  ZWrite Off
  GpuProgramID 17146
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTex_ST;
uniform 	vec4 _ScreenTex_ST;
uniform 	float _useDeffuseLighting;
uniform 	float _strange;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Lighting;
uniform 	mediump vec4 _Specular;
uniform 	float _Gloss;
uniform 	float _diffuse;
uniform 	mediump float _WorldLightX;
uniform 	mediump float _WorldLightY;
uniform 	mediump float _WorldLightZ;
uniform 	mediump vec4 _DarkColor;
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(vec3(_WorldLightX, _WorldLightY, _WorldLightZ), vec3(_WorldLightX, _WorldLightY, _WorldLightZ));
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_WorldLightX, _WorldLightY, _WorldLightZ);
    u_xlat16 = dot((-u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat16 = u_xlat16 + u_xlat16;
    u_xlat4.xyz = u_xlat2.xyz * (-vec3(u_xlat16)) + (-u_xlat16_3.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16 = u_xlat16 * 0.5 + 0.5;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Specular.x;
    u_xlat2 = vec4(vec4(_diffuse, _diffuse, _diffuse, _diffuse)) + (-_DarkColor);
    u_xlat2 = u_xlat1.xxxx * u_xlat2 + _DarkColor;
    u_xlatb1 = _Lighting==1.0;
    u_xlat16_2 = (bool(u_xlatb1)) ? u_xlat2 : vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3 = _FrontColor * vec4(vec4(_strange, _strange, _strange, _strange)) + (-_BackColor);
    u_xlat1 = vec4(u_xlat16) * u_xlat3 + _BackColor;
    u_xlatb4 = _useDeffuseLighting==1.0;
    u_xlat16_1 = (bool(u_xlatb4)) ? u_xlat1 : u_xlat16_2;
    u_xlat1 = u_xlat16_1 * in_COLOR0;
    vs_COLOR0 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
    u_xlat4.xy = in_TEXCOORD0.xy * _ScreenTex_ST.xy + _ScreenTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat4.xy;
    u_xlat4.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float UseFog;
uniform 	float _Yup;
uniform 	float _Ydown;
uniform 	float _MoveSpeed;
uniform 	float _MoveSpeedY;
uniform 	float _Bright;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ScreenTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bool u_xlatb5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(_MoveSpeedY, _MoveSpeed) + vs_TEXCOORD0.yx;
    u_xlatb12 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb12) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat12 = _Yup + (-_Ydown);
    u_xlat0.z = abs(u_xlat0.x) * u_xlat12 + _Ydown;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.yz);
    u_xlat0 = u_xlat10_0 * vec4(vec4(_Bright, _Bright, _Bright, _Bright));
    u_xlat0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.y = _Time.x * 100.0 + (-u_xlat1.x);
    u_xlat1.x = 0.0;
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlat10_1 = texture2D(_ScreenTex, u_xlat1.xy).w;
    u_xlat1 = vec4(u_xlat10_1) * _SColor;
    u_xlat2.x = _Time.x * 50.0;
    u_xlatb2.x = u_xlat2.x>=vs_TEXCOORD0.x;
    u_xlat6 = _Time.x * 50.0 + -0.200000003;
    u_xlatb2.y = vs_TEXCOORD0.x>=u_xlat6;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat0 = u_xlat1 * u_xlat2.xxxx + u_xlat0;
    u_xlatb1 = 0.100000001<u_xlat0.w;
    u_xlatb5 = UseFog==1.0;
    u_xlatb1 = u_xlatb5 && u_xlatb1;
    u_xlat10_5 = texture2D(_AlphaTex, vs_TEXCOORD1.xy).x;
    u_xlat12 = u_xlat0.w * u_xlat10_5;
    u_xlat12 = u_xlat12 * _Color.w;
    u_xlat2.w = u_xlat12 * vs_COLOR0.w;
    u_xlat12 = (-u_xlat12) * vs_COLOR0.w + 1.0;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat2.www + _FarFogColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.www;
    u_xlat0.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD4.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD4.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FarMinDistance);
    u_xlat4 = float(1.0) / _FarAddDistance;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat3.w = u_xlat0.x * u_xlat12 + u_xlat2.w;
    u_xlat0 = (bool(u_xlatb1)) ? u_xlat3 : u_xlat2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTex_ST;
uniform 	vec4 _ScreenTex_ST;
uniform 	float _useDeffuseLighting;
uniform 	float _strange;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Lighting;
uniform 	mediump vec4 _Specular;
uniform 	float _Gloss;
uniform 	float _diffuse;
uniform 	mediump float _WorldLightX;
uniform 	mediump float _WorldLightY;
uniform 	mediump float _WorldLightZ;
uniform 	mediump vec4 _DarkColor;
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(vec3(_WorldLightX, _WorldLightY, _WorldLightZ), vec3(_WorldLightX, _WorldLightY, _WorldLightZ));
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_WorldLightX, _WorldLightY, _WorldLightZ);
    u_xlat16 = dot((-u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat16 = u_xlat16 + u_xlat16;
    u_xlat4.xyz = u_xlat2.xyz * (-vec3(u_xlat16)) + (-u_xlat16_3.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16 = u_xlat16 * 0.5 + 0.5;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Specular.x;
    u_xlat2 = vec4(vec4(_diffuse, _diffuse, _diffuse, _diffuse)) + (-_DarkColor);
    u_xlat2 = u_xlat1.xxxx * u_xlat2 + _DarkColor;
    u_xlatb1 = _Lighting==1.0;
    u_xlat16_2 = (bool(u_xlatb1)) ? u_xlat2 : vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3 = _FrontColor * vec4(vec4(_strange, _strange, _strange, _strange)) + (-_BackColor);
    u_xlat1 = vec4(u_xlat16) * u_xlat3 + _BackColor;
    u_xlatb4 = _useDeffuseLighting==1.0;
    u_xlat16_1 = (bool(u_xlatb4)) ? u_xlat1 : u_xlat16_2;
    u_xlat1 = u_xlat16_1 * in_COLOR0;
    vs_COLOR0 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
    u_xlat4.xy = in_TEXCOORD0.xy * _ScreenTex_ST.xy + _ScreenTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat4.xy;
    u_xlat4.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float UseFog;
uniform 	float _Yup;
uniform 	float _Ydown;
uniform 	float _MoveSpeed;
uniform 	float _MoveSpeedY;
uniform 	float _Bright;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ScreenTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bool u_xlatb5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(_MoveSpeedY, _MoveSpeed) + vs_TEXCOORD0.yx;
    u_xlatb12 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb12) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat12 = _Yup + (-_Ydown);
    u_xlat0.z = abs(u_xlat0.x) * u_xlat12 + _Ydown;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.yz);
    u_xlat0 = u_xlat10_0 * vec4(vec4(_Bright, _Bright, _Bright, _Bright));
    u_xlat0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.y = _Time.x * 100.0 + (-u_xlat1.x);
    u_xlat1.x = 0.0;
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlat10_1 = texture2D(_ScreenTex, u_xlat1.xy).w;
    u_xlat1 = vec4(u_xlat10_1) * _SColor;
    u_xlat2.x = _Time.x * 50.0;
    u_xlatb2.x = u_xlat2.x>=vs_TEXCOORD0.x;
    u_xlat6 = _Time.x * 50.0 + -0.200000003;
    u_xlatb2.y = vs_TEXCOORD0.x>=u_xlat6;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat0 = u_xlat1 * u_xlat2.xxxx + u_xlat0;
    u_xlatb1 = 0.100000001<u_xlat0.w;
    u_xlatb5 = UseFog==1.0;
    u_xlatb1 = u_xlatb5 && u_xlatb1;
    u_xlat10_5 = texture2D(_AlphaTex, vs_TEXCOORD1.xy).x;
    u_xlat12 = u_xlat0.w * u_xlat10_5;
    u_xlat12 = u_xlat12 * _Color.w;
    u_xlat2.w = u_xlat12 * vs_COLOR0.w;
    u_xlat12 = (-u_xlat12) * vs_COLOR0.w + 1.0;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat2.www + _FarFogColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.www;
    u_xlat0.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD4.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD4.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FarMinDistance);
    u_xlat4 = float(1.0) / _FarAddDistance;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat3.w = u_xlat0.x * u_xlat12 + u_xlat2.w;
    u_xlat0 = (bool(u_xlatb1)) ? u_xlat3 : u_xlat2;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTex_ST;
uniform 	vec4 _ScreenTex_ST;
uniform 	float _useDeffuseLighting;
uniform 	float _strange;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Lighting;
uniform 	mediump vec4 _Specular;
uniform 	float _Gloss;
uniform 	float _diffuse;
uniform 	mediump float _WorldLightX;
uniform 	mediump float _WorldLightY;
uniform 	mediump float _WorldLightZ;
uniform 	mediump vec4 _DarkColor;
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat16_3.x = dot(vec3(_WorldLightX, _WorldLightY, _WorldLightZ), vec3(_WorldLightX, _WorldLightY, _WorldLightZ));
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vec3(_WorldLightX, _WorldLightY, _WorldLightZ);
    u_xlat16 = dot((-u_xlat16_3.xyz), u_xlat2.xyz);
    u_xlat16 = u_xlat16 + u_xlat16;
    u_xlat4.xyz = u_xlat2.xyz * (-vec3(u_xlat16)) + (-u_xlat16_3.xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat16 = u_xlat16 * 0.5 + 0.5;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_3.x);
    u_xlat1.x = u_xlat1.x * _Gloss;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Specular.x;
    u_xlat2 = vec4(vec4(_diffuse, _diffuse, _diffuse, _diffuse)) + (-_DarkColor);
    u_xlat2 = u_xlat1.xxxx * u_xlat2 + _DarkColor;
    u_xlatb1 = _Lighting==1.0;
    u_xlat16_2 = (bool(u_xlatb1)) ? u_xlat2 : vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat3 = _FrontColor * vec4(vec4(_strange, _strange, _strange, _strange)) + (-_BackColor);
    u_xlat1 = vec4(u_xlat16) * u_xlat3 + _BackColor;
    u_xlatb4 = _useDeffuseLighting==1.0;
    u_xlat16_1 = (bool(u_xlatb4)) ? u_xlat1 : u_xlat16_2;
    u_xlat1 = u_xlat16_1 * in_COLOR0;
    vs_COLOR0 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
    u_xlat4.xy = in_TEXCOORD0.xy * _ScreenTex_ST.xy + _ScreenTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat4.xy;
    u_xlat4.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _FarFogColor;
uniform 	float _FarMinDistance;
uniform 	float _FarAddDistance;
uniform 	float UseFog;
uniform 	float _Yup;
uniform 	float _Ydown;
uniform 	float _MoveSpeed;
uniform 	float _MoveSpeedY;
uniform 	float _Bright;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ScreenTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bool u_xlatb5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = _Time.xx * vec2(_MoveSpeedY, _MoveSpeed) + vs_TEXCOORD0.yx;
    u_xlatb12 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb12) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat12 = _Yup + (-_Ydown);
    u_xlat0.z = abs(u_xlat0.x) * u_xlat12 + _Ydown;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.yz);
    u_xlat0 = u_xlat10_0 * vec4(vec4(_Bright, _Bright, _Bright, _Bright));
    u_xlat0 = u_xlat0 * _Color;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.y = _Time.x * 100.0 + (-u_xlat1.x);
    u_xlat1.x = 0.0;
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlat10_1 = texture2D(_ScreenTex, u_xlat1.xy).w;
    u_xlat1 = vec4(u_xlat10_1) * _SColor;
    u_xlat2.x = _Time.x * 50.0;
    u_xlatb2.x = u_xlat2.x>=vs_TEXCOORD0.x;
    u_xlat6 = _Time.x * 50.0 + -0.200000003;
    u_xlatb2.y = vs_TEXCOORD0.x>=u_xlat6;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat0 = u_xlat1 * u_xlat2.xxxx + u_xlat0;
    u_xlatb1 = 0.100000001<u_xlat0.w;
    u_xlatb5 = UseFog==1.0;
    u_xlatb1 = u_xlatb5 && u_xlatb1;
    u_xlat10_5 = texture2D(_AlphaTex, vs_TEXCOORD1.xy).x;
    u_xlat12 = u_xlat0.w * u_xlat10_5;
    u_xlat12 = u_xlat12 * _Color.w;
    u_xlat2.w = u_xlat12 * vs_COLOR0.w;
    u_xlat12 = (-u_xlat12) * vs_COLOR0.w + 1.0;
    u_xlat5.xyz = (-u_xlat0.xyz) * u_xlat2.www + _FarFogColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.www;
    u_xlat0.xyz = vs_TEXCOORD4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD4.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD4.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD4.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_FarMinDistance);
    u_xlat4 = float(1.0) / _FarAddDistance;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat3.w = u_xlat0.x * u_xlat12 + u_xlat2.w;
    u_xlat0 = (bool(u_xlatb1)) ? u_xlat3 : u_xlat2;
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
CustomEditor "GlowMatInspector"
}