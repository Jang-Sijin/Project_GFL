//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ImageCrossLine" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Speed ("速度", Float) = 10
_offsetx ("方格大小程度", Float) = 1
_linewidth ("条纹宽度影响", Float) = 10
_lineColor ("条纹颜色影响", Color) = (1,1,1,1)
_linePower ("条纹明暗", Range(0, 10)) = 1
_effect ("条纹影响程度", Range(0, 1)) = 1
_snoweffect ("雪花影响程度", Range(0, 1)) = 1
_lineYWidth ("纵向线条宽度", Range(0, 1)) = 0
_lineYPower ("纵向线条密度", Range(0.1, 100)) = 1
_LineTex ("Line Texture", 2D) = "white" { }
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 GrabPass {
}
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  GpuProgramID 41278
Program "vp" {
SubProgram "gles hw_tier00 " {
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _LineTex_ST;
uniform 	float _offsetx;
uniform 	float _Speed;
uniform 	float _effect;
uniform 	float _linewidth;
uniform 	vec4 _lineColor;
uniform 	float _linePower;
uniform 	float _snoweffect;
uniform 	float _lineYWidth;
uniform 	float _lineYPower;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _GrabTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
bvec3 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bvec2 u_xlatb10;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _Time.x * _Speed;
    u_xlat5.x = floor(u_xlat0.x);
    u_xlat10.x = u_xlat5.x * 0.25;
    u_xlatb15 = u_xlat10.x>=(-u_xlat10.x);
    u_xlat10.x = fract(abs(u_xlat10.x));
    u_xlat10.x = (u_xlatb15) ? u_xlat10.x : (-u_xlat10.x);
    u_xlatb1.xyz = equal(u_xlat10.xxxx, vec4(0.25, 0.5, 0.75, 0.0)).xyz;
    u_xlat10.xy = vs_TEXCOORD0.yx * _LineTex_ST.yx + _LineTex_ST.wz;
    u_xlat2.xy = (-u_xlat5.xx) * vec2(_offsetx) + u_xlat10.yx;
    u_xlat2.zw = u_xlat5.xx * vec2(_offsetx) + u_xlat10.xy;
    u_xlat5.xy = (u_xlatb1.x) ? u_xlat2.xy : u_xlat2.xz;
    u_xlat5.xy = (u_xlatb1.y) ? u_xlat2.wy : u_xlat5.xy;
    u_xlat5.xy = (u_xlatb1.z) ? u_xlat2.wz : u_xlat5.xy;
    u_xlat5.x = texture2D(_LineTex, u_xlat5.xy).x;
    u_xlatb10.x = u_xlat5.x<_effect;
    u_xlat16_3 = (u_xlatb10.x) ? u_xlat5.x : 0.0;
    u_xlat5.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat5.x * u_xlat1.y;
    u_xlat5.xyz = u_xlat1.xzz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = vec3(u_xlat16_3) + u_xlat5.xyz;
    u_xlatb5 = u_xlat16_3==0.0;
    u_xlat0.x = u_xlat5.z * _lineYPower + u_xlat0.x;
    u_xlatb10.xy = greaterThanEqual(u_xlat1.xzxz, (-u_xlat1.xzxz)).xy;
    u_xlat2.xy = fract(abs(u_xlat1.xz));
    u_xlat10.x = (u_xlatb10.x) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat10.y = (u_xlatb10.y) ? u_xlat2.y : (-u_xlat2.y);
    u_xlat10.xy = u_xlat10.xy * vec2(9999.0, 9999.0);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.x = dot(u_xlat10.xy, vec2(12.9898005, 78.2330017));
    u_xlat10.x = sin(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 43758.5469;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x + -1.0;
    u_xlat10.x = _snoweffect * u_xlat10.x + 1.0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_linewidth) + _lineColor.xyz;
    u_xlat1 = texture2D(_GrabTexture, u_xlat1.xz);
    u_xlatb4.xyz = greaterThanEqual(u_xlat2.xyzx, (-u_xlat2.xyzx)).xyz;
    u_xlat2.xyz = fract(abs(u_xlat2.xyz));
    {
        vec4 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat2.y : (-u_xlat2.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat2.z : (-u_xlat2.z);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.w = 1.0;
    u_xlat16_2 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat16_2 * vec4(_linePower);
    u_xlat2 = (bool(u_xlatb5)) ? u_xlat1 : u_xlat2;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlatb0 = _lineYWidth<u_xlat0.x;
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat1 = u_xlat1 * u_xlat0.xxxx;
    u_xlat0 = u_xlat2 * u_xlat10.xxxx + u_xlat1;
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _LineTex_ST;
uniform 	float _offsetx;
uniform 	float _Speed;
uniform 	float _effect;
uniform 	float _linewidth;
uniform 	vec4 _lineColor;
uniform 	float _linePower;
uniform 	float _snoweffect;
uniform 	float _lineYWidth;
uniform 	float _lineYPower;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _GrabTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
bvec3 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bvec2 u_xlatb10;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _Time.x * _Speed;
    u_xlat5.x = floor(u_xlat0.x);
    u_xlat10.x = u_xlat5.x * 0.25;
    u_xlatb15 = u_xlat10.x>=(-u_xlat10.x);
    u_xlat10.x = fract(abs(u_xlat10.x));
    u_xlat10.x = (u_xlatb15) ? u_xlat10.x : (-u_xlat10.x);
    u_xlatb1.xyz = equal(u_xlat10.xxxx, vec4(0.25, 0.5, 0.75, 0.0)).xyz;
    u_xlat10.xy = vs_TEXCOORD0.yx * _LineTex_ST.yx + _LineTex_ST.wz;
    u_xlat2.xy = (-u_xlat5.xx) * vec2(_offsetx) + u_xlat10.yx;
    u_xlat2.zw = u_xlat5.xx * vec2(_offsetx) + u_xlat10.xy;
    u_xlat5.xy = (u_xlatb1.x) ? u_xlat2.xy : u_xlat2.xz;
    u_xlat5.xy = (u_xlatb1.y) ? u_xlat2.wy : u_xlat5.xy;
    u_xlat5.xy = (u_xlatb1.z) ? u_xlat2.wz : u_xlat5.xy;
    u_xlat5.x = texture2D(_LineTex, u_xlat5.xy).x;
    u_xlatb10.x = u_xlat5.x<_effect;
    u_xlat16_3 = (u_xlatb10.x) ? u_xlat5.x : 0.0;
    u_xlat5.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat5.x * u_xlat1.y;
    u_xlat5.xyz = u_xlat1.xzz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = vec3(u_xlat16_3) + u_xlat5.xyz;
    u_xlatb5 = u_xlat16_3==0.0;
    u_xlat0.x = u_xlat5.z * _lineYPower + u_xlat0.x;
    u_xlatb10.xy = greaterThanEqual(u_xlat1.xzxz, (-u_xlat1.xzxz)).xy;
    u_xlat2.xy = fract(abs(u_xlat1.xz));
    u_xlat10.x = (u_xlatb10.x) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat10.y = (u_xlatb10.y) ? u_xlat2.y : (-u_xlat2.y);
    u_xlat10.xy = u_xlat10.xy * vec2(9999.0, 9999.0);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.x = dot(u_xlat10.xy, vec2(12.9898005, 78.2330017));
    u_xlat10.x = sin(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 43758.5469;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x + -1.0;
    u_xlat10.x = _snoweffect * u_xlat10.x + 1.0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_linewidth) + _lineColor.xyz;
    u_xlat1 = texture2D(_GrabTexture, u_xlat1.xz);
    u_xlatb4.xyz = greaterThanEqual(u_xlat2.xyzx, (-u_xlat2.xyzx)).xyz;
    u_xlat2.xyz = fract(abs(u_xlat2.xyz));
    {
        vec4 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat2.y : (-u_xlat2.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat2.z : (-u_xlat2.z);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.w = 1.0;
    u_xlat16_2 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat16_2 * vec4(_linePower);
    u_xlat2 = (bool(u_xlatb5)) ? u_xlat1 : u_xlat2;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlatb0 = _lineYWidth<u_xlat0.x;
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat1 = u_xlat1 * u_xlat0.xxxx;
    u_xlat0 = u_xlat2 * u_xlat10.xxxx + u_xlat1;
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _LineTex_ST;
uniform 	float _offsetx;
uniform 	float _Speed;
uniform 	float _effect;
uniform 	float _linewidth;
uniform 	vec4 _lineColor;
uniform 	float _linePower;
uniform 	float _snoweffect;
uniform 	float _lineYWidth;
uniform 	float _lineYPower;
uniform lowp sampler2D _LineTex;
uniform lowp sampler2D _GrabTexture;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
bvec3 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bvec2 u_xlatb10;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _Time.x * _Speed;
    u_xlat5.x = floor(u_xlat0.x);
    u_xlat10.x = u_xlat5.x * 0.25;
    u_xlatb15 = u_xlat10.x>=(-u_xlat10.x);
    u_xlat10.x = fract(abs(u_xlat10.x));
    u_xlat10.x = (u_xlatb15) ? u_xlat10.x : (-u_xlat10.x);
    u_xlatb1.xyz = equal(u_xlat10.xxxx, vec4(0.25, 0.5, 0.75, 0.0)).xyz;
    u_xlat10.xy = vs_TEXCOORD0.yx * _LineTex_ST.yx + _LineTex_ST.wz;
    u_xlat2.xy = (-u_xlat5.xx) * vec2(_offsetx) + u_xlat10.yx;
    u_xlat2.zw = u_xlat5.xx * vec2(_offsetx) + u_xlat10.xy;
    u_xlat5.xy = (u_xlatb1.x) ? u_xlat2.xy : u_xlat2.xz;
    u_xlat5.xy = (u_xlatb1.y) ? u_xlat2.wy : u_xlat5.xy;
    u_xlat5.xy = (u_xlatb1.z) ? u_xlat2.wz : u_xlat5.xy;
    u_xlat5.x = texture2D(_LineTex, u_xlat5.xy).x;
    u_xlatb10.x = u_xlat5.x<_effect;
    u_xlat16_3 = (u_xlatb10.x) ? u_xlat5.x : 0.0;
    u_xlat5.x = _ProjectionParams.x * _ProjectionParams.x;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.z = u_xlat5.x * u_xlat1.y;
    u_xlat5.xyz = u_xlat1.xzz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat1.xyz = vec3(u_xlat16_3) + u_xlat5.xyz;
    u_xlatb5 = u_xlat16_3==0.0;
    u_xlat0.x = u_xlat5.z * _lineYPower + u_xlat0.x;
    u_xlatb10.xy = greaterThanEqual(u_xlat1.xzxz, (-u_xlat1.xzxz)).xy;
    u_xlat2.xy = fract(abs(u_xlat1.xz));
    u_xlat10.x = (u_xlatb10.x) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat10.y = (u_xlatb10.y) ? u_xlat2.y : (-u_xlat2.y);
    u_xlat10.xy = u_xlat10.xy * vec2(9999.0, 9999.0);
    u_xlat10.xy = floor(u_xlat10.xy);
    u_xlat10.xy = u_xlat10.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat10.xy = fract(u_xlat10.xy);
    u_xlat10.x = dot(u_xlat10.xy, vec2(12.9898005, 78.2330017));
    u_xlat10.x = sin(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 43758.5469;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x + -1.0;
    u_xlat10.x = _snoweffect * u_xlat10.x + 1.0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_linewidth) + _lineColor.xyz;
    u_xlat1 = texture2D(_GrabTexture, u_xlat1.xz);
    u_xlatb4.xyz = greaterThanEqual(u_xlat2.xyzx, (-u_xlat2.xyzx)).xyz;
    u_xlat2.xyz = fract(abs(u_xlat2.xyz));
    {
        vec4 hlslcc_movcTemp = u_xlat2;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat2.x : (-u_xlat2.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat2.y : (-u_xlat2.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat2.z : (-u_xlat2.z);
        u_xlat2 = hlslcc_movcTemp;
    }
    u_xlat2.w = 1.0;
    u_xlat16_2 = u_xlat1 * u_xlat2;
    u_xlat2 = u_xlat16_2 * vec4(_linePower);
    u_xlat2 = (bool(u_xlatb5)) ? u_xlat1 : u_xlat2;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlatb0 = _lineYWidth<u_xlat0.x;
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat1 = u_xlat1 * u_xlat0.xxxx;
    u_xlat0 = u_xlat2 * u_xlat10.xxxx + u_xlat1;
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