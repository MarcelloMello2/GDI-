unit uDemoTransformationOrder;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoTransformationOrder = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
    procedure Example3;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoTransformationOrder }

{$REGION}
/// Um �nico objeto <A>TGdipMatrix</A> pode armazenar uma �nica transforma��o ou um
/// sequ�ncia de transforma��es. Este �ltimo � chamado de composto
/// transforma��o. A matriz de uma transforma��o composta � obtida por
/// multiplicando as matrizes das transforma��es individuais.
///
/// Em uma transforma��o composta, a ordem das transforma��es individuais
/// � importante. Por exemplo, se voc� primeiro girar, depois dimensionar e depois transladar,
/// voc� obt�m um resultado diferente do que se primeiro transladasse, depois girasse e depois
/// escala. No Microsoft Windows GDI+, as transforma��es compostas s�o criadas a partir de
/// da esquerda para direita. Se S, R e T s�o matrizes de escala, rota��o e transla��o
/// respectivamente, ent�o o produto SRT (nessa ordem) � a matriz do
/// transforma��o composta que primeiro dimensiona, depois gira e depois converte.
/// A matriz produzida pelo produto SRT � diferente da matriz produzida
/// pelo produto TRS.
///
/// Uma raz�o pela qual a ordem � significativa � que transforma��es como rota��o e
/// o escalonamento � feito em rela��o � origem do sistema de coordenadas.
/// Dimensionar um objeto centrado na origem produz um resultado diferente
/// do que dimensionar um objeto que foi afastado da origem. De forma similar,
/// girar um objeto que est� centrado na origem produz um resultado diferente
/// resultado da rota��o de um objeto que foi afastado da origem.
///
/// O exemplo a seguir combina escala, rota��o e transla��o (nesse caso
/// ordem) para formar uma transforma��o composta. O argumento
/// <A>MatrixOrderAppend</A> passado para o m�todo <A>RotateTransform</A>
/// especifica que a rota��o seguir� a escala. Da mesma forma, o argumento
/// <A>MatrixOrderAppend</A> passado para o m�todo <A>TranslateTransform</A>
/// especifica que a transla��o seguir� a rota��o. O resultado �
/// desenhado em vermelho.

procedure TDemoTransformationOrder.Example1;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.Red, 6);
  Graphics.ScaleTransform(1.75, 0.5);
  Graphics.RotateTransform(28, TGdipMatrixOrder.Append);
  Graphics.TranslateTransform(150, 150, TGdipMatrixOrder.Append);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;

/// O exemplo a seguir faz as mesmas chamadas de m�todo do exemplo anterior,
/// mas a ordem das chamadas � invertida. A ordem de opera��es resultante �
/// primeiro traduz, depois gira e depois dimensiona, o que produz um resultado muito diferente
/// resultado da primeira escala, depois girar e depois traduzir. O resultado � desenhado
/// em verde.

procedure TDemoTransformationOrder.Example2;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.Lime, 6);
  Graphics.TranslateTransform(150, 150);
  Graphics.RotateTransform(28, TGdipMatrixOrder.Append);
  Graphics.ScaleTransform(1.75, 0.5, TGdipMatrixOrder.Append);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;

/// Uma maneira de reverter a ordem das transforma��es individuais em um
/// transforma��o composta � inverter a ordem de uma sequ�ncia de m�todo
/// chamadas. Uma segunda maneira de controlar a ordem das opera��es � alterar o
/// argumento de ordem de matriz. O exemplo a seguir � igual ao anterior
/// exemplo, exceto que MatrixOrderAppend foi alterado para
/// MatrixOrderPrepend. A multiplica��o da matriz � feita na ordem SRT,
/// onde S, R e T s�o as matrizes para dimensionar, girar e transladar,
/// respectivamente. A ordem da transforma��o composta � primeiro escala, depois
/// gire e depois traduza. O resultado foi desenhado em amarelo.

procedure TDemoTransformationOrder.Example3;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.Yellow, 2);
  Graphics.TranslateTransform(150, 150, TGdipMatrixOrder.Prepend);
  Graphics.RotateTransform(28, TGdipMatrixOrder.Prepend);
  Graphics.ScaleTransform(1.75, 0.5, TGdipMatrixOrder.Prepend);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;

/// O resultado do exemplo anterior � o mesmo resultado que obtivemos em
/// o primeiro exemplo desta se��o (� por isso que o ret�ngulo amarelo se sobrep�e
/// o ret�ngulo vermelho). Isso ocorre porque invertemos a ordem do m�todo
/// chamadas e a ordem de multiplica��o da matriz.
{$ENDREGION}

procedure TDemoTransformationOrder.Run;
begin
  Example1();
  Graphics.ResetTransform();
  Example2();
  Graphics.ResetTransform();
  Example3();
end;

initialization
  RegisterDemo('Transforma��es\Por que a ordem de transforma��o � significativa', TDemoTransformationOrder);

end.
