unit uDemoWorldTransformations;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoWorldTransformations = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
    procedure Example3;
    procedure Example4;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoWorldTransformations }

{$REGION}
/// As transforma��es afins incluem rota��o, dimensionamento, reflex�o, cisalhamento e
/// traduzindo. No Microsoft Windows GDI+, a interface <A>TGdipMatrix</A>
/// fornece a base para realizar transforma��es afins em vetores
/// desenhos, imagens e texto.
///
/// A transforma��o mundial � uma propriedade da interface <A>TGdipGraphics</A>.
/// Os n�meros que especificam a transforma��o mundial s�o armazenados em um
/// Objeto <A>TGdipMatrix</A>, que representa uma matriz 3�3. O <A>TGdipMatrix</A> e
/// As interfaces <A>TGdipGraphics</A> possuem v�rios m�todos para definir os n�meros em
/// a matriz de transforma��o mundial. Os exemplos nesta se��o manipulam
/// ret�ngulos porque ret�ngulos s�o f�ceis de desenhar e � f�cil ver o
/// efeitos de transforma��es em ret�ngulos.
///
/// Come�amos criando um ret�ngulo de 50 por 50 e localizando-o na origem
/// (0, 0). A origem est� no canto superior esquerdo da �rea do cliente. O
/// o ret�ngulo � desenhado em vermelho.

procedure TDemoWorldTransformations.Example1;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.Red, 2);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;

/// O c�digo a seguir aplica uma transforma��o de escala que expande o
/// ret�ngulo por um fator de 1,75 na dire��o x e reduz o ret�ngulo
/// por um fator de 0,5 na dire��o y. O resultado est� desenhado em verde.

procedure TDemoWorldTransformations.Example2;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.LimeGreen, 2);
  Graphics.ScaleTransform(1.75, 0.5);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;

/// O resultado � um ret�ngulo que � mais longo na dire��o x e mais curto na
/// a dire��o y que a original.
///
/// Para girar o ret�ngulo em vez de escal�-lo, use o c�digo a seguir.
/// O resultado � desenhado em azul.

procedure TDemoWorldTransformations.Example3;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.Blue, 2);
  Graphics.RotateTransform(28);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;

/// Para traduzir o ret�ngulo, use o seguinte c�digo (desenhado em roxo)

procedure TDemoWorldTransformations.Example4;
var
  Rect: TRectangle;
  Pen: TGdipPen;
begin
  Rect := TRectangle.Create(0, 0, 50, 50);
  Pen := TGdipPen.Create(TGdipColor.Fuchsia, 2);
  Graphics.TranslateTransform(150, 150);
  Graphics.DrawRectangle(Pen, Rect);
  Pen.Free();
end;
{$ENDREGION}

procedure TDemoWorldTransformations.Run;
begin
  Example1();
  Example2();
  Graphics.ResetTransform();
  Example3();
  Graphics.ResetTransform();
  Example4();
end;

initialization
  RegisterDemo('Transforma��es\Usando a transforma��o mundial', TDemoWorldTransformations);

end.
