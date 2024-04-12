unit uDemoPrivateFontCollection;

interface

uses
   Windows,
   SysUtils,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoPrivateFontCollection = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoPrivateFontCollection }

{$REGION}
/// A interface <A>TGdipPrivateFontCollection</A> herda do
/// <A>IFontCollection</A> interface base abstrata. Voc� pode usar um
/// Objeto <A>TGdipPrivateFontCollection</A> para manter um conjunto de fontes especificamente
/// para sua aplica��o. Uma cole��o de fontes privadas pode incluir sistema instalado
/// fontes, bem como fontes que n�o foram instaladas no computador. Adicionar
/// um arquivo de fonte para uma cole��o de fontes privada, chame o m�todo <A>AddFontFile</A>
/// de um objeto <A>TGdipPrivateFontCollection</A>.
///
/// A propriedade <A>Families</A> de um objeto <A>TGdipPrivateFontCollection</A>
/// retorna um array de objetos <A>TGdipFontFamily</A>.
///
/// O n�mero de fam�lias de fontes em uma cole��o de fontes privada n�o � necessariamente
/// igual ao n�mero de arquivos de fontes que foram adicionados � cole��o.
/// Por exemplo, suponha que voc� adicione os arquivos ArialBd.tff, Times.tff e
/// TimesBd.tff para uma cole��o. Haver� tr�s arquivos, mas apenas duas fam�lias
/// na cole��o porque Times.tff e TimesBd.tff pertencem � mesma
/// fam�lia.
///
/// O exemplo a seguir adiciona os tr�s arquivos de fonte a seguir a um objeto PrivateFontCollection:
///
/// -<WinDir>\Fonts\Arial.tff (Arial, regular)
/// -<WinDir>\Fonts\CourBI.tff (Courier New, negrito it�lico)
/// -<WinDir>\Fonts\TimesBd.tff (Times New Roman, negrito)
///
/// Para cada objeto <A>TGdipFontFamily</A> na cole��o, o c�digo chama o
/// M�todo <A>IsStyleAvailable</A> para determinar se v�rios estilos (regular,
/// negrito, it�lico, negrito it�lico, sublinhado e riscado) est�o dispon�veis. O
/// argumento passado para o m�todo <A>IsStyleAvailable</A> s�o membros do
/// enumera��o <A>TFontStyle</A>.
///
/// Se uma determinada combina��o de fam�lia/estilo estiver dispon�vel, um objeto <A>TGdipFont</A> �
/// constru�do usando essa fam�lia e estilo. O primeiro argumento passado para o
/// O construtor <A>TGdipFont</A> � o nome da fam�lia da fonte (n�o uma <A>TGdipFontFamily</A>
/// objeto como � o caso de outras varia��es do construtor <A>TGdipFont</A>),
/// e o argumento final � o objeto <A>TGdipPrivateFontCollection</A>. Depois
/// o objeto <A>TGdipFont</A> � constru�do, ele � passado para o <A>DrawString</A>
/// m�todo da classe <A>TGdipGraphics</A> para exibir o nome da fam�lia junto com
/// o nome do estilo.

procedure TDemoPrivateFontCollection.Run;
var
  WinDir: array [0..MAX_PATH] of Char;
  FontDir, FamilyName: String;
  Collection: TGdipPrivateFontCollection;
  Family: TGdipFontFamily;
  Font: TGdipFont;
  Point: TGdipPointF;
  Brush: TGdipBrush;
begin
  GetWindowsDirectory(WinDir, MAX_PATH);
  FontDir := IncludeTrailingPathDelimiter(WinDir) + 'Fonts' + PathDelim;
  Collection := TGdipPrivateFontCollection.Create;
  Collection.AddFontFile(FontDir + 'Arial.ttf');
  Collection.AddFontFile(FontDir + 'CourBI.ttf');
  Collection.AddFontFile(FontDir + 'TimesBd.ttf');
  Point.Initialize(10, 0);
  Brush := TGdipSolidBrush.Create(TGdipColor.Black);

  for Family in Collection.Families do
  begin
    FamilyName := Family.FamilyName;

    // O estilo regular est� dispon�vel?
    if (Family.IsStyleAvailable(FontStyleRegular)) then
    begin
      Font := TGdipFont.Create(FamilyName, 16, FontStyleRegular, UnitPixel, Collection);
      Graphics.DrawString(FamilyName + ' Regular', Font, Point, Brush);
      Point.Y := Point.Y + Font.GetHeight(0);
    end;

    // O estilo negrito est� dispon�vel?
    if (Family.IsStyleAvailable([FontStyleBold])) then
    begin
      Font := TGdipFont.Create(FamilyName, 16, [FontStyleBold], UnitPixel, Collection);
      Graphics.DrawString(FamilyName + ' Bold', Font, Point, Brush);
      Point.Y := Point.Y + Font.GetHeight(0);
    end;

    // O estilo it�lico est� dispon�vel?
    if (Family.IsStyleAvailable([FontStyleItalic])) then
    begin
      Font := TGdipFont.Create(FamilyName, 16, [FontStyleItalic], UnitPixel, Collection);
      Graphics.DrawString(FamilyName + ' Italic', Font, Point, Brush);
      Point.Y := Point.Y + Font.GetHeight(0);
    end;

    // O estilo negrito e it�lico est� dispon�vel?
    if (Family.IsStyleAvailable([FontStyleBold, FontStyleItalic])) then
    begin
      Font := TGdipFont.Create(FamilyName, 16, [FontStyleBold, FontStyleItalic], UnitPixel, Collection);
      Graphics.DrawString(FamilyName + ' Bold Italic', Font, Point, Brush);
      Point.Y := Point.Y + Font.GetHeight(0);
    end;

    // O estilo de sublinhado est� dispon�vel?
    if (Family.IsStyleAvailable([FontStyleUnderline])) then
    begin
      Font := TGdipFont.Create(FamilyName, 16, [FontStyleUnderline], UnitPixel, Collection);
      Graphics.DrawString(FamilyName + ' Underline', Font, Point, Brush);
      Point.Y := Point.Y + Font.GetHeight(0);
    end;

    // O estilo riscado est� dispon�vel?
    if (Family.IsStyleAvailable([FontStyleStrikeout])) then
    begin
      Font := TGdipFont.Create(FamilyName, 16, [FontStyleStrikeout], UnitPixel, Collection);
      Graphics.DrawString(FamilyName + ' Strkeout', Font, Point, Brush);
      Point.Y := Point.Y + Font.GetHeight(0);
    end;

    // Separe as fam�lias com espa�os em branco.
    Point.Y := Point.Y + 10;
  end;
end;

/// Arial.tff (que foi adicionado � cole��o de fontes privadas no anterior
/// exemplo de c�digo) � o arquivo de fonte para o estilo regular Arial. Observe, no entanto,
/// que a sa�da do programa mostra v�rios estilos dispon�veis al�m do normal
/// para a fam�lia de fontes Arial. Isso ocorre porque o Microsoft Windows GDI+ pode
/// simula os estilos negrito, it�lico e negrito it�lico do estilo regular.
/// GDI+ tamb�m pode produzir sublinhados e riscados do estilo regular.
///
/// Da mesma forma, GDI+ pode simular o estilo negrito it�lico a partir do negrito
/// estilo ou o estilo it�lico. A sa�da do programa mostra que o negrito it�lico
/// o estilo est� dispon�vel para a fam�lia Times, embora TimesBd.tff (Times New
/// Roman, negrito) � o �nico arquivo Times na cole��o.
{$ENDREGION}

initialization
  RegisterDemo('Usando texto e fontes\Criando uma cole��o de fontes privada', TDemoPrivateFontCollection);

end.
