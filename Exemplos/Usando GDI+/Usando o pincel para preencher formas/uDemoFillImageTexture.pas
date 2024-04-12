unit uDemoFillImageTexture;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoFillImageTexture = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Voc� pode preencher uma forma fechada com uma textura usando a interface <A>TGdipImage</A>
/// e a interface <A>TGdipTextureBrush</A>.
///
/// O exemplo a seguir preenche uma elipse com uma imagem. O c�digo constr�i um
/// objeto <A>TGdipImage</A>, e ent�o passa esse objeto <A>TGdipImage</A> como um
/// argumento para um construtor <A>TGdipTextureBrush</A>. A terceira declara��o de c�digo
/// escala a imagem, e a quarta declara��o preenche a elipse com
/// c�pias repetidas da imagem escalada:

procedure TDemoFillImageTexture.Run;
var
  Image: TGdipImage;
  Brush: TGdipTextureBrush;
  Matrix: TGdipMatrix;
begin
  Image := TGdipImage.FromFile('..\..\imagens\ImageFile.jpg');
  Matrix := TGdipMatrix.Create(75 / 640, 0, 0, 75/480, 0, 0);
  Brush := TGdipTextureBrush.Create(Image);

  Brush.Transform := Matrix;
  Graphics.FillEllipse(Brush, TRectangle.Create(0, 50, 150, 250));

  Brush.Free();
  Matrix.Free();
  Image.Free();
end;

/// No exemplo de c�digo anterior, a propriedade <A>Transform</A> define a
/// transforma��o que � aplicada � imagem antes de ela ser desenhada. Suponha que
/// a imagem original tenha uma largura de 640 pixels e uma altura de 480 pixels. A
/// transforma��o reduz a imagem para 75�75, ajustando os valores de escala horizontal e
/// vertical.
///
/// <B>Nota</B> No exemplo anterior, o tamanho da imagem � de 75�75, e o
/// tamanho da elipse � de 150�250. Como a imagem � menor do que a elipse que
/// est� preenchendo, a elipse � preenchida com a imagem em mosaico. Preencher em mosaico significa que a imagem
/// � repetida horizontal e verticalmente at� que o limite da forma seja
/// alcan�ado. Para mais informa��es sobre preenchimento em mosaico, veja a pr�xima demonstra��o
/// <I>Preenchendo uma Forma com uma Imagem em Mosaico</I>.
{$ENDREGION}

initialization
  RegisterDemo('Usando o pincel para preencher formas\Preenchendo uma forma com uma textura de imagem', TDemoFillImageTexture);

end.
