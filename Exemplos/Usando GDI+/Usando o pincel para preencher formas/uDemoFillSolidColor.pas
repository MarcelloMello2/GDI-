unit uDemoFillSolidColor;

interface

uses
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoFillSolidColor = class(TDemo)
  strict protected
    procedure Run; override;
  end;

implementation

{$REGION}
/// Um objeto GDI+Brush do Microsoft Windows � usado para preencher o interior de uma
/// forma fechada. O GDI+ define v�rios estilos de preenchimento: cor s�lida, padr�o de hachura,
/// textura de imagem e gradiente de cor.
///
/// Para preencher uma forma com uma cor s�lida, crie um objeto <A>TGdipSolidBrush</A>, e
/// ent�o use esse objeto <A>TGdipSolidBrush</A> como argumento em um dos m�todos de preenchimento
/// da interface <A>TGdipGraphics</A>. O exemplo a seguir mostra como
/// preencher uma elipse com a cor vermelha:

procedure TDemoFillSolidColor.Run;
var
  SolidBrush: TGdipSolidBrush;
begin
  SolidBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 255, 0, 0));
  Graphics.FillEllipse(SolidBrush, 0, 0, 100, 60);
  SolidBrush.Free();
end;

/// No exemplo anterior, o construtor <A>TGdipSolidBrush</A> recebe uma refer�ncia
/// de registro <A>TGdipColor</A> como seu �nico argumento. Os valores usados pelo
/// construtor <A>TGdipColor</A> representam os componentes alfa, vermelho, verde e azul
/// da cor. Cada um desses valores deve estar na faixa de 0 a 255. O primeiro 255 indica que a cor � totalmente opaca, e o segundo
/// 255 indica que o componente vermelho est� com intensidade total. Os dois zeros
/// indicam que os componentes verde e azul t�m uma intensidade de 0.
///
/// Os quatro n�meros (0, 0, 100, 60) passados para o m�todo <A>FillEllipse</A>
/// especificam a localiza��o e o tamanho do ret�ngulo delimitador para a elipse. O
/// ret�ngulo tem um canto superior esquerdo de (0, 0), uma largura de 100 e uma altura
/// de 60.
{$ENDREGION}

initialization
  RegisterDemo('Usando o pincel para preencher formas\Preenchendo uma forma com uma cor s�lida', TDemoFillSolidColor);

end.
