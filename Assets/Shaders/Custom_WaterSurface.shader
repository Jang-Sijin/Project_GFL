//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/WaterSurface" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_BumpTex ("Bump Texture", 2D) = "white" { }
_BumpStrength ("Bump strength", Range(0, 1)) = 1
_BumpDirection ("Bump direction(2 wave)", Vector) = (1,1,1,-1)
_BumpTiling ("Bump tiling", Vector) = (0.0625,0.0625,0.0625,0.0625)
_RefractTex ("Refract Texture", 2D) = "white" { }
_Refractlerp ("Refract Lerp", Range(0, 1)) = 0.5
_fresnelCheck ("fresnel", Range(0, 2)) = 2
_FresnelTex ("Fresnel Texture", 2D) = "white" { }
_Skybox ("skybox", Cube) = "white" { }
_Gloss ("specgloss", Float) = 4
_FarFogColor ("INVALID_UTF8_STRING", Color) = (1,1,1,0)
_MinDistance ("INVALID_UTF8_STRING", Float) = 30
_AddDistance ("INVALID_UTF8_STRING", Float) = 130
_HighFogColor ("INVALID_UTF8_STRING", Color) = (1,0,0,0)
_highFogMinDis ("INVALID_UTF8_STRING", Float) = -40
_highFogAddDis ("INVALID_UTF8_STRING", Float) = 10
_PointLightColor ("INVALID_UTF8_STRING", Color) = (1,1,1,0)
_PointPower ("INVALID_UTF8_STRING", Float) = 1
_PointTex ("INVALID_UTF8_STRING", 2D) = "black" { }
}
SubShader {
 LOD 100
 Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Offset 1, 1
  GpuProgramID 14704
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_MobileShadowMatrix[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_MobileShadowMatrix[1];
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_MobileShadowMatrix[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_MobileShadowMatrix[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1 = u_xlat1;
    vs_TEXCOORD2 = in_POSITION0;
    u_xlat1.x = in_POSITION0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = in_POSITION0.xw * vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD3 = u_xlat1;
    u_xlat1.xy = in_POSITION0.ww + in_POSITION0.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat1.zw = in_POSITION0.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BumpStrength;
uniform 	mediump vec4 _BumpDirection;
uniform 	mediump vec4 _BumpTiling;
uniform 	float _Refractlerp;
uniform 	float _Gloss;
uniform 	float _fresnelCheck;
uniform 	mediump vec4 _FarFogColor;
uniform 	mediump vec4 _HighFogColor;
uniform 	float _MinDistance;
uniform 	float _AddDistance;
uniform 	float _highFogMinDis;
uniform 	float _highFogAddDis;
uniform 	mediump vec4 _shadowColor;
uniform 	mediump float _MobileShadowOpacity;
uniform 	mediump vec3 _MobileShadowSunPosition;
uniform 	vec4 _PointTex_ST;
uniform 	mediump vec4 _PointLightColor;
uniform 	float _PointPower;
uniform lowp sampler2D _BumpTex;
uniform lowp sampler2D _RefractTex;
uniform lowp sampler2D _GrabTex;
uniform lowp sampler2D _ReflectTex;
uniform lowp samplerCube _Skybox;
uniform lowp sampler2D _FresnelTex;
uniform lowp sampler2D _PointTex;
uniform lowp sampler2D _MobileShadowTexture;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp vec4 u_xlat10_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat8;
bool u_xlatb9;
float u_xlat16;
float u_xlat17;
lowp vec2 u_xlat10_17;
mediump vec2 u_xlat16_19;
float u_xlat24;
float u_xlat25;
lowp float u_xlat10_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD2.www + u_xlat0.xyz;
    u_xlat1 = _Time.yyyy * _BumpDirection + u_xlat0.xzxz;
    u_xlat1 = u_xlat1 * _BumpTiling;
    u_xlat10_1.xy = texture2D(_BumpTex, u_xlat1.xy).xy;
    u_xlat10_17.xy = texture2D(_BumpTex, u_xlat1.zw).xy;
    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat10_17.xy * vec2(2.0, 2.0) + u_xlat16_2.xy;
    u_xlat16_2.xy = u_xlat16_2.xy + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_BumpStrength);
    u_xlat1.xz = u_xlat16_2.xy * vec2(0.5, 0.5);
    u_xlat1.y = 1.0;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat16_2.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat24);
    u_xlat0.w = sqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_26 = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_26)) + u_xlat1.xyz;
    u_xlat10_5.xyz = textureCube(_Skybox, u_xlat16_4.xyz).xyz;
    u_xlat16_19.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat16_19.xy;
    u_xlat10_4 = texture2D(_ReflectTex, u_xlat16_19.xy);
    u_xlat16_6.xyz = (-u_xlat10_5.xyz) + u_xlat10_4.xyz;
    u_xlat16_6.xyz = u_xlat10_4.www * u_xlat16_6.xyz + u_xlat10_5.xyz;
    u_xlat16_19.xy = u_xlat16_2.xz * u_xlat1.yy + vs_TEXCOORD0.xy;
    u_xlat10_5.xyz = texture2D(_RefractTex, u_xlat16_19.xy).xyz;
    u_xlat16_19.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_7.xyz = texture2D(_GrabTex, u_xlat16_19.xy).xyz;
    u_xlat7.xyz = (-u_xlat10_5.xyz) * _Color.xyz + u_xlat10_7.xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _Color.xyz;
    u_xlat5.xyz = vec3(_Refractlerp) * u_xlat7.xyz + u_xlat5.xyz;
    u_xlat16_6.xyz = (-u_xlat5.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.y = 0.5;
    u_xlat10_25 = texture2D(_FresnelTex, u_xlat16_3.xy).x;
    u_xlat25 = log2(u_xlat10_25);
    u_xlat25 = u_xlat25 * _fresnelCheck;
    u_xlat25 = exp2(u_xlat25);
    u_xlat16_3.xyz = vec3(u_xlat25) * u_xlat16_6.xyz + u_xlat5.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy * _PointTex_ST.xy + _PointTex_ST.zw;
    u_xlat5.xy = u_xlat16_2.xz * u_xlat1.yy + u_xlat5.xy;
    u_xlat10_5.xyz = texture2D(_PointTex, u_xlat5.xy).xyz;
    u_xlat5.xyz = u_xlat10_5.xyz * _PointLightColor.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_PointPower) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _WorldSpaceLightPos0.www * (-u_xlat0.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat1.xyz;
    u_xlat16_26 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_26 = inversesqrt(u_xlat16_26);
    u_xlat16_3.xyz = vec3(u_xlat16_26) * u_xlat16_3.xyz;
    u_xlat1.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_2.x = dot(vec3(_MobileShadowSunPosition.x, _MobileShadowSunPosition.y, _MobileShadowSunPosition.z), u_xlat16_2.xyz);
    u_xlatb9 = 0.0<u_xlat16_2.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat17 = exp2(_Gloss);
    u_xlat16_2.x = u_xlat17 * 40.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_2.x;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * vec3(u_xlat17) + u_xlat5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat10_1.xz = texture2D(_MobileShadowTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_26 = u_xlat10_1.z + u_xlat10_1.x;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_26 * _MobileShadowOpacity;
    u_xlat16_26 = (-u_xlat16_26) * vs_TEXCOORD1.z + 1.0;
    u_xlat16_26 = (u_xlatb9) ? 1.0 : u_xlat16_26;
    u_xlat1.xyz = (-_shadowColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_26) * u_xlat1.xyz + _shadowColor.xyz;
    u_xlat5.xyz = u_xlat1.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-u_xlat5.xyz);
    u_xlat3.w = -1.0;
    u_xlat3 = u_xlat3 + _HighFogColor;
    u_xlat5.xy = _Time.xx * vec2(20.0, 30.0);
    u_xlat0.xz = u_xlat0.xz * vec2(0.300000012, 0.300000012) + u_xlat5.xy;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16 = cos(u_xlat0.z);
    u_xlat25 = _highFogAddDis + _highFogMinDis;
    u_xlat0.x = u_xlat0.x * u_xlat16 + u_xlat25;
    u_xlat0.xyw = u_xlat0.xyw + (-vec3(_highFogMinDis, _highFogMinDis, _MinDistance));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat8) * u_xlat0.x + 1.0;
    u_xlat5.xyz = u_xlat3.xyz * u_xlat0.xxx;
    u_xlat3.w = u_xlat0.x * u_xlat3.w + 1.0;
    u_xlat3.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat5.xyz;
    u_xlat1 = (-u_xlat3) + _FarFogColor;
    u_xlat0.x = float(1.0) / _AddDistance;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat8 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat3;
    SV_Target0 = u_xlat0;
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
}