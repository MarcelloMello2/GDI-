unit uDemoRotatingColors;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoRotatingColors = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoRotatingColors }

{$REGION}
/// A rota��o em um espa�o de cores quadridimensional � dif�cil de visualizar. Pudermos
/// facilita a visualiza��o da rota��o concordando em manter uma das cores
/// componentes corrigidos. Suponha que concordamos em manter o componente alfa fixo em 1
/// (totalmente opaco). Ent�o podemos visualizar um espa�o de cores tridimensional com
/// eixos vermelho, verde e azul conforme mostrado na ilustra��o a seguir.
///
/// <I>Veja o t�pico do Platform SDK "Rotating Colors" para ver a ilustra��o</I>
///
/// Uma cor pode ser considerada como um ponto no espa�o 3-D. Por exemplo, o ponto
/// (1, 0, 0) no espa�o representa a cor vermelha, e o ponto (0, 1, 0) no
/// espa�o representa a cor verde.
///
/// A ilustra��o a seguir mostra o que significa girar a cor (1, 0, 0)
/// atrav�s de um �ngulo de 60 graus no plano Vermelho-Verde. Rota��o em um plano
/// paralelo ao plano Vermelho-Verde pode ser pensado como uma rota��o em torno do azul
/// eixo.
///
/// <I>Veja o t�pico do Platform SDK "Rotating Colors" para ver a ilustra��o</I>
///
/// A ilustra��o a seguir mostra como inicializar uma matriz de cores para executar
/// rota��es sobre cada um dos tr�s eixos de coordenadas (vermelho, verde, azul).
///
/// <I>Veja o t�pico do Platform SDK "Rotating Colors" para ver a ilustra��o</I>
///
/// O exemplo a seguir pega uma imagem que � toda de uma cor (1, 0, 0.6) e
/// aplica uma rota��o de 60 graus em torno do eixo azul. O �ngulo da rota��o
/// � varrido em um plano paralelo ao plano Vermelho-Verde.

procedure TDemoRotatingColors.Run;
const
  Degrees = 60;
  Radians = Degrees * Pi / 180;
var
  Bitmap: TGdipBitmap;
  BitmapGraphics: TGdipGraphics;
  ImageAttributes: TGdipImageAttributes;
  ColorMatrix: TGdipColorMatrix;
begin
  Bitmap := TGdipBitmap.Create(100, 100);
  BitmapGraphics := TGdipGraphics.FromImage(Bitmap);
  BitmapGraphics.Clear(TGdipColor.FromArgb(255, 204, 0, 153));
  ImageAttributes := TGdipImageAttributes.Create;

  ColorMatrix := TGdipColorMatrix.Create();
  ColorMatrix[0,0] := Cos(Radians);
  ColorMatrix[1,0] := -Sin(Radians);
  ColorMatrix[0,1] := Sin(Radians);
  ColorMatrix[1,1] := Cos(Radians);

  ImageAttributes.SetColorMatrix(ColorMatrix, TGdipColorMatrixFlag.Default, TGdipColorAdjustType.Bitmap);
  Graphics.DrawImage(Bitmap, 10, 10, 100, 100);
  Graphics.DrawImage(Bitmap,
    TRectangle.Create(150, 10, 100, 100), // ret�ngulo de destino
    0, 0, 100, 100,    // ret�ngulo de origem
    TGdipGraphicsUnit.Pixel, ImageAttributes);

  ColorMatrix.Free();
  ImageAttributes.Free();
  BitmapGraphics.Free();
  Bitmap.Free();
end;

/// A ilustra��o acima mostra a imagem original � esquerda e o
/// imagem transformada � direita.
///
/// A rota��o de cores realizada no exemplo de c�digo anterior pode ser visualizada
/// do seguinte modo.
///
/// <I>Veja o t�pico do Platform SDK "Rotating Colors" para ver a ilustra��o</I>
{$ENDREGION}

initialization
  RegisterDemo('Recolorir\Rota��o de cores', TDemoRotatingColors);

end.
