unit uDemoHitTestRegion;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoHitTestRegion = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoHitTestRegion }

{$REGION}
/// A interface Microsoft Windows GDI+ <A>TGdipRegion</A> permite definir um
/// forma personalizada. A forma pode ser composta de linhas, pol�gonos e curvas.
///
/// Dois usos comuns para regi�es s�o testes de acesso e recorte. O teste de acerto �
/// determinar se o mouse foi clicado em determinada regi�o da tela.
/// Clipping restringe o desenho a uma determinada regi�o.
///
/// O objetivo do teste de acerto � determinar se o cursor est� sobre um
/// determinado objeto, como um �cone ou um bot�o. O exemplo a seguir cria um
/// regi�o em forma de plus formando a uni�o de duas regi�es retangulares. Presumir
/// que o par�metro <I>MousePoint</I> cont�m a localiza��o do mais recente
/// clique. O c�digo verifica se <I>MousePoint</I> est� no
/// regi�o em forma de plus. Se <I>MousePoint</I> estiver na regi�o (um hit), o
/// a regi�o � preenchida com um pincel vermelho opaco. Caso contr�rio, a regi�o � preenchida
/// com um pincel vermelho semitransparente.

procedure TDemoHitTestRegion.Run;

  procedure HitTest(const RegionOffset, MousePoint: TPoint);
  var
    Brush: TGdipSolidBrush;
    Region1,
    Region2: TGdipRegion;
  begin
    Brush := TGdipSolidBrush.Create(TGdipColor.FromArgb(0));
    // Crie uma regi�o em forma de sinal de adi��o formando a uni�o da Regi�o1 e da Regi�o2.
    Region1 := TGdipRegion.Create(TRectangle.Create(RegionOffset.X + 50, RegionOffset.Y, 50, 150));
    Region2 := TGdipRegion.Create(TRectangle.Create(RegionOffset.X, RegionOffset.Y + 50, 150, 50));
    // A uni�o substitui a Regi�o1.
    Region1.Union(Region2);

    if (Region1.IsVisible(MousePoint, Graphics)) then
      Brush.Color := TGdipColor.FromArgb(255, 255, 0, 0)
    else
      Brush.Color := TGdipColor.FromArgb(64, 255, 0, 0);
    Graphics.FillRegion(Brush, Region1);

    // Desenhe MousePoint para refer�ncia
    Brush.Color := TGdipColor.Blue;
    Graphics.FillRectangle(Brush, MousePoint.X - 2, MousePoint.Y - 2, 5, 5);

    Region2.Free();
    Region1.Free();
    Brush.Free();
  end;

begin
  HitTest(TPoint.Create(0, 0), TPoint.Create(60, 10));
  HitTest(TPoint.Create(200, 0), TPoint.Create(220, 20));
end;
{$ENDREGION}

initialization
  RegisterDemo('Usando regi�es\Teste de sucesso com uma regi�o', TDemoHitTestRegion);

end.
