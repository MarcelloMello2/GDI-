unit uDemoScalingColors;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoScalingColors = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoScalingColors }

{$REGION}
/// Uma transforma��o de escala multiplica um ou mais dos quatro componentes de cor
/// por um n�mero. As entradas da matriz de cores que representam a escala s�o fornecidas em
/// a tabela a seguir.
///
/// <B>Componente para</B>
/// <B>ser dimensionado</B><T><B>entrada de matriz</B>
/// Vermelho<T><T>[0,0]
/// Verde<T><T>[1,1]
/// Azul<T><T>[2,2]
/// Alfa<T><T>[3,3]
///
/// O exemplo a seguir constr�i um objeto <A>TGdipImage</A> a partir do arquivo
/// ColorBars2.bmp. Em seguida, o c�digo dimensiona o componente azul de cada pixel no
/// imagem por um fator de 2. A imagem original � desenhada ao lado da
/// imagem transformada.

procedure TDemoScalingColors.Example1;
var
  ColorMatrix: TGdipColorMatrix;
  Image: TGdipImage;
  ImageAttributes: TGdipImageAttributes;
  Width, Height: Integer;
begin
  ColorMatrix := TGdipColorMatrix.Create
  (
    [
      [1.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 1.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 2.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 1.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 1.0]
    ]
  );

  Image := TGdipImage.FromFile('..\..\imagens\ColorBars2.bmp');
  ImageAttributes := TGdipImageAttributes.Create;
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

/// A ilustra��o superior acima mostra a imagem original � esquerda e o
/// imagem transformada � direita.
///
/// A tabela a seguir mostra os vetores de cores para as quatro barras antes e
/// ap�s a escala azul. Observe que o componente azul na quarta barra de cores
/// passou de 0,8 para 0,6. Isso ocorre porque o GDI+ ret�m apenas a parte fracion�ria
/// do resultado. Por exemplo, (2)(0,8) = 1,6, e a parte fracion�ria de 1,6
/// � 0,6. Reter apenas a parte fracion�ria garante que o resultado seja sempre
/// no intervalo [0, 1].
///
/// <B>Original</B><T><T><B>Escalonado</B>
/// (0,4, 0,4, 0,4, 1)<T><T>(0,4, 0,4, 0,8, 1)
/// (0,4, 0,2, 0,2, 1)<T><T>(0,4, 0,2, 0,4, 1)
/// (0,2, 0,4, 0,2, 1)<T><T>(0,2, 0,4, 0,4, 1)
/// (0,4, 0,4, 0,8, 1)<T><T>(0,4, 0,4, 0,6, 1)
///
/// O exemplo a seguir constr�i um objeto <A>TGdipImage</A> a partir do arquivo
/// ColorBars3.bmp. Em seguida, o c�digo dimensiona os componentes vermelho, verde e azul do
/// cada pixel da imagem. Os componentes vermelhos s�o reduzidos em 25 por cento, os
/// os componentes verdes s�o reduzidos em 35% e os componentes azuis s�o
/// reduziu 50 por cento.

procedure TDemoScalingColors.Example2;
var
  ColorMatrix: TGdipColorMatrix;
  Image: TGdipImage;
  ImageAttributes: TGdipImageAttributes;
  Width, Height: Integer;
begin
  ColorMatrix := TGdipColorMatrix.Create
  (
    [
      [0.75, 0.0 , 0.0, 0.0, 0.0],
      [0.0 , 0.65, 0.0, 0.0, 0.0],
      [0.0 , 0.0 , 0.5, 0.0, 0.0],
      [0.0 , 0.0 , 0.0, 1.0, 0.0],
      [0.0 , 0.0 , 0.0, 0.0, 1.0]
    ]
  );

  Image := TGdipImage.FromFile('..\..\imagens\ColorBars3.bmp');
  ImageAttributes := TGdipImageAttributes.Create;
  Width := Image.Width;
  Height := Image.Height;

  ImageAttributes.SetColorMatrix(ColorMatrix, TGdipColorMatrixFlag.Default, TGdipColorAdjustType.Bitmap);
  Graphics.DrawImage(Image, 10, 150, Width, Height);
  Graphics.DrawImage(Image,
    TRectangle.Create(150, 150, Width, Height), // ret�ngulo de destino
    0, 0, Width, Height,    // ret�ngulo de origem
    TGdipGraphicsUnit.Pixel, ImageAttributes);

  ColorMatrix.Free();
  ImageAttributes.Free();
  Image.Free();
end;

/// A ilustra��o inferior acima mostra a imagem original � esquerda e o
/// imagem transformada � direita.
///
/// A tabela a seguir mostra os vetores de cores para as quatro barras antes e
/// ap�s a escala vermelha, verde e azul.
///
/// <B>Original</B><T><T><B>Escalonado</B>
/// (0,6, 0,6, 0,6, 1)<T><T>(0,45, 0,39, 0,3, 1)
/// (0, 1, 1, 1)<T><T>(0, 0,65, 0,5, 1)
/// (1, 1, 0, 1)<T><T>(0,75, 0,65, 0, 1)
/// (1, 0, 1, 1)<T><T>(0,75, 0, 0,5, 1)
{$ENDREGION}

procedure TDemoScalingColors.Run;
begin
  Example1;
  Example2;
end;

initialization
  RegisterDemo('Recolorir\Dimensionando cores', TDemoScalingColors);

end.
