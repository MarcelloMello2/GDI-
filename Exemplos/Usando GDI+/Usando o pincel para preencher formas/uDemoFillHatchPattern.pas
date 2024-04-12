unit uDemoFillHatchPattern;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoFillHatchPattern = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Um padr�o de hachura � feito de duas cores: uma para o fundo e outra para
/// as linhas que formam o padr�o sobre o fundo. Para preencher uma forma fechada
/// com um padr�o de hachura, use um objeto <A>TGdipHatchBrush</A>. O exemplo a seguir
/// demonstra como preencher uma elipse com um padr�o de hachura:

procedure TDemoFillHatchPattern.Run;
var
  Brush: TGdipHatchBrush;
begin
  Brush := TGdipHatchBrush.Create(TGdipHatchStyle.Horizontal, TGdipColor.FromArgb(255, 255, 0, 0), TGdipColor.FromArgb(255, 128, 255, 255));
  Graphics.FillEllipse(Brush, 0, 0, 100, 60);
  Brush.Free();
end;

/// O construtor <A>TGdipHatchBrush</A> recebe tr�s argumentos: o estilo da hachura,
/// a cor da linha da hachura e a cor do fundo. O argumento do estilo da hachura
/// pode ser qualquer elemento da enumera��o <A>TGdipHatchStyle</A>.
/// H� mais de cinquenta elementos na enumera��o <A>TGdipHatchStyle</A>; alguns
/// desses elementos s�o mostrados na seguinte lista:
///
///  - <B>HatchStyleHorizontal</B>
///  - <B>HatchStyleVertical</B>
///  - <B>HatchStyleForwardDiagonal</B>
///  - <B>HatchStyleBackwardDiagonal</B>
///  - <B>HatchStyleCross</B>
///  - <B>HatchStyleDiagonalCross</B>
{$ENDREGION}

initialization
  RegisterDemo('Usando o pincel para preencher formas\Preenchendo uma forma com um padr�o de hachura', TDemoFillHatchPattern);

end.
