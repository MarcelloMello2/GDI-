// Marcelo Melo
// 12/04/2024
//
// https://learn.microsoft.com/pt-br/windows/win32/gdiplus/-gdiplus-determining-the-parameters-supported-by-an-encoder-use

unit uDemoEncoderParameters;

interface

uses
   Se7e.Drawing,
   Se7e.Windows.Win32.Graphics.GdiplusAPI,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoEncoderParameters = class(TDemo)
  strict private
    function GetJpegParameters: TGdipEncoderParameters;
    procedure ShowSecondJpegParameter(const Params: TGdipEncoderParameters);
    procedure ShowJpegQualityParameter(const Params: TGdipEncoderParameters);
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

uses
  SysUtils;

{ TDemoEncoderParameters }

{$REGION}
/// A interface <A>TGdipImage</A> fornece o <A>GetEncoderParameterList</A>
/// m�todo para que voc� possa determinar os par�metros que s�o suportados por um
/// determinado codificador de imagem. O m�todo <A>GetEncoderParameterList</A> retorna um
/// array de registros <A>TEncoderParameter</A>.
///
/// O exemplo a seguir obt�m a lista de par�metros para o codificador JPEG.
/// Utiliza a propriedade de classe TGdipImageFormat.Jpeg para obter o ClsId do
/// Codificador JPEG.

function TDemoEncoderParameters.GetJpegParameters: TGdipEncoderParameters;
var
  Bitmap: TGdipBitmap;
begin
  // Cria a interface TGdipBitmap (herdada de TGdipImage) para que possamos chamar
  //GetEncoderParameterList.
  Bitmap := TGdipBitmap.Create(1, 1);

  // Obtenha a lista de par�metros do codificador JPEG.
  Result := Bitmap.GetEncoderParameterList(TGdipImageFormat.Jpeg.CodecId);

  TextOutput.Add(Format('Existem %d registros TEncoderParameter na matriz.',
    [Result.Count]));

  Bitmap.Free();
end;

/// Cada um dos registros <A>TEncoderParameter</A> no array tem o seguinte
/// quatro membros de dados p�blicos:
///
/// -Guid (TGUID): GUID do par�metro
/// -NumberOfValues (LongWord): N�mero dos valores dos par�metros
/// -ValueType (TGdipEncoderParameterValueType): Tipo de valor, como ValueTypeLONG etc.
/// -Value (Pointer): Um ponteiro para os valores dos par�metros
///
/// O exemplo a seguir � uma continua��o do exemplo anterior. O c�digo
/// olha para o segundo registro <A>TEncoderParameter</A> no array retornado por
/// <A>GetEncoderParameterList</A>.

procedure TDemoEncoderParameters.ShowSecondJpegParameter(const Params: TGdipEncoderParameters);
var
  Param: TGdiplusAPI.TGdipNativeEncoderParameterPtr;
begin
  Assert(Params.Count >= 2);
  Param := Params[1];
  TextOutput.Add('Parameter[1]');
  TextOutput.Add(Format('  O GUID � %s.', [GUIDToString(Param.Guid)]));
  TextOutput.Add(Format('  O tipo de valor � %d.', [Ord(Param.ValueType)]));
  TextOutput.Add(Format('  O n�mero de valores � %d.', [Param.NumberOfValues]));
end;

/// O c�digo anterior deve gerar o seguinte:
///
/// Par�metro[1]
/// O GUID � {1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}.
/// O tipo de valor � 6.
/// O n�mero de valores � 1.
///
/// Voc� pode procurar o GUID em GdiPlus.pas e descobrir que a categoria de
/// este registro <A>TEncoderParameter</A> � EncoderQuality. Voc� pode usar isso
/// categoria (EncoderQuality) do par�metro para definir o n�vel de compacta��o de um
/// imagem JPEG.
///
/// A enumera��o <A>TGdipEncoderParameterValueType</A> indica que o tipo de dados 6
/// � EncoderParameterValueTypeLongRange. Um longo alcance � um par de LongInt
/// valores.
///
/// O n�mero de valores � um, ent�o sabemos que o membro Value do
/// O registro <A>TEncoderParameter</A> � um ponteiro para um array que possui um
/// elemento. Esse elemento � um par de valores LongWord.
///
/// O exemplo a seguir � uma continua��o dos dois exemplos anteriores. O
/// c�digo define um tipo de dados chamado PLongRange (ponteiro para um longo intervalo). A
/// vari�vel do tipo PLongRange � usada para extrair o m�nimo e o m�ximo
/// valores que podem ser passados como configura��o de qualidade para o codificador JPEG.

procedure TDemoEncoderParameters.ShowJpegQualityParameter(const Params: TGdipEncoderParameters);
type
  TLongRange = record
    Min: LongInt;
    Max: LongInt;
  end;
  PLongRange = ^TLongRange;
var
  Param: TGdiplusAPI.TGdipNativeEncoderParameterPtr;
  LongRange: PLongRange;
begin
  Assert(Params.Count >= 2);
  Param := Params[1];
  LongRange := Param.Value;
  TextOutput.Add(Format('  O valor m�nimo de qualidade poss�vel � %d.', [LongRange.Min]));
  TextOutput.Add(Format('  O valor de qualidade m�ximo poss�vel � %d.', [LongRange.Max]));
end;

/// O c�digo anterior deve produzir a seguinte sa�da:
///
/// O valor m�nimo de qualidade poss�vel � 0.
/// O valor m�ximo de qualidade poss�vel � 100.
///
/// No exemplo anterior, o valor retornado em <A>TEncoderParameter</A>
/// registro � um par de valores LongInt que indicam o m�nimo e o m�ximo
/// valores poss�veis para o par�metro de qualidade. Em alguns casos, os valores
/// retornados em um registro <A>TEncoderParameter</A> s�o membros do
/// enumera��o <A>TEncoderValue</A>. Os exemplos a seguir discutem o
/// Enumera��o <A>TEncoderValue</A> e m�todos para listar poss�veis par�metros
/// valores com mais detalhes:
///
/// -<A>Usando a enumera��o TEncoderValue</A>
/// -<A>Listando par�metros e valores para todos os codificadores</A>
{$ENDREGION}

class function TDemoEncoderParameters.Outputs: TDemoOutputs;
begin
  Result := [doText];
end;

procedure TDemoEncoderParameters.Run;
var
  Params: TGdipEncoderParameters;
begin
  Params := GetJpegParameters();
  TextOutput.Add('');
  ShowSecondJpegParameter(Params);
  TextOutput.Add('');
  ShowJpegQualityParameter(Params);

  Params.Free();
end;

initialization
  RegisterDemo('Usando codificadores e decodificadores de imagens\Par�metros do codificador\Determinando os par�metros suportados por um codificador', TDemoEncoderParameters);

end.
