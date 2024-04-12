unit uDemoAvoidAutomaticScaling;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoAvoidAutomaticScaling = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Se voc� passar apenas o canto superior esquerdo de uma imagem para o <A>DrawImage</A>
/// m�todo, o Microsoft Windows GDI+ pode dimensionar a imagem, o que diminuiria
/// desempenho.
///
/// A seguinte chamada ao m�todo <A>DrawImage</A> especifica um canto superior esquerdo
/// canto de (50, 30) mas n�o especifica um ret�ngulo de destino:
///
/// <C>Graphics.DrawImage(Imagem, 50, 30); // canto superior esquerdo em (50, 30)</C>
///
/// Embora esta seja a vers�o mais f�cil do m�todo <A>DrawImage</A> em termos
/// do n�mero de argumentos necess�rios, n�o � necessariamente o mais
/// eficiente. Se o n�mero de pontos por polegada no dispositivo de exibi��o atual for
/// diferente do n�mero de pontos por polegada no dispositivo onde a imagem foi
/// criada, o GDI+ dimensiona a imagem para que seu tamanho f�sico no atual
/// o dispositivo de exibi��o est� o mais pr�ximo poss�vel do seu tamanho f�sico no dispositivo
/// onde foi criado.
///
/// Se voc� quiser evitar tal escalonamento, passe a largura e a altura de um
/// ret�ngulo de destino para o m�todo <A>DrawImage</A>. O exemplo a seguir
/// desenha a mesma imagem duas vezes. No primeiro caso, a largura e a altura do
/// ret�ngulo de destino n�o s�o especificados e a imagem � automaticamente
/// dimensionado. No segundo caso, a largura e a altura (medidas em pixels) do
/// o ret�ngulo de destino � especificado para ser igual � largura e altura
/// da imagem original.

procedure TDemoAvoidAutomaticScaling.Run;
var
  Image: TGdipImage;
begin
  Image := TGdipImage.FromFile('..\..\imagens\Texture.bmp');
  Graphics.DrawImage(Image, 10, 10);
  Graphics.DrawImage(Image, 120, 10, Image.Width, Image.Height);
  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Melhorando o desempenho evitando o escalonamento autom�tico', TDemoAvoidAutomaticScaling);

end.
