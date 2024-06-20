//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/SkeletonOutlineNight" {
Properties {
_Cutoff ("Shadow alpha cutoff", Range(0, 5)) = 2
_lineColor ("lineColor", Color) = (1,1,1,1)
_MainTex ("Texture to blend", 2D) = "black" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZTest Greater
  ZWrite Off
  Cull Off
  GpuProgramID 15731
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0 * vec4(1.02999997, 1.02999997, 1.0, 1.0);
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
uniform 	float _Cutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _lineColor;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
lowp float u_xlat10_12;
lowp float u_xlat10_18;
bool u_xlatb19;
void main()
{
    u_xlat0.xw = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xw);
    u_xlat2 = u_xlat10_1 * vs_COLOR0;
    u_xlatb19 = 0.0<_Cutoff;
    u_xlatb3 = 0.100000001<u_xlat2.w;
    u_xlatb19 = u_xlatb19 && u_xlatb3;
    if(u_xlatb19){
        u_xlat3.xy = vec2(_Cutoff) * _MainTex_TexelSize.yx;
        u_xlat0.yz = _MainTex_TexelSize.yx * vec2(_Cutoff) + u_xlat0.wx;
        u_xlat10_6 = texture2D(_MainTex, u_xlat0.xy).w;
        u_xlat4.x = float(-0.0);
        u_xlat4.w = float(-0.0);
        u_xlat4.yz = (-u_xlat3.xy);
        u_xlat3 = u_xlat0.xwxw + u_xlat4;
        u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy).w;
        u_xlat10_12 = texture2D(_MainTex, u_xlat0.zw).w;
        u_xlat10_18 = texture2D(_MainTex, u_xlat3.zw).w;
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_6);
        u_xlat16_5 = min(u_xlat10_12, u_xlat16_5);
        u_xlat16_5 = min(u_xlat10_18, u_xlat16_5);
        u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + (-_lineColor.xyz);
        u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _lineColor.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat16_0.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat2.www * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.w;
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
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0 * vec4(1.02999997, 1.02999997, 1.0, 1.0);
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
uniform 	float _Cutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _lineColor;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
lowp float u_xlat10_12;
lowp float u_xlat10_18;
bool u_xlatb19;
void main()
{
    u_xlat0.xw = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xw);
    u_xlat2 = u_xlat10_1 * vs_COLOR0;
    u_xlatb19 = 0.0<_Cutoff;
    u_xlatb3 = 0.100000001<u_xlat2.w;
    u_xlatb19 = u_xlatb19 && u_xlatb3;
    if(u_xlatb19){
        u_xlat3.xy = vec2(_Cutoff) * _MainTex_TexelSize.yx;
        u_xlat0.yz = _MainTex_TexelSize.yx * vec2(_Cutoff) + u_xlat0.wx;
        u_xlat10_6 = texture2D(_MainTex, u_xlat0.xy).w;
        u_xlat4.x = float(-0.0);
        u_xlat4.w = float(-0.0);
        u_xlat4.yz = (-u_xlat3.xy);
        u_xlat3 = u_xlat0.xwxw + u_xlat4;
        u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy).w;
        u_xlat10_12 = texture2D(_MainTex, u_xlat0.zw).w;
        u_xlat10_18 = texture2D(_MainTex, u_xlat3.zw).w;
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_6);
        u_xlat16_5 = min(u_xlat10_12, u_xlat16_5);
        u_xlat16_5 = min(u_xlat10_18, u_xlat16_5);
        u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + (-_lineColor.xyz);
        u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _lineColor.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat16_0.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat2.www * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.w;
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
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0 * vec4(1.02999997, 1.02999997, 1.0, 1.0);
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
uniform 	float _Cutoff;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _lineColor;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp float u_xlat10_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
lowp float u_xlat10_6;
lowp float u_xlat10_12;
lowp float u_xlat10_18;
bool u_xlatb19;
void main()
{
    u_xlat0.xw = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xw);
    u_xlat2 = u_xlat10_1 * vs_COLOR0;
    u_xlatb19 = 0.0<_Cutoff;
    u_xlatb3 = 0.100000001<u_xlat2.w;
    u_xlatb19 = u_xlatb19 && u_xlatb3;
    if(u_xlatb19){
        u_xlat3.xy = vec2(_Cutoff) * _MainTex_TexelSize.yx;
        u_xlat0.yz = _MainTex_TexelSize.yx * vec2(_Cutoff) + u_xlat0.wx;
        u_xlat10_6 = texture2D(_MainTex, u_xlat0.xy).w;
        u_xlat4.x = float(-0.0);
        u_xlat4.w = float(-0.0);
        u_xlat4.yz = (-u_xlat3.xy);
        u_xlat3 = u_xlat0.xwxw + u_xlat4;
        u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy).w;
        u_xlat10_12 = texture2D(_MainTex, u_xlat0.zw).w;
        u_xlat10_18 = texture2D(_MainTex, u_xlat3.zw).w;
        u_xlat16_5 = min(u_xlat10_0, u_xlat10_6);
        u_xlat16_5 = min(u_xlat10_12, u_xlat16_5);
        u_xlat16_5 = min(u_xlat10_18, u_xlat16_5);
        u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + (-_lineColor.xyz);
        u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _lineColor.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat16_0.xyz = u_xlat2.xyz;
    //ENDIF
    }
    SV_Target0.xyz = u_xlat2.www * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.w;
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