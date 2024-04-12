unit uDemoGetEncoderClsid;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoGetEncoderClsid = class(TDemo)
  strict private
    function GetEncoderClsid(const MimeType: String; out ClsId: TGUID): Integer;
    procedure GetPngClsId;
    procedure GetJpegClsId;
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoGetEncoderClsid }

{$REGION}
/// A fun��o GetEncoderClsid no exemplo a seguir recebe o tipo MIME
/// de um codificador e retorna o identificador de classe (CLSID) desse codificador. O
/// Os tipos MIME dos codificadores integrados ao Microsoft Windows GDI+ s�o os seguintes:
///
/// -imagem/bmp
/// -imagem/jpeg
/// -imagem/gif
/// -imagem/tiff
/// -imagem/png
///
/// A fun��o chama <A>TGdipImageCodecInfo.GetImageEncoders</A> para obter um array
/// de objetos <A>TGdipImageCodecInfo</A>. Se um dos <A>TGdipImageCodecInfo</A>
/// objetos nesse array representam o codificador solicitado, a fun��o retorna
/// o �ndice do objeto <A>TGdipImageCodecInfo</A> e copia o CLSID no
/// Par�metro ClsId. Se a fun��o falhar, ela retornar� �1.

function TDemoGetEncoderClsid.GetEncoderClsid(const MimeType: String; out ClsId: TGUID): Integer;
var
  Encoders: TArray<TGdipImageCodecInfo>;
begin
  Encoders := TGdipImageCodecInfo.GetImageEncoders;
  for Result := 0 to Length(Encoders) - 1 do
    if SameText(Encoders[Result].MimeType, MimeType) then
    begin
      ClsId := Encoders[Result].ClsId;
      Exit;
    end;
  Result := -1;
end;

/// O exemplo a seguir chama a fun��o GetEncoderClsid para determinar o
/// CLSID do codificador PNG:

procedure TDemoGetEncoderClsid.GetPngClsId;
var
  Index: Integer;
  ClsId: TGUID;
begin
  Index := GetEncoderClsid('image/png', ClsId);
  if (Index < 0) then
    TextOutput.Add('O codificador PNG n�o est� instalado.')
  else
  begin
    TextOutput.Add('Um objeto TGdipImageCodecInfo que representa o codificador PNG');
    TextOutput.Add(Format('foi encontrado na posi��o %d na matriz.', [Index]));
    TextOutput.Add(Format('O CLSID do codificador PNG � %s.', [GUIDToString(ClsId)]));
  end;
end;

/// Quando voc� precisar de informa��es sobre um dos codificadores ou decodificadores integrados,
/// existe uma maneira mais f�cil que n�o requer uma fun��o como GetEncoderClsId.
/// A classe <A>TGdipImageFormat</A> possui algumas propriedades de classe chamadas <A>Bmp</A>,
/// <A>Jpeg</A>, <A>Gif</A>, <A>Tiff</A> e <A>Png</A> que retornam um
/// Objeto <A>IImageFormat</A> que cont�m uma propriedade CodecId.

procedure TDemoGetEncoderClsid.GetJpegClsId;
begin
  TextOutput.Add(Format('O CLSID do codificador JPEG � %s.',
    [GUIDToString(TGdipImageFormat.Jpeg.Guid)]));
end;
{$ENDREGION}

class function TDemoGetEncoderClsid.Outputs: TDemoOutputs;
begin
  Result := [doText];
end;

procedure TDemoGetEncoderClsid.Run;
var
  ClsId: TGUID;
begin
  GetEncoderClsid('image/bmp', ClsId);
  GetPngClsid;
  TextOutput.Add('');
  GetJpegClsId;
end;

initialization
  RegisterDemo('Usando codificadores e decodificadores de imagens\Recuperando o identificador de classe para um codificador', TDemoGetEncoderClsid);

end.
