unit uDemoFontMetrics;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoFontMetrics = class(TDemo)
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoFontMetrics }

class function TDemoFontMetrics.Outputs: TDemoOutputs;
begin
  Result := [doText];
end;

{$REGION}
/// A interface <A>TGdipFontFamily</A> fornece os seguintes m�todos que
/// recupera diversas m�tricas para uma determinada combina��o de fam�lia/estilo:
///
/// -<A>GetEmHeight</A>(FontStyle)
/// -<A>GetCellAscent</A>(FontStyle)
/// -<A>GetCellDescent</A>(FontStyle)
/// -<A>GetLineSpacing</A>(FontStyle)
///
/// Os n�meros retornados por esses m�todos est�o em unidades de design de fonte, portanto s�o
/// independente do tamanho e das unidades de um objeto <A>TGdipFont</A> espec�fico.
///
/// O exemplo a seguir exibe as m�tricas para o estilo regular do
/// Fam�lia de fontes Arial.

procedure TDemoFontMetrics.Run;
var
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
  Ascent, Descent, LineSpacing: Integer;
  AscentPixel, DescentPixel, LineSpacingPixel: Single;
begin
  FontFamily := TGdipFontFamily.Create('Arial');
  Font := TGdipFont.Create(FontFamily, 16, TGdipFontStyle.Regular, TGdipGraphicsUnit.Pixel);

  TextOutput.Add(Format('Font.Size returns %g.', [Font.Size]));
  TextOutput.Add(Format('FontFamily.GetEmHeight retorna %d.',
    [FontFamily.GetEmHeight(TGdipFontStyle.Regular)]));

  Ascent := FontFamily.GetCellAscent(TGdipFontStyle.Regular);
  AscentPixel := Font.Size * Ascent / FontFamily.GetEmHeight(TGdipFontStyle.Regular);
  TextOutput.Add(Format('A ascens�o � de %d unidades de design, %g pixels.',
    [Ascent, AscentPixel]));

  Descent := FontFamily.GetCellDescent(TGdipFontStyle.Regular);
  DescentPixel := Font.Size * Descent / FontFamily.GetEmHeight(TGdipFontStyle.Regular);
  TextOutput.Add(Format('O afundamento � de %d unidades de design, %g pixels.',
    [Descent, DescentPixel]));

  LineSpacing := FontFamily.GetLineSpacing(TGdipFontStyle.Regular);
  LineSpacingPixel := Font.Size * LineSpacing / FontFamily.GetEmHeight(TGdipFontStyle.Regular);
  TextOutput.Add(Format('O espa�amento entre linhas � de %d unidades de design, %g pixels.',
    [LineSpacing, LineSpacingPixel]));


  Font.Free();
  FontFamily.Free();
end;

/// Observe as duas primeiras linhas da sa�da acima. O objeto <A>TGdipFont</A> retorna um
/// tamanho 16, e o objeto <A>TGdipFontFamily</A> retorna uma altura em de 2.048.
/// Esses dois n�meros (16 e 2.048) s�o a chave para a convers�o entre fontes
/// projeta unidades e as unidades (neste caso pixels) do objeto <A>TGdipFont</A>.
{$ENDREGION}

initialization
  RegisterDemo('Usando texto e fontes\Obtendo m�tricas de fonte', TDemoFontMetrics);

end.
