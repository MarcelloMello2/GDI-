// Marcelo Melo
// 12/04/2024
//
// https://learn.microsoft.com/en-us/windows/win32/gdiplus/-gdiplus-drawing-a-line-use

unit uDemoDrawLine;

interface

uses
   Se7e.Drawing,
   uDemo;

type
  TDemoDrawLine = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Para desenhar uma linha no Microsoft Windows GDI+ voc� precisa de um objeto <A>TGdipGraphics</A>,
/// um objeto <A>TGdipPen</A> e um registro <A>TGdipColor</A>. O <A>TGdipGraphics</A>
/// fornece o m�todo <A>TGdipGraphics.DrawLine</A> e o <A>TGdipPen</A>
/// objeto cont�m atributos da linha, como cor e largura. A <A>TGdipPen</A>
/// objeto � passado como um argumento para o m�todo <A>TGdipGraphics.DrawLine</A>.
///
/// O c�digo a seguir desenha uma linha de (0, 0) a (200, 100). O argumento
/// passado para o construtor <A>TGdipPen</A> � uma refer�ncia a um <A>TGdipColor</A>
/// registro. Os quatro n�meros passados para o construtor de cores representam o
/// componentes alfa, vermelho, verde e azul da cor. O componente alfa
/// determina a transpar�ncia da cor; 0 � totalmente transparente e 255 �
/// totalmente opaco. Os quatro n�meros passaram para o <A>TGdipGraphics.DrawLine</A>
/// m�todo representam o ponto inicial (0, 0) e o ponto final (200, 100)
/// da linha.

procedure TDemoDrawLine.Run;
var
  Pen: TGdipPen;
begin
  Pen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 255));
  Graphics.DrawLine(Pen, 0, 0, 200, 100);
  Pen.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Introdu��o\Desenhar uma Linha', TDemoDrawLine);

end.
