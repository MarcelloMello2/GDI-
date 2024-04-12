unit uDemoColorRemapTable;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoColorRemapTable = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoColorRemapTable }

{$REGION}
/// Remapeamento � o processo de convers�o das cores em uma imagem de acordo com um
/// tabela de remapeamento de cores. A tabela de remapeamento de cores � uma matriz de <A>TGdipColorMap</A>
/// registros. Cada registro <A>TGdipColorMap</A> no array possui um <B>OldColor</B>
/// membro e um membro <B>NewColor</B>.
///
/// Quando GDI+ desenha uma imagem, cada pixel da imagem � comparado ao array
/// de cores antigas. Se a cor de um pixel corresponder a uma cor antiga, sua cor ser� alterada
/// para a nova cor correspondente. As cores s�o alteradas apenas para renderiza��o �
/// os valores de cores da pr�pria imagem (armazenados em um objeto Imagem ou Bitmap)
/// n�o s�o alterados.
///
/// Para desenhar uma imagem remapeada, inicialize um array de registros <A>TGdipColorMap</A>.
/// Passa esse array para o m�todo <A>SetRemapTable</A> de um
/// objeto <A>TGdipImageAttributes</A> e depois passa o <A>TGdipImageAttributes</A>
/// objeto para o m�todo <A>TGdipGraphics.DrawImage</A> de um objeto <A>TGdipGraphics</A>.
///
/// O exemplo a seguir cria um objeto <A>TGdipImage</A> a partir do arquivo
/// RemapInput.bmp. O c�digo cria uma tabela de remapeamento de cores que consiste em um
/// �nico registro <A>TGdipColorMap</A>. O membro <B>OldColor</B> do
/// O registro <A>TGdipColorMap</A> � vermelho e o membro <B>NewColor</B> � azul. O
/// a imagem � desenhada uma vez sem remapeamento e uma vez com remapeamento. O remapeamento
/// o processo altera todos os pixels vermelhos para azuis.

procedure TDemoColorRemapTable.Run;
var
  Image: TGdipImage;
  ImageAttributes: TGdipImageAttributes;
  Width, Height: Integer;
  ColorMap: TArray<TGdipColorMap>;
begin
  Image := TGdipImage.FromFile('..\..\imagens\RemapInput.bmp');
  ImageAttributes := TGdipImageAttributes.Create;
  Width := Image.Width;
  Height := Image.Height;

  SetLength(ColorMap, 1);
  ColorMap[0].OldColor := TGdipColor.Red;
  ColorMap[0].NewColor := TGdipColor.Blue;
  ImageAttributes.SetRemapTable(ColorMap, TGdipColorAdjustType.Bitmap);

  Graphics.DrawImage(Image, 10, 10, Width, Height);
  Graphics.DrawImage(Image,
    TRectangle.Create(150, 10, Width, Height), // ret�ngulo de destino
    0, 0, Width, Height,    // ret�ngulo de origem
    TGdipGraphicsUnit.Pixel, ImageAttributes);

  ImageAttributes.Free();
  Image.Free();
end;

/// A ilustra��o acima mostra a imagem original � esquerda e a imagem remapeada
/// imagem � direita.
{$ENDREGION}

initialization
  RegisterDemo('Recolorir\Usando uma tabela de remapeamento de cores', TDemoColorRemapTable);

end.
