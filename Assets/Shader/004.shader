Shader "Unlit/004"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color",Color) = (1,1,1,1)
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
            
            #include "UnityCG.cginc"
            
            struct v2f
            {
                float4 pos:SV_POSITION;
                fixed3 color:COLORO;
            };
            
            
            v2f vert(appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                // 法线
                o.color = v.tangent.xyz * 0.5 + fixed3(0.5, 0.5, 0.5);
                
                o.color = v.normal * 0.5 + fixed3(0.5,0.5,0.5);
                o.color = fixed4(v.texcoord.xy,0,1);
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