unit uDemoSemitransparentBrushes;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoSemitransparentBrushes = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoSemitransparentBrushes }

{$REGION}
/// Ao preencher uma forma, voc� deve passar um objeto <A>TGdipBrush</A> para um dos
/// preenche m�todos da interface <A>TGdipGraphics</A>. O �nico par�metro do
/// O construtor <A>TGdipSolidBrush</A> � um registro <A>TGdipColor</A>.
/// Para preencher uma forma opaca, defina o componente alfa da cor como 255. Para
/// preenche uma forma semitransparente, define o componente alfa para qualquer valor de
/// 1 a 254.
///
/// Quando voc� preenche uma forma semitransparente, a cor da forma � mesclada
/// com as cores do fundo. O componente alfa especifica como o
/// forma e cores de fundo s�o misturadas; valores alfa pr�ximos a 0 colocam mais peso
/// nas cores de fundo, e valores alfa pr�ximos a 255 colocam mais peso no
/// cor da forma.
///
/// O exemplo a seguir desenha uma imagem e depois preenche tr�s elipses que
/// sobrep�e a imagem. A primeira elipse usa um componente alfa de 255, ent�o
/// � opaco. A segunda e terceira elipses usam um componente alfa de 128, ent�o
/// eles s�o semitransparentes; voc� pode ver a imagem de fundo atrav�s do
/// elipses. Definir a propriedade <A>TGdipGraphics.CompositingQuality</A> causa
/// a mesclagem da terceira elipse ser� feita em conjunto com gama
/// corre��o.

procedure TDemoSemitransparentBrushes.Run;
var
  Image: TGdipImage;
  OpaqueBrush,
  SemiTransBrush: TGdipSolidBrush;
begin
  Image := TGdipImage.FromFile('..\..\imagens\Texture1.png');
  Graphics.DrawImage(Image, 50, 50, Image.Width, Image.Height);
  OpaqueBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));
  SemiTransBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(128, 0, 0, 255));
  Graphics.FillEllipse(OpaqueBrush, 35, 45, 45, 30);
  Graphics.FillEllipse(SemiTransBrush, 86, 45, 45, 30);
  Graphics.CompositingQuality := TGdipCompositingQuality.GammaCorrected;
  Graphics.FillEllipse(SemiTransBrush, 40, 90, 86, 30);

  SemiTransBrush.Free();
  OpaqueBrush.Free();
  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Linhas e preenchimentos com mesclagem alfa\Desenhando com pinc�is opacos e semitransparentes', TDemoSemitransparentBrushes);

end.
