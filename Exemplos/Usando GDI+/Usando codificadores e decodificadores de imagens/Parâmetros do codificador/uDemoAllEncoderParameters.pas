// Marcelo Melo
// 12/04/2024
//
// https://learn.microsoft.com/pt-br/windows/win32/gdiplus/-gdiplus-listing-parameters-and-values-for-all-encoders-use

unit uDemoAllEncoderParameters;

interface

uses
   Se7e.Drawing,
   Se7e.Windows.Win32.Graphics.GdiplusAPI,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoAllEncoderParameters = class(TDemo)
  strict private
    procedure ShowEncoders;
    procedure ShowAllEncoderParameters(const Encoder: TGdipImageCodecInfo);
    function EncoderParameterCategoryFromGuid(const Guid: TGuid): String;
    function ValueTypeToString(const ValueType: TGdiplusAPI.TGdipNativeEncoderParameterValueType): String;
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoAllEncoderParameters }

class function TDemoAllEncoderParameters.Outputs: TDemoOutputs;
begin
  Result := [doText];
end;

{$REGION}
/// O exemplo a seguir lista todos os par�metros suportados pelos v�rios
/// codificadores instalados no computador. As principais chamadas de m�todo
/// <A>TGdipImageCodecInfo.GetImageEncoders</A> para descobrir quais codificadores s�o
/// dispon�vel. Para cada codificador dispon�vel, o m�todo principal chama o auxiliar
/// m�todo ShowAllEncoderParameters.

procedure TDemoAllEncoderParameters.ShowEncoders;
var
   Encoder: TGdipImageCodecInfo;
begin
   var Encoders := TGdipImageCodecInfo.GetImageEncoders();
   for Encoder in Encoders do
      ShowAllEncoderParameters(Encoder);
end;

/// O m�todo ShowAllEncoderParameters chama o
/// M�todo <A>TGdipImage.GetEncoderParameterList</A> para descobrir quais par�metros
/// s�o suportados por um determinado codificador. Para cada par�metro suportado, a fun��o
/// lista a categoria, o tipo de dados e o n�mero de valores. O
/// A fun��o ShowAllEncoderParameters depende de duas fun��es auxiliares:
/// EncoderParameterCategoryFromGuid e ValueTypeToString.

procedure TDemoAllEncoderParameters.ShowAllEncoderParameters(const Encoder: TGdipImageCodecInfo);
var
  Bitmap: TGdipBitmap;
  Params: TGdipEncoderParameters;
  Param: TGdiplusAPI.TGdipNativeEncoderParameterPtr;
  {$POINTERMATH ON} // Permitir acesso a Valores como um array
  Values: PLongWord;
  J, K: Integer;
begin
  TextOutput.Add(Encoder.MimeType);

  // Cria a interface TGdipBitmap (herdada de TGdipImage) para que possamos chamar
  //GetEncoderParameterList.
  Bitmap := TGdipBitmap.Create(1, 1);

  // Obtenha a lista de par�metros do codificador.
  Params := Bitmap.GetEncoderParameterList(Encoder.Clsid);
  TextOutput.Add(Format('  Existem %d registros TEncoderParameter na matriz.',
    [Params.Count]));

  for K := 0 to Params.Count - 1 do
  begin
    Param := Params[K];
    TextOutput.Add(Format('    Parameter[%d]', [K]));
    TextOutput.Add(Format('      A categoria � %s.',
      [EncoderParameterCategoryFromGuid(Param.Guid)]));
    TextOutput.Add(Format('      O tipo de dados � %s.',
      [ValueTypeToString(Param.ValueType)]));
    TextOutput.Add(Format('      O n�mero de valores � %d.',
      [Param.NumberOfValues]));

    if IsEqualGuid(Param.Guid, TGdipEncoder.ColorDepth.Guid) then
    begin
      TextOutput.Add('      Os valores permitidos para ColorDepth s�o');
      Values := Param.Value;
      for J := 0 to Param.NumberOfValues - 1 do
        TextOutput.Add('        ' + IntToStr(Values[J]));
    end;
  end;

  TextOutput.Add('');

  Params.Free();
  Bitmap.Free();
end;

function TDemoAllEncoderParameters.ValueTypeToString(const ValueType: TGdiplusAPI.TGdipNativeEncoderParameterValueType): String;
const
  ValueTypes: array [TGdiplusAPI.TGdipNativeEncoderParameterValueType] of String = (
    'Byte', 'ASCII', 'Short', 'Long', 'Rational', 'LongRange', 'Undefined',
    'RationalRange', 'Pointer');
begin
  Result := ValueTypes[ValueType];
end;

function TDemoAllEncoderParameters.EncoderParameterCategoryFromGuid(
  const Guid: TGuid): String;
begin
  if IsEqualGUID(Guid, TGdipEncoder.Compression.Guid) then
    Result := 'Compression'
  else if IsEqualGUID(Guid, TGdipEncoder.ColorDepth.Guid) then
    Result := 'ColorDepth'
  else if IsEqualGUID(Guid, TGdipEncoder.ScanMethod.Guid) then
    Result := 'ScanMethod'
  else if IsEqualGUID(Guid, TGdipEncoder.Version.Guid) then
    Result := 'Version'
  else if IsEqualGUID(Guid, TGdipEncoder.RenderMethod.Guid) then
    Result := 'RenderMethod'
  else if IsEqualGUID(Guid, TGdipEncoder.Quality.Guid) then
    Result := 'Quality'
  else if IsEqualGUID(Guid, TGdipEncoder.Transformation.Guid) then
    Result := 'Transformation'
  else if IsEqualGUID(Guid, TGdipEncoder.LuminanceTable.Guid) then
    Result := 'LuminanceTable'
  else if IsEqualGUID(Guid, TGdipEncoder.ChrominanceTable.Guid) then
    Result := 'ChrominanceTable'
  else if IsEqualGUID(Guid, TGdipEncoder.SaveFlag.Guid) then
    Result := 'SaveFlag'
  else
    Result := GUIDToString(Guid);
end;

/// Voc� pode tirar as seguintes conclus�es examinando a sa�da do programa anterior:
///
/// -O codificador JPEG suporta Transformation, Quality, LuminanceTable e
/// Categorias de par�metros ChrominanceTable.
/// -O codificador TIFF suporta Compression, ColorDepth e SaveFlag
/// categorias de par�metros.
///
/// Voc� tamb�m pode ver o n�mero de valores aceit�veis para cada par�metro
/// categoria. Por exemplo, voc� pode ver que a categoria do par�metro ColorDepth
/// (codec TIFF) possui cinco valores do tipo LongWord. O c�digo acima lista aqueles
/// cinco valores (1, 4, 8, 24 e 32).
///
/// <B>Nota</B> Em alguns casos, os valores em um registro <A>TEncoderParameter</A>
/// s�o os valores num�ricos dos elementos da enumera��o <A>TEncoderValue</A>.
/// No entanto, os n�meros na lista anterior n�o se relacionam com o
/// enumera��o <A>TEncoderValue</A>. Os n�meros significam 1 bit por pixel, 2 bits
/// por pixel e assim por diante. Se voc� escrever um c�digo semelhante ao exemplo anterior para
/// investigue os valores permitidos para as outras categorias de par�metros, voc�
/// obter� um resultado semelhante ao seguinte.
///
/// -Transforma��o do par�metro do codificador JPEG, Valores permitidos:
/// EncoderValueTransformRotate90, EncoderValueTransformRotate180,
/// EncoderValueTransformRotate270, EncoderValueTransformFlipHorizontal,
/// EncoderValueTransformFlipVertical
/// - Par�metro do codificador JPEG Qualidade, Valores permitidos: 0 a 100
/// - Compress�o do par�metro do codificador TIFF, Valores permitidos:
/// EncoderValueCompressionLZW, EncoderValueCompressionCCITT3,
/// EncoderValueCompressionCCITT4, EncoderValueCompressionRle,
/// EncoderValueCompressionNone
/// Par�metro do codificador -TIFF ColorDepth, Valores permitidos: 1, 4, 8, 24, 32
/// Par�metro do codificador -TIFF SaveFlag, Valores permitidos: EncoderValueMultiFrame
///
/// <B>Nota</B> Se a largura e a altura de uma imagem JPEG forem m�ltiplos de 16, voc�
/// pode aplicar qualquer uma das transforma��es permitidas pelo EncoderTransformation
/// categoria de par�metro (por exemplo, rota��o de 90 graus) sem perda de
/// Informa��o.
{$ENDREGION}

procedure TDemoAllEncoderParameters.Run;
begin
   ShowEncoders();
end;

initialization
   RegisterDemo('Usando codificadores e decodificadores de imagens\Par�metros do codificador\Listando par�metros e valores para todos os codificadores', TDemoAllEncoderParameters);

end.
