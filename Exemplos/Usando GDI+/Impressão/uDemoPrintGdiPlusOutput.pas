unit uDemoPrintGdiPlusOutput;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoPrintGdiPlusOutput = class(TDemo)
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  Printers;

{ TDemoPrintGdiPlusOutput }

{$REGION}
/// Com alguns pequenos ajustes em seu c�digo, voc� pode enviar ao Microsoft Windows
/// Sa�da GDI+ para uma impressora em vez de para uma tela. Para desenhar em uma impressora,
/// obt�m um identificador de contexto de dispositivo para a impressora e passa esse identificador para um
/// Construtor <A>TGdipGraphics</A>. Coloque seus comandos de desenho GDI+ entre
/// chamadas para <A>StartDoc</A> e <A>EndDoc</A>.
///
/// Uma maneira de obter um identificador de contexto de dispositivo para uma impressora � exibir um print
/// caixa de di�logo e permite que o usu�rio escolha uma impressora.
///
/// O exemplo a seguir desenha uma linha, um ret�ngulo e uma elipse no
/// impressora selecionada na caixa de di�logo de impress�o. Clique no bot�o "Imprimir" acima
/// para executar o exemplo.

procedure TDemoPrintGdiPlusOutput.Run;
var
  PrinterGraphics: TGdipGraphics;
  Pen: TGdipPen;
begin
  Printer.BeginDoc;
  PrinterGraphics := TGdipGraphics.FromHdc(Printer.Handle);
  Pen := TGdipPen.Create(TGdipColor.Black);
  PrinterGraphics.DrawRectangle(Pen, 200, 500, 200, 150);
  PrinterGraphics.DrawEllipse(Pen, 200, 500, 200, 150);
  PrinterGraphics.DrawLine(Pen, 200, 500, 400, 650);
  Printer.EndDoc;

  Pen.Free();
  PrinterGraphics.Free();
end;

/// No c�digo anterior, os tr�s comandos de desenho GDI+ est�o entre as chamadas
/// para os m�todos <A>Printer.BeginDoc</A> e <A>Printer.EndDoc</A>. Todos
/// comandos gr�ficos entre <A>BeginDoc</A> e <A>EndDoc</A> s�o roteados para um
/// metarquivo tempor�rio. Ap�s a chamada para <A>EndDoc</A>, o driver da impressora
/// converte os dados no metarquivo para o formato exigido pelo espec�fico
/// impressora sendo usada.
///
/// <B>Nota</B> Se o spool n�o estiver habilitado para a impressora que est� sendo usada, o
/// a sa�da gr�fica n�o � roteada para um metarquivo. Em vez disso, gr�ficos individuais
/// os comandos s�o processados pelo driver da impressora e depois enviados para a impressora.
{$ENDREGION}

class function TDemoPrintGdiPlusOutput.Outputs: TDemoOutputs;
begin
  Result := [doPrint];
end;

initialization
  RegisterDemo('Impress�o\Enviando sa�da GDI+ para uma impressora', TDemoPrintGdiPlusOutput);

end.
