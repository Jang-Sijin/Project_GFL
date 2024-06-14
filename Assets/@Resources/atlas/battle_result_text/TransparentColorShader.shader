Shader "Custom/TransparentColorShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ColorKey ("Color Key", Color) = (1,1,0,1) // Default is yellow
        _Tolerance ("Tolerance", Range(0,1)) = 0.1
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 200

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _ColorKey;
            float _Tolerance;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                half4 colorKey = half4(_ColorKey.rgb, 1.0);
                float diff = distance(col.rgb, colorKey.rgb);
                if (diff < _Tolerance)
                {
                    col.a = 0.0;
                }
                return col;
            }
            ENDCG
        }
    }
}