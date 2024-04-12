unit uDemoRotateReflectSkew;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   System.Types,
   uDemo;

type
  TDemoRotateReflectSkew = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Voc� pode girar, refletir e inclinar uma imagem especificando pontos de destino
/// para os cantos superior esquerdo, superior direito e inferior esquerdo do original
/// imagem. Os tr�s pontos de destino determinam uma transforma��o afim que
/// mapeia a imagem retangular original para um paralelogramo. (O canto inferior direito
/// canto da imagem original � mapeado para o quarto canto do
/// paralelogramo, que � calculado a partir dos tr�s destinos especificados
/// pontos.)
///
/// Por exemplo, suponha que a imagem original seja um ret�ngulo com canto superior esquerdo
/// canto em (0, 0), canto superior direito em (100, 0) e canto inferior esquerdo em
/// (0, 50). Agora suponha que mapeemos esses tr�s pontos para pontos de destino como
/// no seguinte c�digo:

procedure TDemoRotateReflectSkew.Run;
var
  Image: TGdipImage;
begin
  var DestinationPoints: TArray<TPoint> :=
  [
    Point(200,  20),  // destino para o ponto superior esquerdo do original
    Point(110, 100),  // destino para o ponto superior direito do original
    Point(250, 30)    // destino para o ponto inferior esquerdo do original
  ];

  Image := TGdipImage.FromFile('..\..\imagens\Stripes.bmp');
  // Desenhe a imagem inalterada com o canto superior esquerdo em (0, 0).
  Graphics.DrawImage(Image, 0, 0);
  // Desenhe a imagem mapeada no paralelogramo.
  Graphics.DrawImage(Image, DestinationPoints);
  Image.Free();
end;

/// A ilustra��o mostra a imagem original e a imagem mapeada para o
/// paralelogramo. A imagem original foi distorcida, refletida, girada e
/// traduzido. O eixo x ao longo da borda superior da imagem original � mapeado
/// para a linha que passa por (200, 20) e (110, 100). O eixo y ao longo do
/// a borda esquerda da imagem original � mapeada para a linha que atravessa
/// (200, 20) e (250, 30).
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Girar, refletir e inclinar imagens', TDemoRotateReflectSkew);

end.
