unit uDemoSemitransparentLines;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoSemitransparentLines = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoSemitransparentLines }

{$REGION}
/// No Microsoft Windows GDI+, uma cor � um valor de 32 bits com 8 bits cada para
/// alfa, vermelho, verde e azul. O valor alfa indica a transpar�ncia do
/// a cor � at� que ponto a cor � mesclada com o fundo
/// cor. Os valores alfa variam de 0 a 255, onde 0 representa um valor totalmente
/// cor transparente e 255 representa uma cor totalmente opaca.
///
/// A combina��o alfa � uma combina��o pixel por pixel da cor de origem e de fundo
/// dados. Cada um dos tr�s componentes (vermelho, verde, azul) de uma determinada fonte
/// a cor � mesclada com o componente correspondente da cor de fundo
/// de acordo com a seguinte f�rmula:
///
/// DisplayColor = SourceColor � Alpha / 255 + BackgroundColor � (255 � Alpha) / 255
///
/// Por exemplo, suponha que o componente vermelho da cor de origem seja 150 e o
/// o componente vermelho da cor de fundo � 100. Se o valor alfa for 200, o
/// o componente vermelho da cor resultante � calculado da seguinte forma:
///
/// 150 � 200/255 + 100 � (255 � 200)/255 = 139
///
/// Ao desenhar uma linha, voc� deve passar um objeto <A>TGdipPen</A> para o
/// M�todo <A>DrawLine</A> da classe <A>TGdipGraphics</A>. Um dos
/// os par�metros do construtor <A>TGdipPen</A> s�o um registro <A>TGdipColor</A>. Para
/// desenhe uma linha opaca, defina o componente alfa da cor para 255. Para desenhar uma
/// linha semitransparente, define o componente alfa para qualquer valor de 1 a
/// 254.
///
/// Quando voc� desenha uma linha semitransparente sobre um fundo, a cor do
/// a linha � mesclada com as cores do fundo. O componente alfa
/// especifica como as cores da linha e do fundo s�o misturadas; valores alfa pr�ximos de 0
/// coloque mais peso nas cores de fundo e valores alfa pr�ximos a 255 casas
/// mais peso na cor da linha.
///
/// O exemplo a seguir desenha uma imagem e depois desenha tr�s linhas que usam o
/// imagem como plano de fundo. A primeira linha usa um componente alfa de 255, ent�o
/// � opaco. A segunda e terceira linhas usam um componente alfa de 128, ent�o elas
/// s�o semitransparentes; voc� pode ver a imagem de fundo atrav�s das linhas.
/// Definir a propriedade <A>CompositingQuality</A> faz com que a mesclagem do
/// terceira linha a ser feita em conjunto com a corre��o gama.

procedure TDemoSemitransparentLines.Run;
var
  Image: TGdipImage;
  OpaquePen,
  SemiTransPen: TGdipPen;
begin
  Image := TGdipImage.FromFile('..\..\imagens\Texture1.jpg');
  Graphics.DrawImage(Image, 10, 5, Image.Width, Image.Height);
  OpaquePen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 255), 15);
  SemiTransPen := TGdipPen.Create(TGdipColor.FromArgb(128, 0, 0, 255), 15);
  Graphics.DrawLine(OpaquePen, 0, 20, 100, 20);
  Graphics.DrawLine(SemiTransPen, 0, 40, 100, 40);
  Graphics.CompositingQuality := TGdipCompositingQuality.GammaCorrected;
  Graphics.DrawLine(SemiTransPen, 0, 60, 100, 60);

  SemiTransPen.Free();
  OpaquePen.Free();
  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Linhas e preenchimentos com mesclagem alfa\Desenhando linhas opacas e semitransparentes', TDemoSemitransparentLines);

end.
