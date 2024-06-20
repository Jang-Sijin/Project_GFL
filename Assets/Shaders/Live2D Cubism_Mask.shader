//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Live2D Cubism/Mask" {
Properties {
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  ZWrite Off
  Cull Off
  GpuProgramID 3852
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
void main()
{
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    u_xlat0.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    u_xlat1.x = float(2.0);
    u_xlat1.z = float(1.0);
    u_xlat1.yw = _ProjectionParams.xx;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.z = u_xlat0.y * 2.0;
    gl_Position.xy = (-u_xlat1.zw) + u_xlat0.xz;
    gl_Position.zw = vec2(1.0, 1.0);
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
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
lowp float u_xlat10_1;
void main()
{
    u_xlatb0 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat0 * vec4(u_xlat10_1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
void main()
{
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    u_xlat0.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    u_xlat1.x = float(2.0);
    u_xlat1.z = float(1.0);
    u_xlat1.yw = _ProjectionParams.xx;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.z = u_xlat0.y * 2.0;
    gl_Position.xy = (-u_xlat1.zw) + u_xlat0.xz;
    gl_Position.zw = vec2(1.0, 1.0);
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
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
lowp float u_xlat10_1;
void main()
{
    u_xlatb0 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat0 * vec4(u_xlat10_1);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 cubism_MaskTile;
uniform 	vec4 cubism_MaskTransform;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
void main()
{
    u_xlat0.xy = cubism_MaskTile.yz + vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * cubism_MaskTile.ww;
    u_xlat4 = cubism_MaskTile.w * cubism_MaskTransform.z;
    u_xlat1.xy = in_POSITION0.xy + (-cubism_MaskTransform.xy);
    u_xlat0.xy = u_xlat1.xy * vec2(u_xlat4) + u_xlat0.xy;
    u_xlat1.x = float(2.0);
    u_xlat1.z = float(1.0);
    u_xlat1.yw = _ProjectionParams.xx;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.z = u_xlat0.y * 2.0;
    gl_Position.xy = (-u_xlat1.zw) + u_xlat0.xz;
    gl_Position.zw = vec2(1.0, 1.0);
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
uniform 	vec4 cubism_MaskTile;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
lowp float u_xlat10_1;
void main()
{
    u_xlatb0 = equal(cubism_MaskTile.xxxx, vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat0 * vec4(u_xlat10_1);
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