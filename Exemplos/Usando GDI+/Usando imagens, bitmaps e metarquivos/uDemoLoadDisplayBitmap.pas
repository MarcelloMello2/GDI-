unit uDemoLoadDisplayBitmap;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoLoadDisplayBitmap = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Microsoft Windows GDI+ fornece a interface <A>TGdipImage</A> para trabalhar com
/// imagens raster (bitmaps) e imagens vetoriais (metarquivos). O <A>TGdipBitmap</A>
/// interface e a interface <A>TGdipMetafile</A> herdam do
/// Interface <A>TGdipImage</A>. A interface <A>TGdipBitmap</A> se expande no
/// capacidades da interface <A>TGdipImage</A> fornecendo m�todos adicionais
/// para carregar, salvar e manipular imagens raster. O <A>TGdipMetaquivo</A>
/// interface expande os recursos da interface <A>TGdipImage</A> ao
/// fornecendo m�todos adicionais para registrar e examinar imagens vetoriais.
///
/// Para exibir uma imagem raster (bitmap) na tela, voc� precisa de um <A>TGdipImage</A>
/// objeto e um objeto <A>TGdipGraphics</A>. Passe o nome de um arquivo (ou um ponteiro
/// para um fluxo) para um construtor <A>TGdipImage</A>. Depois de criar um
/// Objeto <A>TGdipImage</A>, passe esse objeto <A>TGdipImage</A> para o <A>DrawImage</A>
/// m�todo de um objeto <A>TGdipGraphics</A>.
///
/// O exemplo a seguir cria um objeto <A>TGdipImage</A> a partir de um arquivo JPEG e
/// ent�o desenha a imagem com seu canto superior esquerdo em (60, 10):

procedure TDemoLoadDisplayBitmap.Run;
var
  Image: TGdipImage;
begin
  Image := TGdipImage.FromFile('..\..\imagens\Grapes.jpg');
  Graphics.DrawImage(Image, 60, 10);
  Image.Free();
end;

/// A interface <A>TGdipImage</A> fornece m�todos b�sicos para carregar e
/// exibindo imagens raster e imagens vetoriais. A interface <A>TGdipBitmap</A>,
/// que herda da interface <A>TGdipImage</A>, fornece informa��es mais especializadas
/// m�todos para carregar, exibir e manipular imagens raster. Para
/// exemplo, voc� pode construir um objeto <A>TGdipBitmap</A> a partir de um identificador de �cone
/// (HICON).
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Carregando e exibindo bitmaps', TDemoLoadDisplayBitmap);

end.
