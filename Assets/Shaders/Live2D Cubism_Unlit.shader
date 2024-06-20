//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Live2D Cubism/Unlit" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
cubism_ModelOpacity ("Model Opacity", Float) = 1
_SrcColor ("Source Color", Float) = 0
_DstColor ("Destination Color", Float) = 0
_SrcAlpha ("Source Alpha", Float) = 0
_DstAlpha ("Destination Alpha", Float) = 0
[Toggle(CUBISM_MASK_ON)] cubism_MaskOn ("Mask?", Float) = 0
[Toggle(CUBISM_INVERT_ON)] cubism_InvertOn ("Inverted?", Float) = 0
cubism_MaskTexture ("cubism_Internal", 2D) = "white" { }
cubism_MaskTile ("cubism_Internal", Vector) = (0,0,0,0)
cubism_MaskTransform ("cubism_Internal", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 41310
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "CUBISM_MASK_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    vs_TEXCOORD3.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D cubism_MaskTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
void main()
{
    u_xlat0.xy = cubism_MaskTile.ww * cubism_MaskTile.yz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD3.xyxx, u_xlat0.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3.xy = cubism_MaskTile.yz * cubism_MaskTile.ww + cubism_MaskTile.ww;
    u_xlatb3.xy = greaterThanEqual(u_xlat3.xyxx, vs_TEXCOORD3.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat0.x;
    u_xlatb1 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat10_1 = texture2D(cubism_MaskTexture, vs_TEXCOORD3.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.w * u_xlat0.w + u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat1.www * u_xlat1.xyz;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0 = u_xlat1 * vec4(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CUBISM_MASK_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    vs_TEXCOORD3.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D cubism_MaskTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
void main()
{
    u_xlat0.xy = cubism_MaskTile.ww * cubism_MaskTile.yz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD3.xyxx, u_xlat0.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3.xy = cubism_MaskTile.yz * cubism_MaskTile.ww + cubism_MaskTile.ww;
    u_xlatb3.xy = greaterThanEqual(u_xlat3.xyxx, vs_TEXCOORD3.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat0.x;
    u_xlatb1 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat10_1 = texture2D(cubism_MaskTexture, vs_TEXCOORD3.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.w * u_xlat0.w + u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat1.www * u_xlat1.xyz;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0 = u_xlat1 * vec4(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CUBISM_MASK_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    vs_TEXCOORD3.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D cubism_MaskTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
void main()
{
    u_xlat0.xy = cubism_MaskTile.ww * cubism_MaskTile.yz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD3.xyxx, u_xlat0.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3.xy = cubism_MaskTile.yz * cubism_MaskTile.ww + cubism_MaskTile.ww;
    u_xlatb3.xy = greaterThanEqual(u_xlat3.xyxx, vs_TEXCOORD3.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat0.x;
    u_xlatb1 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat10_1 = texture2D(cubism_MaskTexture, vs_TEXCOORD3.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.w * u_xlat0.w + u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat1.www * u_xlat1.xyz;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0 = u_xlat1 * vec4(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CUBISM_MASK_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat0.w = u_xlat0.w * cubism_ModelOpacity;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CUBISM_MASK_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat0.w = u_xlat0.w * cubism_ModelOpacity;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CUBISM_MASK_OFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat0.w = u_xlat0.w * cubism_ModelOpacity;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CUBISM_INVERT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    vs_TEXCOORD3.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D cubism_MaskTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
void main()
{
    u_xlat0.xy = cubism_MaskTile.ww * cubism_MaskTile.yz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD3.xyxx, u_xlat0.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3.xy = cubism_MaskTile.yz * cubism_MaskTile.ww + cubism_MaskTile.ww;
    u_xlatb3.xy = greaterThanEqual(u_xlat3.xyxx, vs_TEXCOORD3.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat0.x;
    u_xlatb1 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat10_1 = texture2D(cubism_MaskTexture, vs_TEXCOORD3.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.w * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat1.www * u_xlat1.xyz;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0 = u_xlat1 * vec4(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CUBISM_INVERT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    vs_TEXCOORD3.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D cubism_MaskTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
void main()
{
    u_xlat0.xy = cubism_MaskTile.ww * cubism_MaskTile.yz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD3.xyxx, u_xlat0.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3.xy = cubism_MaskTile.yz * cubism_MaskTile.ww + cubism_MaskTile.ww;
    u_xlatb3.xy = greaterThanEqual(u_xlat3.xyxx, vs_TEXCOORD3.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat0.x;
    u_xlatb1 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat10_1 = texture2D(cubism_MaskTexture, vs_TEXCOORD3.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.w * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat1.www * u_xlat1.xyz;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0 = u_xlat1 * vec4(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CUBISM_INVERT_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    vs_TEXCOORD3.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	float cubism_ModelOpacity;
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D cubism_MaskTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
void main()
{
    u_xlat0.xy = cubism_MaskTile.ww * cubism_MaskTile.yz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD3.xyxx, u_xlat0.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3.xy = cubism_MaskTile.yz * cubism_MaskTile.ww + cubism_MaskTile.ww;
    u_xlatb3.xy = greaterThanEqual(u_xlat3.xyxx, vs_TEXCOORD3.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat3.y * u_xlat0.x;
    u_xlatb1 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat10_1 = texture2D(cubism_MaskTexture, vs_TEXCOORD3.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat10_1.w * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_2.xyz = u_xlat1.www * u_xlat1.xyz;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat0 = u_xlat1 * vec4(cubism_ModelOpacity);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "CUBISM_MASK_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CUBISM_MASK_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CUBISM_MASK_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "CUBISM_MASK_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CUBISM_MASK_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CUBISM_MASK_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "CUBISM_INVERT_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CUBISM_INVERT_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CUBISM_INVERT_ON" }
""
}
}
}
}
}