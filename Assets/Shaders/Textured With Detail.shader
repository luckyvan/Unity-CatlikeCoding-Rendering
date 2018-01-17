// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Textured With Detail" {

    Properties {
	    _Tint ("Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Texture", 2D) = "white" {}
		_DetailedTex ("Detailed Texture", 2D) = "gray" {}
	}

	SubShader {
		Pass {
		    CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"

			float4 _Tint;
			sampler2D _MainTex;
			sampler2D _DetailedTex;
			float4 _MainTex_ST;
			float4 _DetaledTex_ST;

			struct VertexData{
			    float4 position: POSITION;
				float2 uv: TEXCOORD0;
			};

			struct Interpolators{
			    float4 position: SV_POSITION;
				float2 uv: TEXCOORD0;
			};

			Interpolators MyVertexProgram(VertexData v) {
			    Interpolators i;
			    i.position = UnityObjectToClipPos(v.position);
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return i;
			}

			float4 MyFragmentProgram(Interpolators i) : SV_TARGET {
			    float4 color = tex2D(_MainTex, i.uv) * _Tint;
				color *= tex2D(_MainTex, i.uv * 10) * 2;
				return color;
			}

			ENDCG
		}		
	}

}