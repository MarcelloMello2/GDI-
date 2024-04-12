unit uDemoFormattingText;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoFormattingText = class(TDemo)
  strict private
    procedure AligningText;
    procedure SettingTabStops;
    procedure DrawingVerticalText;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoFormattingText }

{$REGION}
/// Para aplicar formata��o especial ao texto, inicialize um <A>TGdipStringFormat</A>
/// objeto e passamos esse objeto para o m�todo <A>DrawString</A> do
/// Interface <A>TGdipGr�ficos</A>.
///
/// Para desenhar texto formatado em um ret�ngulo, voc� precisa de <A>TGdipGraphics</A>,
/// <A>TGdipFontFamily</A>, <A>TGdipFont</A>, <A>TGdipRectF</A>, <A>TGdipStringFormat</A> e
/// Objetos <A>TGdipBrush</A>.
///
/// <H>Alinhando texto</H>
/// O exemplo a seguir desenha texto em um ret�ngulo. Cada linha de texto �
/// centralizado (lado a lado), e todo o bloco de texto � centralizado (de cima para
/// inferior) no ret�ngulo.

procedure TDemoFormattingText.AligningText;
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Rect: TRectangleF;
  StringFormat: TGdipStringFormat;
  SolidBrush: TGdipBrush;
  Pen: TGdipPen;
begin
  FontFamily := TGdipFontFamily.Create('Arial');
  Font := TGdipFont.Create(FontFamily, 12, TGdipFontStyle.Bold, TGdipGraphicsUnit.Point);
  Rect := TRectangleF.Create(10, 10, 160, 140);
  StringFormat := TGdipStringFormat.Create;
  SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));

  // Centralize cada linha de texto.
  StringFormat.Alignment := TGdipStringAlignment.Center;

  // Centralize o bloco de texto (de cima para baixo) no ret�ngulo.
  StringFormat.LineAlignment := TGdipStringAlignment.Center;

  Graphics.DrawString('Use objetos TGdipStringFormat e TRectangleF para centralizar o texto em um ret�ngulo.',
    Font, SolidBrush, Rect, StringFormat);

  Pen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));
  Graphics.DrawRectangle(Pen, Rect);

  Pen.Free();
  SolidBrush.Free();
  StringFormat.Free();
  Font.Free();
  FontFamily.Free();
end;

/// O c�digo anterior define duas propriedades do objeto <A>TGdipStringFormat</A>:
/// <A>Alignment</A> e <A>LineAlignment</A>. A atribui��o para <A>Alinhamento</A>
/// especifica que cada linha de texto � centralizada no ret�ngulo dado pelo
/// terceiro argumento passado para o m�todo <A>DrawString</A>. A atribui��o a
/// <A>LineAlignment</A> especifica que o bloco de texto est� centralizado (de cima para
/// inferior) no ret�ngulo.
///
/// O valor StringAlignmentCenter � um elemento do <A>TStringAlignment</A>
/// enumera��o.
///
/// <H>Configurando paradas de tabula��o</H>
/// Voc� pode definir paradas de tabula��o para texto chamando o m�todo <A>SetTabStops</A> de um
/// objeto <A>TGdipStringFormat</A> e depois passar esse <A>TGdipStringFormat</A>
/// objeto para o m�todo <A>DrawString</A> da interface <A>TGdipGraphics</A>.
///
/// O exemplo a seguir define paradas de tabula��o em 150, 250 e 350. Em seguida, o c�digo
/// exibe uma lista com guias de nomes e pontua��es de testes.

procedure TDemoFormattingText.SettingTabStops;
const
  Tabs: TArray<Single> = [150, 100, 100];
  Str = 'Name'#9'Test 1'#9'Test 2'#9'Test 3'#13#10+
        'Joe'#9'95'#9'88'#9'91'#13#10+
        'Mary'#9'98'#9'84'#9'90'#13#10+
        'Sam'#9'42'#9'76'#9'98'#13#10+
        'Jane'#9'65'#9'73'#9'92';
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Rect: TRectangleF;
  StringFormat: TGdipStringFormat;
  SolidBrush: TGdipBrush;
  Pen: TGdipPen;
begin
  FontFamily := TGdipFontFamily.Create('Courier New');
  Font := TGdipFont.Create(FontFamily, 12, TGdipFontStyle.Regular, TGdipGraphicsUnit.Point);
  Rect := TRectangleF.Create(190, 10, 500, 100);
  StringFormat := TGdipStringFormat.Create;
  SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));

  StringFormat.SetTabStops(0, Tabs);

  Graphics.DrawString(Str, Font, SolidBrush, Rect, StringFormat);

  Pen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));
  Graphics.DrawRectangle(Pen, Rect);

  Pen.Free();
  SolidBrush.Free();
  StringFormat.Free();
  Font.Free();
  FontFamily.Free();
end;

/// O c�digo anterior passa tr�s argumentos para o m�todo <A>SetTabStops</A>.
/// O segundo argumento � um array contendo os deslocamentos de tabula��o. O primeiro
/// argumento passado para <A>SetTabStops</A> � 0, o que indica que o primeiro
/// o deslocamento no array � medido a partir da posi��o 0, a borda esquerda do
/// ret�ngulo delimitador.
///
/// <H>Desenhando texto vertical</H>
/// Voc� pode usar um objeto <A>TGdipStringFormat</A> para especificar que o texto seja desenhado
/// verticalmente em vez de horizontalmente.
///
/// O exemplo a seguir passa o valor [StringFormatFlagsDirectionVertical]
/// para a propriedade <A>FormatFlags</A> de um objeto <A>TGdipStringFormat</A>. Que
/// O objeto <A>TGdipStringFormat</A> � passado para o m�todo <A>IDrawString<A> do
/// Interface <A>TGdipGr�ficos</A>. O valor StringFormatFlagsDirectionVertical �
/// um elemento da enumera��o <A>TStringFormatFlags</A>.

procedure TDemoFormattingText.DrawingVerticalText;
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Point: TPointF;
  StringFormat: TGdipStringFormat;
  SolidBrush: TGdipBrush;
begin
  FontFamily := TGdipFontFamily.Create('Lucida Console');
  Font := TGdipFont.Create(FontFamily, 14, TGdipFontStyle.Regular, TGdipGraphicsUnit.Point);
  Point := TPointF.Create(190, 120);
  StringFormat := TGdipStringFormat.Create;
  SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));

  StringFormat.FormatFlags := TGdipStringFormatFlags.DirectionVertical;

  Graphics.DrawString('Texto vertical', Font, SolidBrush, Point, StringFormat);

  SolidBrush.Free();
  StringFormat.Free();
  Font.Free();
  FontFamily.Free();
end;
{$ENDREGION}

procedure TDemoFormattingText.Run;
begin
  AligningText;
  SettingTabStops;
  DrawingVerticalText;
end;

initialization
  RegisterDemo('Usando texto e fontes\Formatando texto', TDemoFormattingText);

end.
