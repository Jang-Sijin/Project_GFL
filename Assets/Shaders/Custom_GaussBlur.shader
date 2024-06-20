//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/GaussBlur" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_BlurRadius ("_BlurRadius", Float) = 1
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 47228
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _BlurRadius;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
void main()
{
    u_xlat0 = vec4(_BlurRadius) * vec4(0.00999999978, 0.00999999978, -0.00999999978, 0.00999999978);
    u_xlat1 = u_xlat0 * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat0 = u_xlat0.wzzz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat2 = u_xlat10_2 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007);
    u_xlat1 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.zw);
    u_xlat1 = u_xlat10_2 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat1;
    u_xlat0 = u_xlat10_0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat1;
    u_xlat1 = vec4(_BlurRadius) * vec4(0.0, 0.00999999978, 0.0, -0.00999999978);
    u_xlat2 = u_xlat1.yxwz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1 * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat0 = u_xlat10_3 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat0 = u_xlat10_2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat0 = u_xlat10_2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat0 = u_xlat10_1 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
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
varying highp vec4 vs_TEXCOORD0;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _BlurRadius;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
void main()
{
    u_xlat0 = vec4(_BlurRadius) * vec4(0.00999999978, 0.00999999978, -0.00999999978, 0.00999999978);
    u_xlat1 = u_xlat0 * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat0 = u_xlat0.wzzz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat2 = u_xlat10_2 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007);
    u_xlat1 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.zw);
    u_xlat1 = u_xlat10_2 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat1;
    u_xlat0 = u_xlat10_0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat1;
    u_xlat1 = vec4(_BlurRadius) * vec4(0.0, 0.00999999978, 0.0, -0.00999999978);
    u_xlat2 = u_xlat1.yxwz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1 * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat0 = u_xlat10_3 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat0 = u_xlat10_2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat0 = u_xlat10_2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat0 = u_xlat10_1 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
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
varying highp vec4 vs_TEXCOORD0;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _BlurRadius;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
lowp vec4 u_xlat10_3;
void main()
{
    u_xlat0 = vec4(_BlurRadius) * vec4(0.00999999978, 0.00999999978, -0.00999999978, 0.00999999978);
    u_xlat1 = u_xlat0 * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat0 = u_xlat0.wzzz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat2 = u_xlat10_2 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007);
    u_xlat1 = u_xlat10_1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.zw);
    u_xlat1 = u_xlat10_2 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat1;
    u_xlat0 = u_xlat10_0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat1;
    u_xlat1 = vec4(_BlurRadius) * vec4(0.0, 0.00999999978, 0.0, -0.00999999978);
    u_xlat2 = u_xlat1.yxwz * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1 * _MainTex_TexelSize.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_3 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat10_2 = texture2D(_MainTex, u_xlat2.zw);
    u_xlat0 = u_xlat10_3 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat0 = u_xlat10_2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.zw);
    u_xlat0 = u_xlat10_2 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
    u_xlat0 = u_xlat10_1 * vec4(0.200000003, 0.200000003, 0.200000003, 0.200000003) + u_xlat0;
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