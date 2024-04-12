unit uDemoPenWidthAndAlignment;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoPenWidthAndAlignment = class(TDemo)
  strict private
    procedure DrawLine;
    procedure DrawRectangle;
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Ao criar um objeto <A>TGdipPen</A>, voc� pode fornecer a largura da caneta como um dos
/// os argumentos para o construtor. Voc� tamb�m pode alterar a largura da caneta usando
/// a propriedade <A>Width</A>.
///
/// Uma linha te�rica tem uma largura de zero. Quando voc� desenha uma linha, os pixels s�o
/// centrado na linha te�rica. O exemplo a seguir desenha um
/// linha duas vezes: uma vez com uma caneta preta de largura 1 e uma vez com uma caneta verde de
/// largura 10.

procedure TDemoPenWidthAndAlignment.DrawLine;
var
  BlackPen,
  GreenPen: TGdipPen;
begin
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0), 1);
  GreenPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 255, 0), 10);

  GreenPen.Alignment := TGdipPenAlignment.Center;
  Graphics.DrawLine(GreenPen, 10, 100, 100, 50);
  Graphics.DrawLine(BlackPen, 10, 100, 100, 50);

  GreenPen.Free();
  BlackPen.Free();
end;

/// Os pixels verdes e os pixels pretos est�o centrados na linha te�rica.
///
/// O exemplo a seguir desenha um ret�ngulo especificado duas vezes: uma vez com um preto
/// caneta de largura 1 e uma vez com caneta verde de largura 10. O c�digo passa o
/// valor <B>TGdipPenAlignment.Center</B> (um elemento do <A>TGdipPenAlignment.</A>
/// enumeration) para a propriedade <A>Alignment</A> para especificar que os pixels
/// desenhados com a caneta verde s�o centrados no limite do ret�ngulo.
/// Voc� pode alterar o alinhamento da caneta verde definindo o <A>Alinhamento</A>
/// para <B>TGdipPenAlignment.Inset</B>. Em seguida, os pixels na linha verde larga
/// aparecem no interior do ret�ngulo

procedure TDemoPenWidthAndAlignment.DrawRectangle;
var
  BlackPen,
  GreenPen: TGdipPen;
begin
  BlackPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 0, 0), 1);
  GreenPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 255, 0), 10);

  Graphics.DrawRectangle(GreenPen, 10, 120, 50, 50);
  Graphics.DrawRectangle(BlackPen, 10, 120, 50, 50);

  GreenPen.Alignment := TGdipPenAlignment.Inset;
  Graphics.DrawRectangle(GreenPen, 80, 120, 50, 50);
  Graphics.DrawRectangle(BlackPen, 80, 120, 50, 50);

  GreenPen.Free();
  BlackPen.Free();
end;
{$ENDREGION}

procedure TDemoPenWidthAndAlignment.Run;
begin
  DrawLine;
  DrawRectangle;
end;

initialization
  RegisterDemo('Usando a caneta para desenhar linhas e formas\Definindo a largura e o alinhamento da caneta', TDemoPenWidthAndAlignment);

end.
