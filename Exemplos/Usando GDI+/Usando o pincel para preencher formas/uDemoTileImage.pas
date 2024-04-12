unit uDemoTileImage;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoTileImage = class(TDemo)
  strict private
    procedure Tile;
    procedure FlipHorizontally;
    procedure FlipVertically;
    procedure FlipXY;
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Assim como os azulejos podem ser colocados um ao lado do outro para cobrir um piso, imagens retangulares
/// podem ser colocadas uma ao lado da outra para preencher (em mosaico) uma forma. Para preencher o
/// interior de uma forma com mosaico, use um pincel de textura. Quando voc� constr�i um
/// objeto <A>TGdipTextureBrush</A>, um dos argumentos que voc� passa para o
/// construtor � um objeto <A>TGdipImage</A>. Quando voc� usa o pincel de textura para
/// pintar o interior de uma forma, a forma � preenchida com c�pias repetidas dessa imagem.
///
/// A propriedade de modo de envolvimento do objeto <A>TGdipTextureBrush</A> determina como a
/// imagem � orientada � medida que � repetida em uma grade retangular. Voc� pode fazer com que todos
/// os ladrilhos na grade tenham a mesma orienta��o, ou voc� pode fazer a imagem
/// virar de uma posi��o na grade para a pr�xima. A virada pode ser horizontal,
/// vertical ou ambas. Os exemplos a seguir demonstram a aplica��o de mosaico com diferentes
/// tipos de virada.
///
/// <H>Preenchendo com uma Imagem em Mosaico</H>
/// Este exemplo usa uma imagem de 75�75 para preencher um ret�ngulo de 200�200:

procedure TDemoTileImage.Tile;
var
  Image: TGdipImage;
  Brush: TGdipTextureBrush;
  BlackPen: TGdipPen;
begin
  Image := TGdipImage.FromFile('..\..\imagens\HouseAndTree.gif');
  Brush := TGdipTextureBrush.Create(Image);
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));

  Graphics.FillRectangle(Brush, TRectangle.Create(0, 0, 200, 200));
  Graphics.DrawRectangle(BlackPen, TRectangle.Create(0, 0, 200, 200));

  BlackPen.Free();
  Brush.Free();
  Image.Free();
end;

/// Imagem no canto superior esquerdo: observe que todos os ladrilhos t�m a mesma orienta��o; n�o h�
/// virada.
///
/// <H>Virando uma Imagem Horizontalmente Enquanto Preenche com Mosaico</H>
/// Este exemplo usa uma imagem de 75�75 para preencher um ret�ngulo de 200�200. O modo de envolvimento
/// � configurado para virar a imagem horizontalmente.

procedure TDemoTileImage.FlipHorizontally;
var
  Image: TGdipImage;
  Brush: TGdipTextureBrush;
  BlackPen: TGdipPen;
begin
  Image := TGdipImage.FromFile('..\..\imagens\HouseAndTree.gif');
  Brush := TGdipTextureBrush.Create(Image);
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));

  Brush.WrapMode := TGdipWrapMode.TileFlipX;
  Graphics.FillRectangle(Brush, TRectangle.Create(300, 0, 200, 200));
  Graphics.DrawRectangle(BlackPen, TRectangle.Create(300, 0, 200, 200));

  BlackPen.Free();
  Brush.Free();
  Image.Free();
end;

/// A imagem no canto superior direito mostra como o ret�ngulo � preenchido com a imagem em mosaico. Note
/// que � medida que voc� se move de um ladrilho para o pr�ximo em uma determinada linha, a imagem �
/// virada horizontalmente.
///
/// <H>Virando uma Imagem Verticalmente Enquanto Preenche com Mosaico</H>
/// Este exemplo usa uma imagem de 75�75 para preencher um ret�ngulo de 200�200. O modo de envolvimento
/// � configurado para virar a imagem verticalmente.

procedure TDemoTileImage.FlipVertically;
var
  Image: TGdipImage;
  Brush: TGdipTextureBrush;
  BlackPen: TGdipPen;
begin
  Image := TGdipImage.FromFile('..\..\imagens\HouseAndTree.gif');
  Brush := TGdipTextureBrush.Create(Image);
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));

  Brush.WrapMode := TGdipWrapMode.TileFlipY;
  Graphics.FillRectangle(Brush, TRectangle.Create(0, 300, 200, 200));
  Graphics.DrawRectangle(BlackPen, TRectangle.Create(0, 300, 200, 200));

  BlackPen.Free();
  Brush.Free();
  Image.Free();
end;

/// A ilustra��o no canto inferior esquerdo mostra como o ret�ngulo � preenchido com a imagem em mosaico. Note
/// que � medida que voc� se move de um ladrilho para o pr�ximo em uma dada coluna,
/// a imagem � virada verticalmente.
///
/// <H>Virando uma Imagem Horizontal e Verticalmente Enquanto Preenche com Mosaico</H>
/// Este exemplo usa uma imagem de 75�75 para preencher um ret�ngulo de 200�200 com mosaico. O modo de envolvimento
/// � configurado para virar a imagem tanto horizontal quanto verticalmente.

procedure TDemoTileImage.FlipXY;
var
  Image: TGdipImage;
  Brush: TGdipTextureBrush;
  BlackPen: TGdipPen;
begin
  Image := TGdipImage.FromFile('..\..\imagens\HouseAndTree.gif');
  Brush := TGdipTextureBrush.Create(Image);
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));

  Brush.WrapMode := TGdipWrapMode.TileFlipXY;
  Graphics.FillRectangle(Brush, TRectangle.Create(300, 300, 200, 200));
  Graphics.DrawRectangle(BlackPen, TRectangle.Create(300, 300, 200, 200));

  BlackPen.Free();
  Brush.Free();
  Image.Free();
end;

/// A ilustra��o no canto inferior direito mostra como o ret�ngulo � preenchido com a imagem em mosaico.
/// Observe que � medida que voc� se move de um ladrilho para o pr�ximo em uma determinada linha, a imagem �
/// virada horizontalmente, e � medida que voc� se move de um ladrilho para o pr�ximo em uma determinada
/// coluna, a imagem � virada verticalmente.
{$ENDREGION}

procedure TDemoTileImage.Run;
begin
  Tile();
  FlipHorizontally();
  FlipVertically();
  FlipXY();
end;

initialization
  RegisterDemo('Usando o pincel para preencher formas\Preenchendo uma Forma com uma imagem em mosaico', TDemoTileImage);

end.
