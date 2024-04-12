unit uDemoJpegCompression;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoJpegCompression = class(TDemo)
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoJpegCompression }

class function TDemoJpegCompression.Outputs: TDemoOutputs;
begin
  Result := [doText, doGraphic];
end;

{$REGION}
/// Para especificar o n�vel de compacta��o ao salvar uma imagem JPEG, inicialize um
/// objeto <A>TGdipEncoderParameters</A> e passa esse objeto para <A>Save</A>
/// m�todo da classe <A>TGdipImage</A>. Os <A>EncoderParameters</A>
/// interface tem v�rios m�todos <A>Add</A> sobrecarregados que voc� pode usar para adicionar
/// par�metros. Para definir um n�vel de compacta��o JPEG, use o m�todo <A>Add</A> com
/// um tipo de par�metro EncoderQuality e um valor entre 0 e 100.
///
/// O exemplo a seguir salva tr�s imagens JPEG, cada uma com uma qualidade diferente
/// n�vel. Um n�vel de qualidade 0 corresponde � maior compacta��o e um
/// o n�vel de qualidade 100 corresponde � menor compacta��o.

procedure TDemoJpegCompression.Run;
var
  Image, JpegImage: TGdipImage;
  Params: TGdipEncoderParameters;
  Quality: Int32;
begin
  Image := TGdipImage.FromFile('..\..\imagens\GrapeBunch.bmp');
  Graphics.DrawImage(Image, 10, 10, Image.Width, Image.Height);

  Params := TGdipEncoderParameters.Create();

  // Salve a imagem como JPEG com n�vel de qualidade 1.
  Quality := 1;
  Params.Add(TGdipEncoder.Quality.Guid, Quality);
  try
    Image.Save('GrapeBunch001.jpg', TGdipImageFormat.Jpeg, Params);
    TextOutput.Add('GrapeBunch001.jpg foi salvo com sucesso.');

    JpegImage := TGdipImage.FromFile('GrapeBunch001.jpg');
    Graphics.DrawImage(JpegImage, 220, 10, JpegImage.Width, JpegImage.Height);
    JpegImage.Free();
  except
    on E: Exception do
      TextOutput.Add('A tentativa de salvar GrapeBunch001.jpg falhou: ' + E.Message);
  end;

  // Salve a imagem como JPEG com n�vel de qualidade 50.
  Quality := 50;
  Params.Clear;
  Params.Add(TGdipEncoder.Quality.Guid, Quality);
  try
    Image.Save('GrapeBunch050.jpg', TGdipImageFormat.Jpeg, Params);
    TextOutput.Add('GrapeBunch050.jpg foi salvo com sucesso.');

    JpegImage := TGdipImage.FromFile('GrapeBunch050.jpg');
    Graphics.DrawImage(JpegImage, 430, 10, JpegImage.Width, JpegImage.Height);
    JpegImage.Free();
  except
    on E: Exception do
      TextOutput.Add('Falha na tentativa de salvar GrapeBunch050.jpg: ' + E.Message);
  end;

  // Salve a imagem como JPEG com n�vel de qualidade 100.
  Quality := 100;
  Params.Clear;
  Params.Add(TGdipEncoder.Quality.Guid, Quality);
  try
    Image.Save('GrapeBunch100.jpg', TGdipImageFormat.Jpeg, Params);
    TextOutput.Add('GrapeBunch100.jpg foi salvo com sucesso.');

    JpegImage := TGdipImage.FromFile('GrapeBunch100.jpg');
    Graphics.DrawImage(JpegImage, 640, 10, JpegImage.Width, JpegImage.Height);
    JpegImage.Free();
  except
    on E: Exception do
      TextOutput.Add('Falha na tentativa de salvar GrapeBunch100.jpg: ' + E.Message);
  end;

  Params.Free();
  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Usando codificadores e decodificadores de imagens\Configurando o n�vel de compacta��o JPEG', TDemoJpegCompression);

end.
