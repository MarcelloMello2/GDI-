unit uDemoTranslatingColors;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoTranslatingColors = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoTranslatingColors }

{$REGION}
/// Uma tradu��o adiciona um valor a um ou mais dos quatro componentes de cor. O
/// entradas da matriz de cores que representam tradu��es s�o fornecidas a seguir
/// mesa.
///
/// <B>Componente para</B>
/// <B>ser traduzido</B><T><B>Entrada de matriz</B>
/// Vermelho<T><T>[4,0]
/// Verde<T><T>[4,1]
/// Azul<T><T>[4,2]
/// Alfa<T><T>[4,2]
///
/// O exemplo a seguir constr�i um objeto <A>TGdipImage</A> a partir do arquivo
/// ColorBars.bmp. Em seguida, o c�digo adiciona 0,75 ao componente vermelho de cada pixel em
/// a imagem. A imagem original � desenhada ao lado da imagem transformada.

procedure TDemoTranslatingColors.Run;
var
  ColorMatrix: TGdipColorMatrix;
  Image: TGdipImage;
  ImageAttributes: TGdipImageAttributes;
  Width, Height: Integer;
begin
  ColorMatrix := TGdipColorMatrix.Create
  (
    [
        [1.0 , 0.0, 0.0, 0.0, 0.0],
        [0.0 , 1.0, 0.0, 0.0, 0.0],
        [0.0 , 0.0, 1.0, 0.0, 0.0],
        [0.0 , 0.0, 0.0, 1.0, 0.0],
        [0.75, 0.0, 0.0, 0.0, 1.0]
    ]
  );

  Image := TGdipImage.FromFile('..\..\imagens\ColorBars.bmp');
  ImageAttributes := TGdipImageAttributes.Create();
  Width := Image.Width;
  Height := Image.Height;

  ImageAttributes.SetColorMatrix(ColorMatrix, TGdipColorMatrixFlag.Default, TGdipColorAdjustType.Bitmap);
  Graphics.DrawImage(Image, 10, 10, Width, Height);
  Graphics.DrawImage(Image,
    TRectangle.Create(150, 10, Width, Height), // ret�ngulo de destino
    0, 0, Width, Height,    // ret�ngulo de origem
    TGdipGraphicsUnit.Pixel, ImageAttributes);

  ColorMatrix.Free();
  ImageAttributes.Free();
  Image.Free();
end;

/// A ilustra��o acima mostra a imagem original � esquerda e o
/// imagem transformada � direita.
///
/// A tabela a seguir lista os vetores de cores para as quatro barras antes e
/// ap�s a tradu��o em vermelho. Observe que, como o valor m�ximo para uma cor
/// componente � 1, o componente vermelho na segunda linha n�o muda.
/// (Da mesma forma, o valor m�nimo para um componente de cor � 0.)
///
/// <B>Original</B><T><T><B>Traduzido</B>
/// Preto (0, 0, 0, 1)<T>(0,75, 0, 0, 1)
/// Vermelho (1, 0, 0, 1)<T><T>(1, 0, 0, 1)
/// Verde (0, 1, 0, 1)<T>(0,75, 1, 0, 1)
/// Azul (0, 0, 1, 1)<T><T>(0,75, 0, 1, 1)
{$ENDREGION}

initialization
  RegisterDemo('Recolorir\Traduzindo Cores', TDemoTranslatingColors);

end.
