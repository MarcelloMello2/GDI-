unit uDemoConstructingFonts;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoConstructingFonts = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoConstructingFonts }

{$REGION}
/// O Microsoft Windows GDI+ fornece diversas classes que formam a base para
/// desenhando texto. A interface <A>TGdipGraphics</A> possui v�rios <A>DrawString</A>
/// m�todos que permitem especificar v�rios recursos de texto, como
/// localiza��o, ret�ngulo delimitador, fonte e formato. Outras interfaces que
/// contribuem para a renderiza��o de texto incluem <A>TGdipFontFamily</A>, <A>TGdipFont</A>,
/// <A>TGdipStringFormat</A>, <A>TGdipInstalledFontCollection</A> e
/// <A>TGdipPrivateFontCollection</A>.
///
/// Microsoft Windows GDI+ agrupa fontes com o mesmo tipo de letra, mas diferentes
/// estilos em fam�lias de fontes. Por exemplo, a fam�lia de fontes Arial cont�m o
/// seguintes fontes:
///
/// -Arial Regular
/// -Arial Negrito
/// -Arial It�lico
/// -Arial Negrito It�lico
///
/// GDI+ usa quatro estilos para formar fam�lias: regular, negrito, it�lico e negrito
/// it�lico. Adjetivos como estreito e arredondado n�o s�o considerados estilos;
/// em vez disso, eles fazem parte do nome da fam�lia. Por exemplo, Arial Narrow � uma fonte
/// fam�lia cujos membros s�o os seguintes:
///
/// -Arial Estreito Regular
/// -Arial Narrow Bold
/// -Arial Narrow It�lico
/// -Arial Narrow Negrito It�lico
///
/// Antes de poder desenhar texto com GDI+, voc� precisa construir uma <A>TGdipFontFamily</A>
/// objeto e um objeto <A>TGdipFont</A>. Os objetos <A>TGdipFontFamily</A> especificam
/// o tipo de letra (por exemplo, Arial) e o objeto <A>TGdipFont</A> especifica o
/// tamanho, estilo e unidades.
///
/// O exemplo a seguir constr�i uma fonte Arial de estilo regular com um tamanho de
/// 16 pixels:

procedure TDemoConstructingFonts.Run;
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Brush: TGdipBrush;
begin
  FontFamily := TGdipFontFamily.Create('Arial');
  Font := TGdipFont.Create(FontFamily, 16, TGdipFontStyle.Regular, TGdipGraphicsUnit.Pixel);
  Brush := TGdipSolidBrush.Create(TGdipColor.Black);
  Graphics.DrawString('A r�pida raposa marrom salta sobre o cachorro pregui�oso', Font, Brush, TPointF.Create(0, 0));

  Brush.Free();
  Font.Free();
  FontFamily.Free();
end;

/// No c�digo anterior, o primeiro argumento passado para o <A>TGdipFont</A>
/// construtor � o objeto <A>TGdipFontFamily</A>. O segundo argumento especifica
/// o tamanho da fonte medido em unidades identificadas pelo quarto argumento.
/// O terceiro argumento identifica o estilo.
///
/// UnitPixel � membro da enumera��o <A>TUnit</A> e FontStyleRegular
/// um conjunto vazio do tipo <A>TFontStyle</A> enumera��o.
{$ENDREGION}

initialization
  RegisterDemo('Usando texto e fontes\Construindo fam�lias de fontes e fontes', TDemoConstructingFonts);

end.
