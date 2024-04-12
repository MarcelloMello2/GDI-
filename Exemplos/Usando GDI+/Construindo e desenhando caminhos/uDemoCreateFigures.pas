unit uDemoCreateFigures;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoCreateFigures = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
    procedure Example3;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoCreateFigures }

{$REGION}
/// Um caminho � uma sequ�ncia de primitivas gr�ficas (linhas, ret�ngulos, curvas,
/// texto e similares) que podem ser manipulados e desenhados como uma �nica unidade. A
/// o caminho pode ser dividido em figuras abertas ou fechadas. Uma figura
/// pode conter v�rios primitivos.
///
/// Voc� pode desenhar um caminho chamando o m�todo <A>DrawPath</A> do
/// Interface <A>TGdipGraphics</A>, e voc� pode preencher um caminho chamando o
/// M�todo <A>FillPath</A> da interface <A>TGdipGraphics</A>.
///
/// Para criar um caminho, construa um objeto <A>TGdipGraphicsPath</A> e depois chame
/// m�todos, como <A>AddLine</A> e <A>AddCurve</A>, para adicionar primitivas a
/// o caminho.
///
/// O exemplo a seguir cria um caminho que possui um �nico arco. O arco tem
/// �ngulo de varredura de �180 graus, que � no sentido anti-hor�rio no padr�o
/// sistema de coordenadas (veja a ilustra��o acima com a caneta vermelha).

procedure TDemoCreateFigures.Example1;
var
  Pen: TGdipPen;
  Path: TGdipGraphicsPath;
begin
  Pen := TGdipPen.Create(TGdipColor.Red);
  Path := TGdipGraphicsPath.Create;
  Path.AddArc(10, 10, 50, 50, 0, -180);
  Graphics.DrawPath(Pen, Path);

  Path.Free();
  Pen.Free();
end;

/// O exemplo a seguir cria um caminho que possui duas figuras. A primeira figura
/// � um arco seguido por uma linha. A segunda figura � uma linha seguida por um
/// curva, seguida por uma linha. A primeira figura fica aberta e a segunda
/// a figura � fechada (veja a ilustra��o acima com a caneta azul).

procedure TDemoCreateFigures.Example2;
var
   Points: TArray<TPoint>;
   Pen: TGdipPen;
   Path: TGdipGraphicsPath;
begin
   Points :=
   [
      TPoint.Create(110, 80),
      TPoint.Create(120, 90),
      TPoint.Create(100, 110)
   ];

  Pen := TGdipPen.Create(TGdipColor.Blue, 2);
  Path := TGdipGraphicsPath.Create();

  // A primeira figura � iniciada automaticamente, ent�o h�
  // n�o h� necessidade de chamar StartFigure aqui.
  Path.AddArc(175, 50, 50, 50, 0, -180);
  Path.AddLine(100, 0, 250,20);

  Path.StartFigure;
  Path.AddLine(120, 40, 75, 110);
  Path.AddCurve(Points);
  Path.AddLine(120, 120, 220, 200);
  Path.CloseFigure;

  Graphics.DrawPath(Pen, Path);

  Path.Free();
  Pen.Free();
end;

/// Al�m de adicionar linhas e curvas aos caminhos, voc� pode adicionar formas fechadas:
/// ret�ngulos, elipses, pizzas e pol�gonos. O exemplo a seguir cria um
/// caminho que possui duas linhas, um ret�ngulo e uma elipse. O c�digo usa uma caneta para
/// desenha o caminho e um pincel para preencher o caminho (veja a ilustra��o acima com
/// a caneta verde).

procedure TDemoCreateFigures.Example3;
var
  Pen: TGdipPen;
  Brush: TGdipBrush;
  Path: TGdipGraphicsPath;
begin
  Pen := TGdipPen.Create(TGdipColor.Green, 4);
  Brush := TGdipSolidBrush.Create(TGdipColor.FromArgb(200, 200, 200));
  Path := TGdipGraphicsPath.Create;

  Path.AddLine(260, 10, 350, 40);
  Path.AddLine(350, 60, 280, 60);
  Path.AddRectangle(TRectangle.Create(300, 35, 20, 40));
  Path.AddEllipse(260, 75, 40, 30);

  Graphics.DrawPath(Pen, Path);
  Graphics.FillPath(Brush, Path);

  Path.Free();
  Brush.Free();
  Pen.Free();
end;

/// O caminho no exemplo anterior possui tr�s d�gitos. A primeira figura
/// consiste nas duas linhas, a segunda figura consiste no ret�ngulo e
/// a terceira figura consiste na elipse. Mesmo quando n�o h� chamadas para
/// <A>CloseFigure</A> ou <A>StartFigure</A>, formas intrinsecamente fechadas, como
/// como ret�ngulos e elipses, s�o consideradas figuras separadas.
{$ENDREGION}

procedure TDemoCreateFigures.Run;
begin
  Example1;
  Example2;
  Example3;
end;

initialization
  RegisterDemo('Construindo e desenhando caminhos\Criando figuras a partir de linhas, curvas e formas', TDemoCreateFigures);

end.
