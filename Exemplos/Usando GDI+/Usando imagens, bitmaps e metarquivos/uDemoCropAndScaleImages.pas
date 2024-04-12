unit uDemoCropAndScaleImages;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   Se7e.Drawing.Rectangle,
   uDemo;

type
  TDemoCropAndScaleImages = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// A interface <A>TGdipGraphics</A> fornece v�rios m�todos <A>DrawImage</A>,
/// alguns dos quais possuem par�metros retangulares de origem e destino que voc� pode
/// use para cortar e dimensionar imagens.
///
/// O exemplo a seguir constr�i um objeto <A>TGdipImage</A> a partir do arquivo
/// Apple.gif. O c�digo desenha a imagem inteira da ma�� em seu tamanho original. O
/// c�digo ent�o chama o m�todo <A>DrawImage</A> de um objeto <A>TGdipGraphics</A> para
///desenha uma parte da imagem da ma�� em um ret�ngulo de destino que seja maior
/// do que a imagem original da ma��.
///
/// O m�todo <A>DrawImage</A> determina qual parte da ma�� desenhar
/// olhando para o ret�ngulo de origem, que � especificado pelo terceiro, quarto,
/// quinto e sexto argumentos. Neste caso, a ma�� � cortada em 75 por cento
/// de sua largura e 75 por cento de sua altura.
///
/// O m�todo <A>DrawImage</A> determina onde desenhar a ma�� cortada e
/// qual o tamanho da ma�� cortada olhando para o ret�ngulo de destino,
/// que � especificado pelo segundo argumento. Neste caso, o destino
/// o ret�ngulo � 30% mais largo e 30% mais alto que a imagem original.

procedure TDemoCropAndScaleImages.Run;
var
  Image: TGdipImage;
  Width, Height: Integer;
  DestinationRect: TRectangleF;
begin
  Image := TGdipImage.FromFile('..\..\imagens\Apple.gif');
  Width := Image.Width;
  Height := Image.Height;

  // Torna o ret�ngulo de destino 30% mais largo e
  // 30% mais alto que a imagem original.
  //Coloca o canto superior esquerdo do destino
  // ret�ngulo em (150, 20).
  DestinationRect := TRectangleF.Create(150, 20, 1.3 * Width, 1.3 * Height);

  // Desenha a imagem inalterada com o canto superior esquerdo em (0, 0).
  Graphics.DrawImage(Image, 0, 0);

  //Desenha uma parte da imagem. Dimensione essa parte da imagem
  // para que preencha o ret�ngulo de destino.
  Graphics.DrawImage(Image, DestinationRect,
    TRectangleF.Create(0,
                       0,          // canto superior esquerdo do ret�ngulo de origem
                       0.75 * Width,  // largura do ret�ngulo de origem
                       0.75 * Height), // altura do ret�ngulo de origem
    TGdipGraphicsUnit.Pixel);

  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Cortar e dimensionar imagens', TDemoCropAndScaleImages);

end.
