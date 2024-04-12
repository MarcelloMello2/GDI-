unit uDemoJoiningLines;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoJoiningLines = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Uma jun��o de linha � a �rea comum que � formada por duas linhas cujas extremidades se encontram
/// ou se sobrep�em. O GDI+ do Microsoft Windows fornece quatro estilos de jun��o de linha: em mitra,
/// chanfrado, arredondado e mitra cortada. O estilo de jun��o de linha � uma propriedade da
/// interface <A>TGdipPen</A>. Quando voc� especifica um estilo de jun��o de linha para uma caneta e depois
/// usa essa caneta para desenhar um caminho, o estilo de jun��o especificado � aplicado a todas as
/// linhas conectadas no caminho.
///
/// Voc� pode especificar o estilo de jun��o de linha usando a propriedade <A>TGdipLineJoin</A> da
/// interface <A>TGdipPen</A>. O exemplo a seguir demonstra uma jun��o de linha chanfrada entre uma linha
/// horizontal e uma linha vertical:

procedure TDemoJoiningLines.Run;
var
  Path: TGdipGraphicsPath;
  PenJoin: TGdipPen;
begin
  Path := TGdipGraphicsPath.Create;
  PenJoin := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 255), 8);

  Path.StartFigure;
  Path.AddLine(TPoint.Create(50, 200), TPoint.Create(100, 200));
  Path.AddLine(TPoint.Create(100, 200), TPoint.Create(100, 250));

  PenJoin.LineJoin := TGdipLineJoin.Bevel;
  Graphics.DrawPath(PenJoin, Path);

  PenJoin.Free();
  Path.Free();
end;

/// No exemplo anterior, o valor (<B>TGdipLineJoin.Bevel</B>) passado para a
/// propriedade <A>GdipLineJoin</A> � um elemento da enumera��o <A>TGdipLineJoin</A>.
{$ENDREGION}

initialization
  RegisterDemo('Usando a caneta para desenhar linhas e formas\Unindo linhas', TDemoJoiningLines);

end.
