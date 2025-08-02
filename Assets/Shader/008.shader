Shader "Unlit/008"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Diffuse("Diffuse",Color) = (1,1,1,1)
        _Specular("Specular",Color) = (0,1,0,1)
        _Gloss("_Gloss",Range(1,256)) = 5
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
            #include "Lighting.cginc"

            fixed4 _Diffuse;
            fixed4 _Specular;
            float __Gloss;

            struct v2f
            {
                float4 vertex:SV_POSITION;
                fixed3 color:Color;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                fixed3 ambit = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
                fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * max(0, dot(worldNormal, worldLight));

                fixed3 reflectDir = normalize(reflect(-worldLight, worldNormal));
                fixed3 viewDir = normalize(_WorldSpaceLightPos0.xyz - UnityObjectToWorldDir(v.vertex));
                // 高光颜色值
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0, dot(reflectDir, viewDir)), __Gloss);

                o.color = diffuse + ambit + specular;
                return o;
            }

            fixed4 frag(v2f i):SV_Target
            {
                return fixed4(i.color, 1);
            }
            ENDCG
        }
    }
}