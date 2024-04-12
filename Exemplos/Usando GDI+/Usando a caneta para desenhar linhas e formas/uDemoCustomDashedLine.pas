unit uDemoCustomDashedLine;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoCustomDashedLine = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// O GDI+ do Microsoft Windows fornece v�rios estilos de tra�o que est�o listados na
/// enumera��o <A>TGdipDashStyle</A>. Se esses estilos de tra�o padr�o n�o atenderem �s suas
/// necessidades, voc� pode criar um padr�o de tra�o personalizado.
///
/// Para desenhar uma linha tracejada personalizada, coloque os comprimentos dos tra�os e espa�os em um
/// array e passe o array para a propriedade <A>DashPattern</A>
/// de um objeto <A>TGdipPen</A>. O exemplo a seguir desenha uma linha tracejada personalizada
/// baseada no array [5, 2, 15, 4]. Se voc� multiplicar os elementos do array
/// pela largura da caneta de 5, voc� obt�m [25, 10, 75, 20].
/// Os tra�os exibidos alternam em comprimento entre 25 e 75, e os espa�os
/// alternam em comprimento entre 10 e 20.

procedure TDemoCustomDashedLine.Run;
const
  DashValues: TArray<Single> = [5, 2, 15, 4];
var
  BlackPen: TGdipPen;
begin
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0), 5);
  BlackPen.DashPattern := DashValues;
  Graphics.DrawLine(BlackPen, TPoint.Create(5, 5), TPoint.Create(405, 5));
  BlackPen.Free();
end;

/// Observe que o �ltimo tra�o deve ser menor que 25 unidades para que a linha
/// possa terminar em (405, 5).
{$ENDREGION}

initialization
  RegisterDemo('Usando a caneta para desenhar linhas e formas\Desenhando uma linha tracejada personalizada', TDemoCustomDashedLine);

end.
