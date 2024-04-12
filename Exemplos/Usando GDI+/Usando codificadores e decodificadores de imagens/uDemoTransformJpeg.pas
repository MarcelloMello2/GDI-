unit uDemoTransformJpeg;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoTransformJpeg = class(TDemo)
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoTransformJpeg }

class function TDemoTransformJpeg.Outputs: TDemoOutputs;
begin
  Result := [doGraphic, doText];
end;

{$REGION}
/// Quando voc� compacta uma imagem JPEG, algumas informa��es da imagem s�o
/// perdido. Se voc� abrir um arquivo JPEG, altere a imagem e salve-a em outro JPEG
/// arquivo, a qualidade diminuir�. Se voc� repetir esse processo muitas vezes, voc�
/// veremos uma degrada��o substancial na qualidade da imagem.
///
/// Porque JPEG � um dos formatos de imagem mais populares na Web, e
/// como as pessoas geralmente gostam de modificar imagens JPEG, o GDI+ fornece o seguinte
/// transforma��es que podem ser realizadas em imagens JPEG sem perda de
/// Informa��o:
///
/// -Gira 90 graus
/// -Gira 180 graus
/// -Gira 270 graus
///  -Virar horizontalmente
/// -Virar verticalmente
///
/// Voc� pode aplicar uma das transforma��es mostradas na lista anterior quando
/// voc� chama o m�todo <A>Save</A> de um objeto <A>TGdipImage</A>. Se o seguinte
/// as condi��es s�o atendidas, ent�o a transforma��o prosseguir� sem perda de
/// Informa��o:
///
/// -O arquivo usado para construir o objeto <A>TGdipImage</A> � um arquivo JPEG.
/// -A largura e a altura da imagem s�o m�ltiplos de 16.
///
/// Se a largura e a altura da imagem n�o forem m�ltiplos de 16, o GDI+ ir�
/// fa�a o poss�vel para preservar a qualidade da imagem ao aplicar uma das rota��es
/// ou invertendo as transforma��es mostradas na lista anterior.
///
/// Para transformar uma imagem JPEG, inicialize um objeto <A>TGdipEncoderParameters</A>
/// e passe esse objeto para o m�todo <A>Save</A> do <A>TGdipImage</A>
///interface. Adicione um �nico par�metro ao <A>TGdipEncoderParameters</A> do tipo
/// EncoderTransformation e com um valor que cont�m um dos seguintes
/// elementos da enumera��o <A>TEncoderValue</A>:
///
/// -EncoderValueTransformRotate90,
/// -EncoderValueTransformRotate180,
/// -EncoderValueTransformRotate270,
/// -EncoderValueTransformFlipHorizontal,
/// -EncoderValueTransformFlipVertical
///
/// O exemplo a seguir cria um objeto <A>TGdipImage</A> a partir de um arquivo JPEG e
/// ent�o salva a imagem em um novo arquivo. Durante o processo de salvamento, a imagem �
/// girado 90 graus. Se a largura e a altura da imagem forem m�ltiplas
/// de 16, o processo de girar e salvar a imagem n�o causa perda de
/// Informa��o.

procedure TDemoTransformJpeg.Run;
var
  Image: TGdipImage;
  Width, Height: Integer;
  Params: TGdipEncoderParameters;
begin
  Image := TGdipImage.FromFile('..\..\imagens\ImageFile.jpg');
  Graphics.DrawImage(Image, 0, 0, Image.Width div 2, Image.Height div 2);
  Width := Image.Width;
  Height := Image.Height;

  TextOutput.Add(Format('A largura da imagem � %d,', [Width]));
  if ((Width mod 16) = 0) then
    TextOutput.Add('que � um m�ltiplo de 16.')
  else
    TextOutput.Add('que n�o � um m�ltiplo de 16.');

  TextOutput.Add(Format('A altura da imagem � %d,', [Height]));
  if ((Height mod 16) = 0) then
    TextOutput.Add('que � um m�ltiplo de 16.')
  else
    TextOutput.Add('que n�o � um m�ltiplo de 16.');

  Params := TGdipEncoderParameters.Create;
  Params.Add(TGdipEncoder.Transformation.Guid, TGdipEncoderValue.TransformRotate90);
  Image.Save('ImageFileR90.jpg', TGdipImageFormat.Jpeg, Params);
  Params.Free();
  Image.Free();

  // Recarregar imagem girada
  Image := TGdipImage.FromFile('ImageFileR90.jpg');
  Graphics.DrawImage(Image, 330, 0, Image.Width div 2, Image.Height div 2);
  Image.Free();
end;
{$ENDREGION}

initialization
  RegisterDemo('Usando codificadores e decodificadores de imagens\Transformando uma imagem JPEG sem perda de informa��es', TDemoTransformJpeg);

end.
