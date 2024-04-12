unit uDemoColorMatrixTransform;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoColorMatrixTransform = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoColorMatrixTransform }

{$REGION}
/// Recolorir � o processo de ajuste das cores da imagem. Alguns exemplos de
/// recolorir � mudar uma cor para outra, ajustando a intensidade de uma cor
/// em rela��o a outra cor, ajustando o brilho ou contraste de todas
/// cores e convers�o de cores em tons de cinza.
///
/// Microsoft Windows GDI+ fornece <A>TGdipImage</A> e <A>TGdipBitmap</A>
/// interface para armazenamento e manipula��o de imagens. <A>TGdipImage</A> e
/// Os objetos <A>TGdipBitmap</A> armazenam a cor de cada pixel como um n�mero de 32 bits:
/// 8 bits cada para vermelho, verde, azul e alfa. Cada um dos quatro componentes �
/// um n�mero de 0 a 255, com 0 representando nenhuma intensidade e 255
///representando intensidade total. O componente alfa especifica a transpar�ncia
/// da cor: 0 � totalmente transparente e 255 � totalmente opaco.
///
/// Um vetor de cores � uma tupla de 4 na forma (vermelho, verde, azul, alfa). Para
/// exemplo, o vetor de cores (0, 255, 0, 255) representa uma cor opaca que
/// n�o tem vermelho nem azul, mas tem verde em intensidade total.
///
/// Outra conven��o para representar cores usa o n�mero 1 para m�ximo
/// intensidade e o n�mero 0 para intensidade m�nima. Usando essa conven��o, o
/// a cor descrita no par�grafo anterior seria representada pelo
/// vetor (0, 1, 0, 1). GDI+ usa a conven��o de 1 como intensidade total quando
/// realiza transforma��es de cores.
///
/// Voc� pode aplicar transforma��es lineares (rota��o, escala e similares) a
/// vetores coloridos multiplicando por uma matriz 4�4. No entanto, voc� n�o pode usar um 4�4
/// matriz para realizar uma tradu��o (n�o linear). Se voc� adicionar um quinto fict�cio
/// coordenada (por exemplo, o n�mero 1) para cada um dos vetores de cores, voc� pode
/// usa uma matriz 5�5 para aplicar qualquer combina��o de transforma��es lineares e
/// tradu��es. Uma transforma��o que consiste em uma transforma��o linear
/// seguido por uma tradu��o � chamado de transforma��o afim. Uma matriz 5�5
/// que representa uma transforma��o afim � chamada de matriz homog�nea para
/// uma transforma��o de 4 espa�os. O elemento na quinta linha e na quinta coluna de um
/// Matriz homog�nea 5�5 deve ser 1, e todas as outras entradas na quinta
/// coluna deve ser 0.
///
/// Por exemplo, suponha que voc� queira come�ar com a cor (0,2, 0,0, 0,4, 1,0)
/// e aplique as seguintes transforma��es:
///
/// -Duplique o componente vermelho
/// -Adicione 0,2 aos componentes vermelho, verde e azul
///
/// A seguinte multiplica��o de matrizes realizar� o par de transforma��es
/// na ordem listada.
///
/// | 2,0 0,0 0,0 0,0 0,0 |
/// | 0,0 1,0 0,0 0,0 0,0 |
/// | 0,0 0,0 1,0 0,0 0,0 |
/// | 0,0 0,0 0,0 1,0 0,0 |
/// | 0,2 0,2 0,2 0,0 1,0 |
///
/// Os elementos de uma matriz de cores s�o indexados (com base em zero) por linha e depois
/// coluna. Por exemplo, a entrada na quinta linha e terceira coluna da matriz
/// M � denotado por M[4,2].
///
/// A matriz identidade 5�5 tem 1s na diagonal e 0s em todos os outros lugares. Se
/// voc� multiplica um vetor de cores pela matriz identidade, o vetor de cores faz
/// n�o mudar. Uma maneira conveniente de formar a matriz de uma transforma��o de cores �
/// para come�ar com a matriz identidade e fazer uma pequena mudan�a que produza o
/// transforma��o desejada.
///
/// Para uma discuss�o mais detalhada sobre matrizes e transforma��es, consulte o
/// t�pico <A>Sistemas de Coordenadas e Transforma��es</A> no Platform SDK.
///
/// O exemplo a seguir pega uma imagem que � toda de uma cor
/// (0,2, 0,0, 0,4, 1,0) e aplica a transforma��o descrita no
/// par�grafos anteriores.

procedure TDemoColorMatrixTransform.Run;
var
  ColorMatrix: TGdipColorMatrix;
  Bitmap: TGdipBitmap;
  BitmapGraphics: TGdipGraphics;
  ImageAttributes: TGdipImageAttributes;
begin
   ColorMatrix := TGdipColorMatrix.Create
   (
      [
         [2.0, 0.0, 0.0, 0.0, 0.0],
         [0.0, 1.0, 0.0, 0.0, 0.0],
         [0.0, 0.0, 1.0, 0.0, 0.0],
         [0.0, 0.0, 0.0, 1.0, 0.0],
         [0.2, 0.2, 0.2, 0.0, 1.0]
      ]
   );

  Bitmap := TGdipBitmap.Create(100, 100);
  BitmapGraphics := TGdipGraphics.FromImage(Bitmap);
  BitmapGraphics.Clear(TGdipColor.FromArgb(255, 51, 0, 102));

  ImageAttributes := TGdipImageAttributes.Create;
  ImageAttributes.SetColorMatrix(ColorMatrix, TGdipColorMatrixFlag.Default, TGdipColorAdjustType.Bitmap);

  Graphics.DrawImage(Bitmap, 10, 10);
  Graphics.DrawImage(Bitmap,
    TRectangle.Create(120, 10, 100, 100), // ret�ngulo de destino
    0, 0, 100, 100,    // ret�ngulo de origem
    TGdipGraphicsUnit.Pixel, ImageAttributes);

  ImageAttributes.Free();
  BitmapGraphics.Free();
  Bitmap.Free();
  ColorMatrix.Free();
end;

/// A ilustra��o acima mostra a imagem original � esquerda e o
/// imagem transformada � direita.
///
/// O c�digo no exemplo anterior usa as etapas a seguir para executar o
/// recolorir:
/// 1. Inicialize um registro <A>TGdipColorMatrix</A>.
/// 2. Crie um objeto <A>TGdipImageAttributes</A> e passe o <A>TGdipColorMatrix</A>
/// grava no m�todo <A>SetColorMatrix</A> do <A>TGdipImageAttributes</A>
/// objeto.
/// 3. Passe o objeto <A>TGdipImageAttributes</A> para <A>TGdipGraphics.DrawImage</A>
/// m�todo de um objeto <A>TGdipGraphics</A>.
{$ENDREGION}

initialization
  RegisterDemo('Recolorir\Usando uma matriz de cores para transformar uma �nica cor', TDemoColorMatrixTransform);

end.
