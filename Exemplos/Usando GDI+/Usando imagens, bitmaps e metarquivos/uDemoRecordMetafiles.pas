unit uDemoRecordMetafiles;

interface

uses
   Types,
   Windows,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoRecordMetafiles = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

uses
  SysUtils;

{$REGION}
/// A interface <A>TGdipMetafile</A>, que herda do <A>TGdipImage</A>
/// interface, permite gravar uma sequ�ncia de comandos de desenho. O gravado
/// os comandos podem ser armazenados na mem�ria, salvos em um arquivo ou salvos em um fluxo.
/// Metarquivos podem conter gr�ficos vetoriais, imagens raster e texto.
///
/// O exemplo a seguir cria um objeto <A>TGdipMetafile</A>. O c�digo usa o
/// Objeto <A>TGdipMetafile</A> para gravar uma sequ�ncia de comandos gr�ficos e depois
/// salva os comandos gravados em um arquivo chamado SampleMetafileRecording.emf.
/// Observe que o construtor <A>TGdipMetafile</A> recebe um identificador de contexto de dispositivo,
/// e o construtor <A>TGdipGraphics</A> recebe o objeto <A>TGdipMetafile</A>.
/// A grava��o para (e os comandos gravados s�o salvos no arquivo) quando
/// o objeto <A>TGdipGraphics</A> sai do escopo. A �ltima linha de exibi��o do c�digo
/// o metarquivo passando o objeto <A>TGdipMetafile</A> para o <A>DrawImage</A>
/// m�todo do objeto <A>TGdipGraphics</A>. Observe que o c�digo usa o mesmo
/// Objeto <A>TGdipMetafile</A> para gravar e exibir (reproduzir) o metarquivo.

procedure TDemoRecordMetafiles.Run;
var
  DC: HDC;
  Metafile: TGdipMetafile;
  MetaGraphics: TGdipGraphics;
  GreenPen: TGdipPen;
  SolidBrush: TGdipSolidBrush;
  FontFamily: TGdipFontFamily;
  Font: TGdipFont;
begin
  DC := GetDC(0);
  try
    DeleteFile('SampleMetafileRecording.emf');
    Metafile := TGdipMetafile.Create('SampleMetafileRecording.emf', DC);
    MetaGraphics := TGdipGraphics.FromImage(Metafile);
    GreenPen := TGdipPen.Create(TGdipColor.FromArgb(255, 0, 255, 0));
    SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 0, 0, 255));

    // Adicione um ret�ngulo e uma elipse ao metarquivo.
    MetaGraphics.DrawRectangle(GreenPen, TRectangle.Create(50, 10, 25, 75));
    MetaGraphics.DrawEllipse(GreenPen, TRectangle.Create(100, 10, 25, 75));

    // Adicione uma elipse (desenhada com antialiasing) ao metarquivo.
    MetaGraphics.SmoothingMode := TGdipSmoothingMode.HighQuality;
    MetaGraphics.DrawEllipse(GreenPen, TRectangle.Create(150, 10, 25, 75));

    // Adicione algum texto (desenhado com antialiasing) ao metarquivo.
    FontFamily := TGdipFontFamily.Create('Arial');
    Font := TGdipFont.Create(FontFamily, 24, TGdipFontStyle.Regular, TGdipGraphicsUnit.Pixel);

    MetaGraphics.TextRenderingHint := TGdipTextRenderingHint.AntiAlias;
    MetaGraphics.RotateTransform(30);
    MetaGraphics.DrawString('Texto Suave', Font, SolidBrush, TPointF.Create(50, 50));

    Font.Free();
    FontFamily.Free();
    SolidBrush.Free();
    GreenPen.Free();
    MetaGraphics.Free(); // Fim da grava��o do metarquivo.

    // Reproduza o metarquivo.
    Graphics.DrawImage(Metafile, 200, 100);
    Metafile.Free();
  finally
    ReleaseDC(0, DC);
  end;
end;

/// <B>Nota</B> Para gravar um metarquivo, voc� deve construir um <A>TGdipGraphics</A>
/// objeto baseado em um objeto <A>TGdipMetafile</A>. A grava��o do metarquivo
/// termina quando o objeto <A>TGdipGraphics</A> � exclu�do ou sai do escopo.
///
/// Um metarquivo cont�m seu pr�prio estado gr�fico, que � definido pelo
/// Objeto <A>TGdipGraphics</A> usado para registrar o metarquivo. Quaisquer propriedades do
/// Objeto <A>TGdipGraphics</A> (regi�o do clipe, transforma��o do mundo, modo de suaviza��o,
/// e similares) que voc� definiu durante a grava��o do metarquivo ser�o armazenados em
/// o metarquivo. Ao exibir o metarquivo, o desenho ser� feito
/// de acordo com essas propriedades armazenadas.
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Gravando Metarquivos', TDemoRecordMetafiles);

end.
