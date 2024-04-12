unit uDemoDrawingText;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoDrawingText = class(TDemo)
  strict private
    procedure DrawAtLocation;
    procedure DrawInRectangle;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoDrawingText }

{$REGION}
/// Voc� pode usar o m�todo <A>DrawString</A> da classe <A>TGdipGraphics</A> para
/// desenha texto em um local especificado ou dentro de um ret�ngulo especificado.
///
/// <H>Desenhando texto em um local espec�fico</H>
/// Para desenhar texto em um local espec�fico, voc� precisa de <A>TGdipGraphics</A>,
/// Objetos <A>TGdipFontFamily</A>, <A>TGdipFont</A>, <A>TGdipPointF</A> e <A>TGdipBrush</A>.
///
/// O exemplo a seguir desenha a string "Hello" no local (30, 10). O
/// a fam�lia da fonte � Times New Roman. A fonte, que � um membro individual do
/// a fam�lia da fonte � Times New Roman, tamanho 24 pixels, estilo regular.

procedure TDemoDrawingText.DrawAtLocation;
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Point: TPointF;
  SolidBrush: TGdipBrush;
begin
  FontFamily := TGdipFontFamily.Create('Times New Roman');
  Font := TGdipFont.Create(FontFamily, 24, TGdipFontStyle.Regular, TGdipGraphicsUnit.Pixel);
  Point := TPointF.Create(30, 10);
  SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));
  Graphics.DrawString('Ol�', Font, SolidBrush, Point);

  SolidBrush.Free();
  Font.Free();
  FontFamily.Free();
end;

/// No exemplo anterior, o construtor <A>TGdipFontFamily</A> recebe um
/// string que identifica a fam�lia da fonte. O objeto <A>TGdipFontFamily</A> �
/// passado como primeiro argumento para o construtor <A>TGdipFont</A>. O segundo
/// argumento passado para o construtor <A>TGdipFont</A> especifica o tamanho do
/// fonte medida em unidades dadas pelo quarto argumento. O terceiro argumento
/// especifica o estilo (regular, negrito, it�lico e assim por diante) da fonte.
///
/// O m�todo <A>DrawString</A> recebe quatro argumentos. O primeiro argumento �
/// a string a ser desenhada. O segundo argumento � o objeto <A>TGdipFont</A> que
/// foi constru�do anteriormente. O terceiro argumento � um registro <A>TGdipPointF</A>
/// que cont�m as coordenadas do canto superior esquerdo da string. O
/// o quarto argumento � um objeto <A>TGdipBrush</A> que ser� usado para preencher o
/// caracteres da string.
///
/// <H>Desenhando texto em um ret�ngulo</H>
/// Um dos m�todos <A>DrawString</A> da interface <A>TGdipGraphics</A> tem um
/// Par�metro <A>TGdipRectF</A>. Chamando esse m�todo <A>DrawString</A>, voc� pode
/// desenha texto que envolve um ret�ngulo especificado. Para desenhar texto em um ret�ngulo,
/// voc� precisa de <A>TGdipGraphics</A>, <A>TGdipFontFamily</A>, <A>TGdipFont</A>, <A>TGdipRectF</A>
/// e objetos <A>TGdipBrush</A>.
///
/// O exemplo a seguir cria um ret�ngulo com canto superior esquerdo (30, 50),
/// largura 100 e altura 122. Ent�o o c�digo desenha uma string dentro dessa
/// ret�ngulo. A corda � restrita ao ret�ngulo e enrolada de tal forma
/// que palavras individuais n�o sejam quebradas.

procedure TDemoDrawingText.DrawInRectangle;
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Rect: TRectangleF;
  SolidBrush: TGdipBrush;
  Pen: TGdipPen;
begin
  FontFamily := TGdipFontFamily.Create('Arial');
  Font := TGdipFont.Create(FontFamily, 12, TGdipFontStyle.Bold, TGdipGraphicsUnit.Point);
  Rect := TRectangleF.Create(30, 50, 120, 122);
  SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));
  Graphics.DrawString('Desenhe o texto em um ret�ngulo passando um TRectangleF para o m�todo DrawString', Font, SolidBrush, Rect);

  Pen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));
  Graphics.DrawRectangle(Pen, Rect);

  Pen.Free();
  SolidBrush.Free();
  Font.Free();
  FontFamily.Free();
end;

/// No exemplo anterior, o terceiro argumento passado para <A>DrawString</A>
/// m�todo � um registro <A>TGdipRectF</A> que especifica o ret�ngulo delimitador para
/// o texto. O quarto par�metro � do tipo <A>TGdipStringFormat</A> � o
/// o argumento � nulo porque nenhuma formata��o especial de string � necess�ria.
{$ENDREGION}

procedure TDemoDrawingText.Run;
begin
  DrawAtLocation;
  DrawInRectangle;
end;

initialization
  RegisterDemo('Usando texto e fontes\Desenhando texto', TDemoDrawingText);

end.
