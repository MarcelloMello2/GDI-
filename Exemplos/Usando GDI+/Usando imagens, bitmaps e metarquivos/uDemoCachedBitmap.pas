unit uDemoCachedBitmap;

interface

uses
   Winapi.Windows,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoCachedBitmap = class(TDemo)
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoCachedBitmap }

class function TDemoCachedBitmap.Outputs: TDemoOutputs;
begin
  Result := [doGraphic, doText];
end;

{$REGION}
/// Os objetos <A>TGdipImage</A> e <A>TGdipBitmap</A> armazenam imagens em um formato independente de dispositivo
/// formato. Um objeto <A>TGdipCachedBitmap</A> armazena uma imagem no formato do
/// dispositivo de exibi��o atual. Renderizando uma imagem armazenada em um <A>CachedBitmap</A>
/// o objeto � r�pido porque nenhum tempo de processamento � gasto na convers�o da imagem para
/// o formato exigido pelo dispositivo de exibi��o.
///
/// O exemplo a seguir cria um objeto <A>TGdipBitmap</A> e um
/// Objeto <A>TGdipCachedBitmap</A> do arquivo Texture1.jpg. O <A>TGdipBitmap</A>
/// e o <A>TGdipCachedBitmap</A> s�o desenhados 30.000 vezes cada. Se voc� executar o
/// c�digo, voc� ver� que as imagens <A>TGdipCachedBitmap</A> s�o desenhadas
/// substancialmente mais r�pido que as imagens <A>TGdipBitmap</A>.
/// Voc� pode conferir os tempos de sorteio clicando na aba "Texto" acima.

procedure TDemoCachedBitmap.Run;
var
  Bitmap: TGdipBitmap;
  Cached: TGdipCachedBitmap;
  Width, Height, J, K: Integer;
  Freq, ST, ET: Int64;
  Seconds: Double;
begin
  QueryPerformanceFrequency(Freq);
  Bitmap := TGdipBitmap.Create('..\..\imagens\Texture1.bmp');
  Width := Bitmap.Width;
  Height := Bitmap.Height;
  Cached := TGdipCachedBitmap.Create(Bitmap, Graphics);

  QueryPerformanceCounter(ST);
  J := 0;
  while (J < 300) do
  begin
    for K := 0 to 999 do
      Graphics.DrawImage(Bitmap, J, J div 2, Width, Height);
    Inc(J, 10);
  end;
  QueryPerformanceCounter(ET);
  Bitmap.Free();

  Seconds := (ET - ST) / Freq;
  TextOutput.Add(Format('DrawImage: %.2f segundos',[Seconds]));

  QueryPerformanceCounter(ST);
  J := 0;
  while (J < 300) do
  begin
    for K := 0 to 999 do
      Graphics.DrawCachedBitmap(Cached, J, 150 + J div 2);
    Inc(J, 10);
  end;
  QueryPerformanceCounter(ET);
  Seconds := (ET - ST) / Freq;
  TextOutput.Add(Format('DrawCachedBitmap: %.2f segundos',[Seconds]));

  Cached.Free();
end;

/// <B>Nota</B> Um objeto <A>TGdipCachedBitmap</A> corresponde ao formato da exibi��o
/// dispositivo no momento em que o objeto <A>TGdipCachedBitmap</A> foi constru�do. Se o
/// usu�rio do seu programa altera as configura��es de exibi��o, seu c�digo deve
/// constr�i um novo objeto <A>TGdipCachedBitmap</A>. O <A>DrawCachedBitmap</A>
/// o m�todo falhar� se voc� passar para ele um objeto <A>TGdipCachedBitmap</A> que foi
/// criado antes de uma altera��o no formato de exibi��o.
{$ENDREGION}

initialization
  RegisterDemo('Usando imagens, bitmaps e metarquivos\Usando um bitmap em cache para melhorar o desempenho', TDemoCachedBitmap);

end.
