unit uDemoCreateMultiFrame;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoCreateMultiFrame = class(TDemo)
  strict protected
    procedure Run; override;
  public
    class function Outputs: TDemoOutputs; override;
  end;

implementation

{ TDemoCreateMultiFrame }

class function TDemoCreateMultiFrame.Outputs: TDemoOutputs;
begin
  Result := [doGraphic, doText];
end;

{$REGION}
/// Com certos formatos de arquivo, voc� pode salvar m�ltiplas imagens (quadros) em um �nico
/// arquivo. Por exemplo, voc� pode salvar diversas p�ginas em um �nico arquivo TIFF. Salvar
/// na primeira p�gina, chame o m�todo <A>Save</A> da interface <A>TGdipImage<A>.
/// Para salvar p�ginas subsequentes, chame o m�todo <A>SaveAdd</A> do
/// Interface <A>TGdipImage</A>.
///
/// O exemplo a seguir cria um arquivo TIFF com quatro p�ginas. As imagens que
/// tornam as p�ginas do arquivo TIFF provenientes de quatro arquivos de disco. O c�digo primeiro
/// constr�i quatro objetos <A>TGdipImage</A>: Multi, Page2, Page3 e Page4. No
/// primeiro, Multi cont�m apenas a imagem de Shapes.bmp, mas eventualmente
/// cont�m todas as quatro imagens. � medida que as p�ginas individuais s�o adicionadas ao multi
/// objeto <A>TGdipImage</A>, eles tamb�m s�o adicionados ao arquivo de disco MultiFrame.tif.
///
/// Observe que o c�digo chama <A>Save</A> (n�o <A>SaveAdd</A>) para salvar o primeiro
/// p�gina. O primeiro argumento passado para o m�todo <A>Save</A> � o nome do
/// arquivo em disco que eventualmente conter� v�rios quadros. O segundo argumento
/// passado para o m�todo <A>Save</A> especifica o codificador que ser� usado para
/// converte os dados no objeto multi <A>TGdipImage</A> para o formato (neste
/// case TIFF) exigido pelo arquivo do disco. Esse mesmo codificador � usado
/// automaticamente por todas as chamadas subseq�entes ao m�todo <A>SaveAdd</A> do
/// objeto m�ltiplo <A>TGdipImage<A>.
///
/// O terceiro argumento passado para o m�todo <A>Save</A> � um
/// objeto <A>TGdipEncoderParameters</A>. O objeto <A>TGdipEncoderParameters<A> tem
/// um �nico par�metro do tipo EncoderSaveFlag. O valor do par�metro
/// � EncoderValueMultiFrame.
///
/// O c�digo salva a segunda, terceira e quarta p�ginas chamando o m�todo
/// M�todo <A>SaveAdd</A> do objeto multi <A>TGdipImage<A>. O primeiro argumento
/// passado para o m�todo <A>SaveAdd<A/> � um objeto <A>TGdipImage</A>. A imagem em
/// esse objeto <A>TGdipImage</A> � adicionado ao objeto multi <A>TGdipImage</A> e �
/// tamb�m adicionado ao arquivo de disco MultiFrame.tif. O segundo argumento passado para
/// o m�todo <A>SaveAdd</A> � o mesmo objeto <A>TGdipEncoderParameters</A> que
/// foi usado pelo m�todo <A>Save</A>. A diferen�a � que o valor do
/// par�metro agora � EncoderValueFrameDimensionPage.

procedure TDemoCreateMultiFrame.Run;
var
  Params: TGdipEncoderParameters;
  Multi, Page2, Page3, Page4: TGdipImage;
  X, I, PageCount: Integer;
begin
  Params := TGdipEncoderParameters.Create();
  Multi := TGdipImage.FromFile('..\..\imagens\Shapes.bmp');
  Page2 := TGdipImage.FromFile('..\..\imagens\Cereal.gif');
  Page3 := TGdipImage.FromFile('..\..\imagens\Iron.jpg');
  Page4 := TGdipImage.FromFile('..\..\imagens\House.png');

  // Salve a primeira p�gina (quadro).
  Params.Add(TGdipEncoder.SaveFlag.Guid, TGdipEncoderValue.MultiFrame);
  Multi.Save('MultiFrame.tif', TGdipImageFormat.Tiff, Params);
  TextOutput.Add('P�gina 1 salva com sucesso');

  // Salve a segunda p�gina (quadro).
  Params.Clear();
  Params.Add(TGdipEncoder.SaveFlag.Guid, TGdipEncoderValue.FrameDimensionPage);
  Multi.SaveAdd(Page2, Params);
  TextOutput.Add('P�gina 2 salva com sucesso');

  // Salve a terceira p�gina (quadro).
  Multi.SaveAdd(Page3, Params);
  TextOutput.Add('P�gina 3 salva com sucesso');

  // Salve a quarta p�gina (quadro).
  Multi.SaveAdd(Page4, Params);
  TextOutput.Add('P�gina 4 salva com sucesso');

  // Feche o arquivo multiframe.
  Params.Clear();
  Params.Add(TGdipEncoder.SaveFlag.Guid, TGdipEncoderValue.Flush);
  Multi.SaveAdd(Params);
  TextOutput.Add('Arquivo fechado com sucesso');
  Multi.Free();

  // Recarregue o arquivo TIFF
  Multi := TGdipImage.FromFile('MultiFrame.tif');
  PageCount := Multi.GetFrameCount(TGdipFrameDimension.Page);
  X := 0;
  for I := 0 to PageCount - 1 do
  begin
    Multi.SelectActiveFrame(TGdipFrameDimension.Page, I);
    Graphics.DrawImage(Multi, X, 0, Multi.Width, Multi.Height);
    Inc(X, Multi.Width + 10);
  end;

  Page4.Free();
  Page3.Free();
  Page2.Free();
  Multi.Free();
  Params.Free();
end;

/// A �ltima se��o do c�digo recupera os quadros individuais de um
/// arquivo TIFF de v�rios quadros. Quando o arquivo TIFF foi criado, o indiv�duo
/// frames foram adicionados � dimens�o Page. O c�digo exibe cada um dos quatro
/// P�ginas.
///
/// O c�digo constr�i um objeto <A>TGdipImage</A> a partir do TIFF de v�rios quadros
/// arquivo. Para recuperar os quadros individuais (p�ginas), o c�digo chama o m�todo
/// M�todo <A>SelectActiveFrame</A> desse objeto </A>TGdipImage</A>. O primeiro
/// argumento passado para o m�todo <A>SelectActiveFrame</A> � um GUID que
/// especifica a dimens�o na qual os quadros foram adicionados anteriormente ao
/// arquivo TIFF de v�rios quadros. O GUID FrameDimensionPage � usado aqui. Outro
/// GUIDs que voc� pode usar s�o FrameDimensionTime e FrameDimensionResolution. O
/// segundo argumento passado para o m�todo <A>SelectActiveFrame</A> � o
/// �ndice baseado em zero da p�gina desejada.
{$ENDREGION}

initialization
  RegisterDemo('Usando codificadores e decodificadores de imagens\Criando e salvando uma imagem de v�rios quadros', TDemoCreateMultiFrame);

end.
