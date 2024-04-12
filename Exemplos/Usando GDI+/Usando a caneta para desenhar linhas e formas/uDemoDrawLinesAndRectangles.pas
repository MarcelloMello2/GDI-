unit uDemoDrawLinesAndRectangles;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoDrawLineAndRectangles = class(TDemo)
  strict private
    procedure DrawLine;
    procedure DrawRectangle;
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// A interface <A>TGdipGraphics</A> fornece uma variedade de m�todos de desenho
/// incluindo os mostrados na lista a seguir:
///
///  -<A>TGdipGraphics.DrawLine</A>
///  -<A>TGdipGraphics.DrawRectangle</A>
///  -<A>TGdipGraphics.DrawEllipse</A>
///  -<A>TGdipGraphics.DrawArc</A>
///  -<A>TGdipGraphics.DrawPath</A>
///  -<A>TGdipGraphics.DrawCurve</A>
///  -<A>TGdipGraphics.DrawBezier</A>
///
/// Um dos argumentos que voc� passa para tal m�todo de desenho � um
/// <A>Objeto TGdipPen</A>.
///
/// Para desenhar linhas e ret�ngulos, voc� precisa de um objeto <A>TGdipGraphics</A> e um
/// <A>Objeto TGdipPen</A>. O objeto <A>TGdipGraphics</A> fornece o <A>DrawLine</A>
/// e o objeto <A>TGdipPen</A> armazena recursos da linha, como
/// cor e largura.
///
/// O exemplo a seguir desenha uma linha de (20, 10) a (300, 100).

procedure TDemoDrawLineAndRectangles.DrawLine;
var
  Pen: TGdipPen;
begin
  Pen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0));
  Graphics.DrawLine(Pen, 20, 10, 300, 100);
  Pen.Free();
end;

/// A primeira instru��o de c�digo usa o construtor <A>de classe TGdipPen</A> para criar
/// uma caneta preta. O �nico argumento passado para o construtor <A>TGdipPen</A> � um
/// <A>Registro TGdipColor</A>. Os valores usados para construir o objeto <A>TGdipColor</A>
/// � (255, 0, 0, 0) � correspondem aos componentes alfa, vermelho, verde e azul
/// da cor. Esses valores definem uma caneta preta opaca.
///
/// O exemplo a seguir desenha um ret�ngulo com seu canto superior esquerdo em
///  (10, 10). O ret�ngulo tem uma largura de 100 e uma altura de 50. O segundo
/// argumento passado para o construtor <A>TGdipPen</A> indica que a largura da caneta
/// � de 5 pixels.

procedure TDemoDrawLineAndRectangles.DrawRectangle;
var
  BlackPen: TGdipPen;
begin
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0), 5);
  Graphics.DrawRectangle(BlackPen, 10, 10, 100, 50);
  BlackPen.Free();
end;

/// Quando o ret�ngulo � desenhado, a caneta � centralizada no ret�ngulo
/// fronteira. Como a largura da caneta � 5, os lados do ret�ngulo s�o desenhados
/// 5 pixels de largura, de modo que 1 pixel � desenhado no pr�prio limite, 2 pixels
/// s�o desenhados por dentro, e 2 pixels s�o desenhados por fora. Para mais informa��es
/// detalhes sobre o alinhamento da caneta, veja a pr�xima demonstra��o <I>Definindo a largura da caneta e
/// Alinhamento</I>.
{$ENDREGION}

procedure TDemoDrawLineAndRectangles.Run;
begin
  DrawLine;
  DrawRectangle;
end;

initialization
  RegisterDemo('Usando a caneta para desenhar linhas e formas\Usando a caneta para desenhar linhas e ret�ngulos', TDemoDrawLineAndRectangles);

end.
