unit uDemoClipRegion;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoClipRegion = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoClipRegion }

{$REGION}
/// Uma das propriedades da interface <A>TGdipGraphics</A> � o recorte
/// regi�o. Todo desenho feito por um determinado objeto <A>TGdipGraphics</A> � restrito a
/// a regi�o de recorte desse objeto <A>TGdipGraphics</A>. Voc� pode definir o
/// recorte a regi�o chamando o m�todo <A>SetClip</A> ou definindo o
/// Propriedade <A>Clip</A>.
///
/// O exemplo a seguir constr�i um caminho que consiste em um �nico pol�gono.
/// Ent�o o c�digo constr�i uma regi�o baseada nesse caminho. A regi�o �
/// atribu�do � propriedade <A>Clip</A> do objeto <A>TGdipGraphics</A>, e
/// ent�o duas strings s�o desenhadas.

procedure TDemoClipRegion.Run;
var
  Path: TGdipGraphicsPath;
  Region: TGdipRegion;
  Pen: TGdipPen;
  Font: TGdipFont;
  Brush: TGdipBrush;
begin
   var PolyPoints: TArray<TPoint> :=
   [
      TPoint.Create(10, 10),
      TPoint.Create(150, 10),
      TPoint.Create(100, 75),
      TPoint.Create(100, 150)
   ];

  Path := TGdipGraphicsPath.Create;
  Path.AddPolygon(PolyPoints);
  Region := TGdipRegion.Create(Path);
  Pen := TGdipPen.Create(TGdipColor.Black);
  Graphics.DrawPath(Pen, Path);

  Graphics.Clip := Region;
  Font := TGdipFont.Create('Arial', 36, TGdipFontStyle.Bold, TGdipGraphicsUnit.Pixel);
  Brush := TGdipSolidBrush.Create(TGdipColor.Red);
  Graphics.DrawString('Uma regi�o de recorte', Font, Brush, TPointF.Create(15, 25));
  Graphics.DrawString('Uma regi�o de recorte', Font, Brush, TPointF.Create(15, 68));

  Brush.Free();
  Font.Free();
  Pen.Free();
  Region.Free();
  Path.Free();
end;

/// A ilustra��o acima mostra as strings cortadas.
{$ENDREGION}

initialization
  RegisterDemo('Usando regi�es\Recortando com uma regi�o', TDemoClipRegion);

end.
