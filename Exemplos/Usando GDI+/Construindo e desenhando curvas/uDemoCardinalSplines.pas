unit uDemoCardinalSplines;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoCardinalSplines = class(TDemo)
  strict private
    procedure DrawBellShape;
    procedure DrawClosedCurve;
    procedure DrawWithTension;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoCardinalSplines }

{$REGION}
/// GDI+ suporta v�rios tipos de curvas: elipses, arcos, splines cardinais e
/// Splines de B�zier. Uma elipse � definida pelo seu ret�ngulo delimitador; um arco � um
/// parte de uma elipse definida por um �ngulo inicial e um �ngulo de varredura. A
/// cardinal spline � definido por uma matriz de pontos e um par�metro de tens�o �
/// a curva passa suavemente por cada ponto da matriz e a tens�o
/// par�metro influencia a forma como a curva se curva. Uma spline de B�zier � definida por
/// dois pontos finais e dois pontos de controle � a curva n�o passa pelo
/// pontos de controle, mas os pontos de controle influenciam a dire��o e a curvatura conforme
/// a curva vai de um ponto final ao outro.
///
/// Um spline cardinal � uma curva que passa suavemente por um determinado conjunto de
/// pontos. Para desenhar um spline cardinal, crie um objeto <A>TGdipGraphics</A> e passe
/// um array de pontos para o m�todo <A>DrawCurve</A>. O exemplo a seguir
/// desenha um spline cardinal em forma de sino que passa por cinco pontos designados
/// pontos:

procedure TDemoCardinalSplines.DrawBellShape;
var
  Points: TArray<TPoint>;
  Pen: TGdipPen;
  Brush: TGdipSolidBrush;
  P: TPoint;
begin
  Points :=
  [
    TPoint.Create(10, 100),
    TPoint.Create(60, 80),
    TPoint.Create(110, 20),
    TPoint.Create(160, 80),
    TPoint.Create(220, 100)
  ];
  Pen := TGdipPen.Create(TGdipColor.Blue);
  Graphics.DrawCurve(Pen, Points);

  Brush := TGdipSolidBrush.Create(TGdipColor.Red);
  for P in Points do
    Graphics.FillRectangle(Brush, P.X - 2, P.Y - 2, 5, 5);

  Brush.Free();
  Pen.Free();
end;

/// Voc� pode usar o m�todo <A>DrawClosedCurve</A> do <A>TGdipGraphics</A>
/// interface para desenhar um spline cardinal fechado. Em um spline cardinal fechado, o
/// a curva continua at� o �ltimo ponto do array e se conecta com o
/// primeiro ponto do array.
///
/// O exemplo a seguir desenha um spline cardinal fechado que passa por seis
/// pontos designados.

procedure TDemoCardinalSplines.DrawClosedCurve;
var
  Points: TArray<TPoint>;
  Pen: TGdipPen;
  Brush: TGdipSolidBrush;
  P: TPoint;
begin
  Points :=
  [
    TPoint.Create(310, 60),
    TPoint.Create(400, 80),
    TPoint.Create(450, 40),
    TPoint.Create(430, 120),
    TPoint.Create(370, 100),
    TPoint.Create(330, 160)
  ];

  Pen := TGdipPen.Create(TGdipColor.Blue);
  Graphics.DrawClosedCurve(Pen, Points);

  Brush := TGdipSolidBrush.Create(TGdipColor.Red);
  for P in Points do
    Graphics.FillRectangle(Brush, P.X - 2, P.Y - 2, 5, 5);

  Brush.Free();
  Pen.Free();
end;

/// Voc� pode alterar a forma como um spline cardinal se curva passando um argumento de tens�o
/// para o m�todo <A>DrawCurve</A>. O exemplo a seguir desenha tr�s cardeais
/// splines que passam pelo mesmo conjunto de pontos, com tens�es diferentes
/// valores. Observe que quando a tens�o � 0, os pontos est�o conectados por
/// linhas retas.

procedure TDemoCardinalSplines.DrawWithTension;
var
  Points: TArray<TPoint>;
  Pen: TGdipPen;
  Brush: TGdipSolidBrush;
  P: TPoint;
begin
  Points :=
  [
    TPoint.Create(20, 170),
    TPoint.Create(100, 130),
    TPoint.Create(200, 220),
    TPoint.Create(300, 170),
    TPoint.Create(400, 200)
  ];

  Pen := TGdipPen.Create(TGdipColor.Blue);
  Graphics.DrawCurve(Pen, Points, 0.0);
  Pen.Color := TGdipColor.Green;
  Graphics.DrawCurve(Pen, Points, 0.6);
  Pen.Color := TGdipColor.Gray;
  Graphics.DrawCurve(Pen, Points, 1.0);

  Brush := TGdipSolidBrush.Create(TGdipColor.Red);
  for P in Points do
    Graphics.FillRectangle(Brush, P.X - 2, P.Y - 2, 5, 5);

  Brush.Free();
  Pen.Free();
end;
{$ENDREGION}

procedure TDemoCardinalSplines.Run;
begin
  DrawBellShape;
  DrawClosedCurve;
  DrawWithTension;
end;

initialization
  RegisterDemo('Construindo e desenhando curvas\Desenhando splines cardinais', TDemoCardinalSplines);

end.
