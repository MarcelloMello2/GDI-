unit uDemoCompositingMode;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoCompositingMode = class(TDemo)
  strict private
    procedure DrawShapes(const CompositingMode: TGdipCompositingMode;
      const YOffset: Integer);
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoCompositingMode }

{$REGION}
/// Pode haver momentos em que voc� queira criar um bitmap fora da tela que tenha
/// as seguintes caracter�sticas:
///
/// -As cores t�m valores alfa menores que 255.
/// -As cores n�o s�o combinadas alfa entre si conforme voc� cria o bitmap.
/// -Quando voc� exibe o bitmap finalizado, as cores no bitmap s�o alfa
/// combinado com as cores de fundo no dispositivo de exibi��o.
///
/// Para criar tal bitmap, construa um objeto <A>TGdipBitmap</A> em branco e ent�o
/// constr�i um objeto <A>TGdipGraphics</A> baseado nesse bitmap. Colocou o
/// modo de composi��o do objeto <A>TGdipGraphics</A> para CompositingModeSourceCopy.
///
/// O exemplo a seguir cria um objeto <A>TGdipGraphics</A> baseado em um
/// Objeto <A>TGdipBitmap</A>. O c�digo usa o objeto <A>TGdipGraphics</A> junto com
/// dois pinc�is semitransparentes (alpha = 160) para pintar no bitmap. O c�digo
/// preenche uma elipse vermelha e uma elipse verde usando os pinc�is semitransparentes.
/// A elipse verde se sobrep�e � elipse vermelha, mas o verde n�o � mesclado
/// com vermelho porque o modo de composi��o do objeto <A>TGdipGraphics</A> �
/// definido como CompositingModeSourceCopy.
///
/// O c�digo desenha o bitmap na tela duas vezes: uma vez em um fundo branco
/// e uma vez em um fundo multicolorido. Os pixels no bitmap que s�o
/// parte das duas elipses tem um componente alfa de 160, ent�o as elipses s�o
/// mesclado com as cores de fundo da tela.

procedure TDemoCompositingMode.DrawShapes(
  const CompositingMode: TGdipCompositingMode; const YOffset: Integer);
var
  Bitmap: TGdipBitmap;
  BitmapGraphics: TGdipGraphics;
  RedBrush,
  GreenBrush,
  Brush: TGdipSolidBrush;
begin
  // Crie um bitmap em branco.
  Bitmap := TGdipBitmap.Create(180, 100);
  // Crie um objeto TGdipGraphics que possa ser usado para desenhar no bitmap.
  BitmapGraphics := TGdipGraphics.FromImage(Bitmap);
  // Crie um pincel vermelho e um pincel verde, cada um com um valor alfa de 160.
  RedBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(160, 255, 0, 0));
  GreenBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(160, 0, 255, 0));
  // Defina o modo de composi��o usando o par�metro. Quando CompositingMode est� definido
  // para CompositingModeSourceCopy, quando elipses sobrepostas forem desenhadas,
  // as cores das elipses n�o s�o mescladas.
  BitmapGraphics.CompositingMode := CompositingMode;
  BitmapGraphics.FillEllipse(RedBrush, 0, 0, 150, 70);
  BitmapGraphics.FillEllipse(GreenBrush, 30, 30, 150, 70);

  // Desenhe um fundo multicolorido na tela.
  Graphics.CompositingQuality := TGdipCompositingQuality.GammaCorrected;
  Brush := TGdipSolidBrush.Create(TGdipColor.Aqua);
  Graphics.FillRectangle(Brush, 200, YOffset, 60, 100);
  Brush.Color := TGdipColor.Yellow;
  Graphics.FillRectangle(Brush, 260, YOffset, 60, 100);
  Brush.Color := TGdipColor.Fuchsia;
  Graphics.FillRectangle(Brush, 320, YOffset, 60, 100);

  // Exiba o bitmap em um fundo branco.
  Graphics.DrawImage(Bitmap, 0, YOffset);
  // Exiba o bitmap em um fundo multicolorido.
  Graphics.DrawImage(Bitmap, 200, YOffset);

  Brush.Free();
  GreenBrush.Free();
  RedBrush.Free();
  BitmapGraphics.Free();
  Bitmap.Free();
end;

/// O c�digo a seguir chama a rotina acima 2 vezes com composi��es diferentes
/// modos. Definir o modo de composi��o como CompositingModeSourceOver faz com que o
/// elipses a serem mescladas entre si e tamb�m com o fundo.

procedure TDemoCompositingMode.Run;
begin
  DrawShapes(TGdipCompositingMode.SourceCopy, 0);
  DrawShapes(TGdipCompositingMode.SourceOver, 110);
end;
{$ENDREGION}

initialization
  RegisterDemo('Linhas e preenchimentos com mesclagem alfa\Usando o modo de composi��o para controlar a mistura alfa', TDemoCompositingMode);

end.
