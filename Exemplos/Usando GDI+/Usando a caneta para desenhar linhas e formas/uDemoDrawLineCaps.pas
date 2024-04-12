unit uDemoDrawLineCaps;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoDrawLineCaps = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Voc� pode desenhar o in�cio ou o fim de uma linha em uma das v�rias formas chamadas
/// termina��es de linha. O GDI+ do Microsoft Windows suporta v�rias termina��es de linha,
/// como redonda, quadrada, diamante e ponta de flecha.
///
/// Voc� pode especificar as termina��es de linha para o in�cio de uma linha (capa inicial),
/// o fim de uma linha (capa final) ou os tra�os de uma linha tracejada (capa de tra�o).
///
/// O exemplo a seguir desenha uma linha com uma ponta de flecha em uma extremidade e uma
/// capa redonda na outra extremidade:

procedure TDemoDrawLineCaps.Run;
var
  Pen: TGdipPen;
begin
  Pen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0,255), 8);
  Pen.StartCap := TGdipLineCap.ArrowAnchor;
  Pen.EndCap := TGdipLineCap.RoundAnchor;
  Graphics.DrawLine(Pen, 20, 175, 300, 175);
  Pen.Free();
end;

/// <B>TGdipLineCap.ArrowAnchor</B> e <B>TGdipLineCap.RoundAnchor</B> s�o elementos da
/// enumera��o <A>TGdipLineCap.</A>.
{$ENDREGION}

initialization
  RegisterDemo('Usando a caneta para desenhar linhas e formas\Desenhando uma linha com termina��es de linha', TDemoDrawLineCaps);

end.
