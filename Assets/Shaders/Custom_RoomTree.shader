//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/RoomTree" {
Properties {
_MainTex ("贴图", 2D) = "white" { }
_AlphaR ("透明通道贴图", 2D) = "white" { }
_FrontColor ("前亮", Color) = (1,1,1,1)
_SideColor ("侧边亮", Color) = (0.5,0.5,0.5,0.5)
_BackColor ("后亮", Color) = (0.5,0.5,0.5,0.5)
_SpecPower ("高光亮度", Float) = 1
_Gloss ("高光光泽度", Float) = 0.6
_SpecFinal ("高光光斑扩散临界点", Float) = 10
_Spec ("Spec", Color) = (1,1,1,1)
_shadowColor ("阴影颜色", Color) = (0,0,0,1)
_refPower ("反射强度", Float) = 0.5
_move ("位移", Float) = 1
_GlassColor ("glasscolor", Color) = (1,1,0,0)
_toGlass ("toGlass", Range(0, 1)) = 0
_FarFogColor ("远度雾", Color) = (1,1,1,0)
_MinDistance ("雾最远距离", Float) = 30
_AddDistance ("雾叠加距离", Float) = 130
_HighFogColor ("高度雾", Color) = (1,0,0,0)
_highFogMinDis ("高度雾最低位置", Float) = -40
_highFogAddDis ("高度雾叠加高度", Float) = 10
_Diffuse ("Diffuse", Color) = (1,1,1,1)
_PointLightColor ("点光源颜色", Color) = (0,0,0,0)
_PointPower ("点光源强度", Float) = 1
_PointTex ("点光源贴图", 2D) = "black" { }
}
SubShader {
 Pass {
  ColorMask 0 0
  ZWrite Off
  Fog {
   Mode Off
  }
  GpuProgramID 142911
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Geometry" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Front
  GpuProgramID 39849
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
float u_xlat18;
float u_xlat27;
float u_xlat28;
bool u_xlatb28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat0.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD1.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD1.www + u_xlat1.xyz;
    u_xlat16_2.xyz = _WorldSpaceLightPos0.www * (-u_xlat1.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_29 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat27);
    u_xlat0.w = sqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat28 = -abs(u_xlat28) + 1.5;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_2.x);
    u_xlat9 = exp2(_Gloss);
    u_xlat18 = u_xlat9 * _SpecFinal;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_2.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat28 = u_xlat28 * _GlassColor.w + u_xlat0.x;
    u_xlat28 = u_xlat28 + -1.0;
    u_xlat2.w = _toGlass * u_xlat28 + 1.0;
    u_xlat28 = u_xlat30 + 1.0;
    u_xlat3.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz + _BackColor.xyz;
    u_xlat4.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz + _SideColor.xyz;
    u_xlatb28 = u_xlat30<0.0;
    u_xlat16_5.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat4.xyz;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_6.xyz = u_xlat10_3.xyz * _LightColor0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * _GlassColor.xyz + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat16_5.xyz) * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat4 = (-u_xlat2) + _HighFogColor;
    u_xlat0.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xy = u_xlat1.xz * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat18 = u_xlat1.y + (-_highFogMinDis);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat9 = cos(u_xlat0.y);
    u_xlat1.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat9 + u_xlat1.x;
    u_xlat0.xw = u_xlat0.xw + (-vec2(_highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat9) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat4 + u_xlat2;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat9 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_1.xyz = texture2D(_PointTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_5.x = _PointLightColor.x * u_xlat10_1.x + u_xlat0.w;
    u_xlat1.xyz = u_xlat10_1.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_3.w * u_xlat16_5.x;
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
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 118948
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
uniform 	vec4 _PointTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_NORMAL0.xyz = u_xlat1.xxx * in_NORMAL0.xyz;
    vs_TEXCOORD0 = in_POSITION0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_MobileShadowMatrix[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_MobileShadowMatrix[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_MobileShadowMatrix[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _SideColor;
uniform 	mediump vec4 _BackColor;
uniform 	float _Gloss;
uniform 	float _SpecPower;
uniform 	float _SpecFinal;
uniform 	float _toGlass;
uniform 	mediump vec4 _GlassColor;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MobileShadowTexture;
uniform lowp sampler2D _PointTex;
varying highp vec3 vs_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp vec2 u_xlat10_13;
vec3 u_xlat14;
float u_xlat22;
float u_xlat33;
mediump float u_xlat16_34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD0.www + u_xlat0.xyz;
    u_xlat16_1.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_34 = inversesqrt(u_xlat16_34);
    u_xlat16_1.xyz = vec3(u_xlat16_34) * u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat35 = inversesqrt(u_xlat33);
    u_xlat0.w = sqrt(u_xlat33);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat35) + u_xlat16_1.xyz;
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat2.xyz;
    u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat3.xyz = vec3(u_xlat35) * u_xlat3.xyz;
    u_xlat4.x = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat4.y = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat4.z = dot(vs_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat4.xyz = vec3(u_xlat35) * u_xlat4.xyz;
    u_xlat16_34 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
    u_xlat35 = log2(u_xlat16_34);
    u_xlat3.x = exp2(_Gloss);
    u_xlat14.x = u_xlat3.x * _SpecFinal;
    u_xlat35 = u_xlat35 * u_xlat14.x;
    u_xlat35 = exp2(u_xlat35);
    u_xlat16_5.xyz = _LightColor0.xyz * _FrontColor.xyz;
    u_xlat14.xyz = vec3(u_xlat35) * u_xlat16_5.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat14.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecPower, _SpecPower, _SpecPower));
    u_xlat3.xyz = u_xlat3.xyz * vec3(0.100000001, 0.100000001, 0.100000001);
    u_xlat35 = dot(u_xlat4.xyz, u_xlat16_1.xyz);
    u_xlat36 = u_xlat35 + 1.0;
    u_xlat6.xyz = _SideColor.xyz + (-_BackColor.xyz);
    u_xlat6.xyz = vec3(u_xlat36) * u_xlat6.xyz + _BackColor.xyz;
    u_xlat7.xyz = _FrontColor.xyz + (-_SideColor.xyz);
    u_xlat7.xyz = vec3(u_xlat35) * u_xlat7.xyz + _SideColor.xyz;
    u_xlatb35 = u_xlat35<0.0;
    u_xlat16_1.xyz = (bool(u_xlatb35)) ? u_xlat6.xyz : u_xlat7.xyz;
    u_xlat10_5 = texture2D(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_8.xyz = u_xlat10_5.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz;
    u_xlat16_10.xyz = u_xlat16_9.xyz * _GlassColor.xyz + u_xlat3.xyz;
    u_xlat14.xyz = (-u_xlat16_1.xyz) * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat14.xyz = vec3(vec3(_toGlass, _toGlass, _toGlass)) * u_xlat14.xyz + u_xlat16_9.xyz;
    u_xlat35 = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat4.xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.x = -abs(u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x * _GlassColor.w + u_xlat3.x;
    u_xlat2.x = u_xlat2.x + -1.0;
    u_xlat1.w = _toGlass * u_xlat2.x + 1.0;
    u_xlatb2 = 0.0<u_xlat35;
    u_xlat10_13.xy = texture2D(_MobileShadowTexture, vs_TEXCOORD3.xy).xy;
    u_xlat16_8.x = u_xlat10_13.y + u_xlat10_13.x;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _MobileShadowOpacity;
    u_xlat16_8.x = (-u_xlat16_8.x) * vs_TEXCOORD3.z + 1.0;
    u_xlat16_8.x = (u_xlatb2) ? 1.0 : u_xlat16_8.x;
    u_xlat2.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat16_8.xxx * u_xlat2.xyz + _shadowColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat14.xyz;
    u_xlat2 = (-u_xlat1) + _HighFogColor;
    u_xlat3.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat3.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat22 = cos(u_xlat0.z);
    u_xlat3.x = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat22 + u_xlat3.x;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat2 = (-u_xlat1) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat10_2.xyz = texture2D(_PointTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.x = _PointLightColor.x * u_xlat10_2.x + u_xlat0.w;
    u_xlat2.xyz = u_xlat10_2.xyz * _PointLightColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * vec3(_PointPower) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat10_5.w * u_xlat16_8.x;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "Diffuse"
}