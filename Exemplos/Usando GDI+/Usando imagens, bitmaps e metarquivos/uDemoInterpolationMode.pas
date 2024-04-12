unit uDemoInterpolationMode;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoInterpolationMode = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// O modo de interpola��o de um objeto <A>TGdipGraphics</A> influencia a forma como
/// Microsoft Windows GDI+ dimensiona (alonga e encolhe) imagens. O
/// A enumera��o <A>TGdipInterpolationMode</A> define v�rios modos de interpola��o,
/// alguns dos quais s�o mostrados na lista a seguir:
///
/// - TGdipInterpolationMode.NearestNeighbor
/// - TGdipInterpolationMode.Bilinear
/// - TGdipInterpolationMode.HighQualityBilinear
/// - TGdipInterpolationMode.Bicubic
/// - TGdipInterpolationMode.HighQualityBicubic
///
/// Para esticar uma imagem, cada pixel da imagem original deve ser mapeado para um
/// grupo de pixels na imagem maior. Para reduzir uma imagem, grupos de pixels em
/// a imagem original deve ser mapeada para pixels �nicos na imagem menor. O
/// a efic�cia dos algoritmos que realizam esses mapeamentos determina a
/// qualidade de uma imagem dimensionada. Algoritmos que produzem escalas de maior qualidade
/// imagens tendem a exigir mais tempo de processamento. Na lista anterior,
/// <B>TGdipInterpolationMode.NearestNeighbor</B> � o modo de qualidade mais baixa e
/// <B>TGdipInterpolationMode.HighQualityBicubic</B> � o modo de mais alta qualidade.
///
/// Para definir o modo de interpola��o, passe um dos membros do
/// enumera��o <A>TGdipInterpolationMode</A> para <A>InterpolationMode</A>
/// propriedade de um objeto <A>TGdipGraphics</A>.
///
/// O exemplo a seguir desenha uma imagem e depois a reduz com tr�s
/// diferentes modos de interpola��o:

procedure TDemoInterpolationMode.Run;
var
  Image: TGdipImage;
  Width, Height: Integer;
begin
  Image := TGdipImage.FromFile('..\..\imagens\GrapeBunch.bmp');
  Width := Image.Width;
  Height := Image.Height;

  // Desenhe a imagem sem encolher ou esticar.
  Graphics.DrawImage(Image,
    TRectangle.Create(10, 10, Width, Height), // ret�ngulo de destino
    0, 0,      // canto superior esquerdo do ret�ngulo de origem
    Width,     // largura do ret�ngulo de origem
    Height,    // altura do ret�ngulo de origem
    TGdipGraphicsUnit.Pixel);

  // Reduza a imagem usando interpola��o de baixa qualidade.
  Graphics.InterpolationMode := TGdipInterpolationMode.NearestNeighbor;
  Graphics.DrawImage(Image,
    TRectangleF.Create(10, 250, 0.6 * Width, 0.6 * Height), // ret�ngulo de destino
    TRectangleF.Create(0, 0,      // canto superior esquerdo do ret�ngulo de origem
                       Width,     // largura do ret�ngulo de origem
                       Height),   // altura do ret�ngulo de origem
    TGdipGraphicsUnit.Pixel);

  // Reduza a imagem usando interpola��o de qualidade m�dia.
  Graphics.InterpolationMode := TGdipInterpolationMode.HighQualityBilinear;
  Graphics.DrawImage(Image,
    TRectangleF.Create(150, 250, 0.6 * Width, 0.6 * Height), // ret�ngulo de destino
    TRectangleF.Create(0, 0,      // canto superior esquerdo do ret�ngulo de origem
                       Width,     // largura do ret�ngulo de origem
                       Height),   // altura do ret�ngulo de origem
    TGdipGraphicsUnit.Pixel);

  // Reduza a imagem usando interpola��o de alta qualidade.
  Graphics.InterpolationMode := TGdipInterpolationMode.HighQualityBicubic;
  Graphics.DrawImage(Image,
    TRectangleF.Create(290, 250, 0.6 * Width, 0.6 * Height), // ret�ngulo de destino
    TRectangleF.Create(0, 0,      // canto superior esquerdo do ret�ngulo de origem
                       Width,     // largura do ret�ngulo de origem
                       Height),   // altura do ret�ngulo de origem
    TGdipGraphicsUnit.Pixel);

  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Usando o modo de interpola��o para controlar a qualidade da imagem durante o dimensionamento', TDemoInterpolationMode);

end.
