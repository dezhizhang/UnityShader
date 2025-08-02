Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct sv
            {
                // 顶点着色器
                float4 vertex:POSITION;
                // 法线
                float4 normal:NORMAL;
                // uv信息
                float4 texcoord:TEXCOORD0;
            };

            struct v2f
            {
                float4 pos:SV_POSITION;
                fixed3 color:COLOR;
            };

            // 顶点着色器
            v2f vert(sv sv)
            {
                v2f vf;
                vf.pos = UnityObjectToClipPos(sv.vertex);
                vf.color = sv.normal + 0.5 + fixed3(0.5, 0.5, 0.5);
                return vf;
            }

            // 偏元着色器
            fixed4 frag(v2f i):SV_Target
            {
                return fixed4(i.color, 1);
            }

            
            ENDCG
        }
    }
}