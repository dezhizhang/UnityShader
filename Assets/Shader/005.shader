Shader "Unlit/005"
{
    Properties
    {
        _Diffuse("Diffuse",Color) = (1,1,1,1)

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
            // make fog work
            #pragma multi_compile_fog
            #include "UnityCG.cginc"

            fixed4 _Diffuse;

            struct v2f
            {
                float4 vertex:SV_POSITION;
                fixed3 color:Color;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                // 添加环境光
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
                fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                
                // 计算散射光
                fixed3 diffuse = unity_LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLight));

                o.color = diffuse + ambient;
                return o;
            }

            fixed4 frag(v2f i):SV_Target
            {
                return fixed4(i.color,1);
            }
            ENDCG
        }
    }
}