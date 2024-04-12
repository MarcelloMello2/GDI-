// Marcelo Melo
// 12/04/2024
//
// https://learn.microsoft.com/en-us/windows/win32/gdiplus/-gdiplus-drawing-a-string-use

unit uDemoDrawString;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoDrawString = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
procedure TDemoDrawString.Run;
var
  Brush: TGdipSolidBrush;
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  PointF:  TPointF;
begin

  Brush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));
  FontFamily := TGdipFontFamily.Create('Times New Roman');
  Font := TGdipFont.Create(FontFamily, 24, TGdipFontStyle.Regular, TGdipGraphicsUnit.Pixel);
  PointF := TPointF.Create(10, 20);
  Graphics.DrawString('Ol�, mundo.', Font, Brush, PointF);

  Font.Free();
  FontFamily.Free();
  Brush.Free();
end;

/// O c�digo anterior cria v�rios objetos GDI+. O objeto <A>TGdipGraphics</A>
/// fornece o <A>TGdipGraphics.DrawString</A> m�todo, que faz o real
/// desenho. O objeto <A>TGdipSolidBrush</A> especifica a cor da cadeia de caracteres.
///
/// O construtor <A>TGdipFontFamily</A> recebe um �nico argumento de cadeia de caracteres que
/// identifica a fam�lia de fontes. O objeto <A>TGdipFontFamily</A> � o primeiro
/// argumento passado para o construtor <A> TGdipFont</A>. O segundo argumento passou
/// para o construtor <A> TGdipFont</A> especifica o tamanho da fonte e o terceiro
/// especifica o estilo. O valor <B>TGdipFontStyle.Regular</B> � um membro
/// da enumera��o <A>TGdipFontStyle</A>. O �ltimo argumento para o <A>TGdipFont</A>
/// O construtor indica que o tamanho da fonte (24 neste caso) �
/// medido em pixels. O valor <B>TGdipGraphicsUnit.Pixel</B> � um membro do
/// <A>Enumera��o TGdipGraphicsUnit</A>.
///
/// O primeiro argumento passado para o m�todo <A>TGdipGraphics.DrawString</A> � uma
/// WideString (Unicode). O segundo argumento � o objeto <A>TGdipFont</A>. O
/// terceiro argumento � uma refer�ncia a um registro <A>TPointF</A> que especifica o
/// local onde a string ser� desenhada. O �ltimo argumento � o
/// <A>Objeto TGdipBrush</A>, que especifica a cor da cadeia de caracteres.

{$ENDREGION}

initialization
  RegisterDemo('Introdu��o\Desenhando uma String', TDemoDrawString);

end.
