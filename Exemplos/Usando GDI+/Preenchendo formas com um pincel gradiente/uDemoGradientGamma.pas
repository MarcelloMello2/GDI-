unit uDemoGradientGamma;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoGradientGamma = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoGradientGamma }

{$REGION}
/// Voc� pode ativar a corre��o gama para um pincel de gradiente definindo o
/// Propriedade <A>GammaCorrection</A> de at brush como True. Voc� pode desativar gama
/// corre��o definindo a propriedade <A>GammaCorrection</A> como False. Gama
/// a corre��o est� desabilitada por padr�o.
///
/// O exemplo a seguir cria um pincel de gradiente linear e usa esse pincel para
/// preenche dois ret�ngulos. O primeiro ret�ngulo � preenchido sem corre��o gama
/// e o segundo ret�ngulo � preenchido com corre��o gama.

procedure TDemoGradientGamma.Example1;
var
   Brush: TGdipLinearGradientBrush;
begin
   Brush := TGdipLinearGradientBrush.Create(TPoint.Create(0, 10),
                                            TPoint.Create(200, 10),
                                            TGdipColor.Red, TGdipColor.Blue);
   Graphics.FillRectangle(Brush, 0, 0, 200, 50);
   Brush.GammaCorrection := True;
   Graphics.FillRectangle(Brush, 0, 60, 200, 50);

   Brush.Free();
end;

/// A ilustra��o acima mostra os dois ret�ngulos preenchidos. O ret�ngulo superior,
/// que n�o possui corre��o gama, aparece escuro no meio. O fundo
/// o ret�ngulo, que possui corre��o gama, parece ter intensidade mais uniforme.
///
/// O exemplo a seguir cria um pincel de gradiente de caminho baseado em um formato de estrela
/// caminho. O c�digo usa o pincel gradiente de caminho com a corre��o gama desativada
/// (o padr�o) para preencher o caminho. Ent�o o c�digo define o
/// propriedade <A>GammaCorrection</A> como True para ativar a corre��o gama para o
/// pincel gradiente de caminho. A chamada para conjuntos <A>TGdipGraphics.TranslateTransform</A>
/// a transforma��o mundial de um objeto <A>TGdipGraphics</A> para que o subseq�ente
/// chamada para <A>FillPath</A> preenche uma estrela que fica � direita da primeira
/// estrela.

procedure TDemoGradientGamma.Example2;
var
   Points: TArray<TPoint>;
   Path: TGdipGraphicsPath;
   Brush: TGdipPathGradientBrush;
   Colors: TArray<TGdipColor>;
begin
   Points :=
   [
      TPoint.Create(75, 120),  TPoint.Create(100, 170),
      TPoint.Create(150, 170), TPoint.Create(112, 195),
      TPoint.Create(150, 270), TPoint.Create(75,  220),
      TPoint.Create(0,   270), TPoint.Create(37,  195),
      TPoint.Create(0,   170), TPoint.Create(50,  170)
   ];

   Path := TGdipGraphicsPath.Create();
   Path.AddLines(Points);

   Brush := TGdipPathGradientBrush.Create(Path);
   Brush.CenterColor := TGdipColor.Red;

   Colors :=
   [
      TGdipColor.FromArgb(255,   0,   0,   0),
      TGdipColor.FromArgb(255,   0, 255,   0),
      TGdipColor.FromArgb(255,   0,   0, 255),
      TGdipColor.FromArgb(255, 255, 255, 255),
      TGdipColor.FromArgb(255,   0,   0,   0),
      TGdipColor.FromArgb(255,   0, 255,   0),
      TGdipColor.FromArgb(255,   0,   0, 255),
      TGdipColor.FromArgb(255, 255, 255, 255),
      TGdipColor.FromArgb(255,   0,   0,   0),
      TGdipColor.FromArgb(255,   0, 255,   0)
   ];
   Brush.SurroundColors := Colors;

   Graphics.FillPath(Brush, Path);
   Brush.GammaCorrection := True;
   Graphics.TranslateTransform(200, 0);
   Graphics.FillPath(Brush, Path);

   Brush.Free();
   Path.Free();
end;

/// A ilustra��o acima mostra a sa�da do c�digo anterior. A estrela ligada
/// a direita tem corre��o gama. Observe que a estrela � esquerda, que faz
/// n�o possui corre��o gama, possui �reas que parecem escuras.
{$ENDREGION}

procedure TDemoGradientGamma.Run;
begin
  Example1;
  Example2;
end;

initialization
  RegisterDemo('Preenchendo formas com um pincel gradiente\Aplicando corre��o gama a um gradiente', TDemoGradientGamma);

end.
