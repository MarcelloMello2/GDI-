unit uDemoGraphicsState;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoGraphicsState = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
    procedure Example3;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoGraphicsState }

{$REGION}
/// Um objeto <A>TGdipGraphics</A> fornece m�todos como <A>DrawLine</A>,
/// <A>DrawImage</A> e <A>DrawString</A> para exibir imagens vetoriais, raster
/// imagens e texto. Um objeto <A>TGdipGraphics</A> tamb�m possui diversas propriedades que
/// influenciar a qualidade e orienta��o dos itens desenhados. Para
/// exemplo, a propriedade do modo de suaviza��o determina se o antialiasing �
/// aplicado a linhas e curvas, e a propriedade de transforma��o mundial
/// influencia a posi��o e rota��o dos itens que s�o desenhados.
///
/// Um objeto <A>TGdipGraphics</A> � frequentemente associado a um display espec�fico
/// dispositivo. Quando voc� usa um objeto <A>TGdipGraphics</A> para desenhar em uma janela, o
/// O objeto <A>TGdipGraphics</A> tamb�m est� associado a essa janela espec�fica.
///
/// Um objeto <A>TGdipGraphics</A> pode ser considerado um cont�iner porque cont�m
/// um conjunto de propriedades que influenciam o desenho e est� vinculado a
/// informa��es espec�ficas do dispositivo. Voc� pode criar um cont�iner secund�rio dentro de um
/// objeto <A>TGdipGraphics</A> existente chamando o m�todo <A>BeginContainer</A>
/// desse objeto <A>TGdipGraphics</A>.
///
/// <H>Estado dos gr�ficos</H>
/// Um objeto <A>TGdipGraphics</A> faz mais do que fornecer m�todos de desenho, como
/// <A>DrawLine</A> e <A>DrawRectangle</A>. Um objeto <A>TGdipGraphics</A> tamb�m
/// mant�m o estado dos gr�ficos, que pode ser dividido nas seguintes categorias:
///
/// -Um link para um contexto de dispositivo
/// -Configura��es de qualidade
/// -Transforma��es
/// -Uma regi�o de recorte
///
/// <H>Contexto do dispositivo</H>
/// Como programador de aplicativos, voc� n�o precisa pensar na intera��o
/// entre um objeto <A>TGdipGraphics</A> e seu contexto de dispositivo. Esta intera��o
/// � tratado pelo GDI+ nos bastidores.
///
/// <H>Configura��es de qualidade</H>
/// Um objeto <A>TGdipGraphics</A> possui diversas propriedades que influenciam a qualidade
/// dos itens que s�o desenhados na tela. Voc� pode visualizar e manipular esses
/// propriedades chamando os m�todos get e set. Por exemplo, voc� pode definir o
/// Propriedade <A>TextRenderingHint</A> para especificar o tipo de antialiasing (se
/// qualquer) aplicado ao texto. Outras propriedades definidas que influenciam a qualidade s�o
/// <A>SmoothingMode</A>, <A>CompositingMode</A>, <A>CompositingQuality</A> e
/// <A>ModoInterpola��o</A>.
///
/// O exemplo a seguir desenha duas elipses, uma com o modo de suaviza��o definido como
/// <A>SmoothingModeAntiAlias</A> e um com o modo de suaviza��o definido como
/// <A>SmoothingModeHighSpeed</A>.

procedure TDemoGraphicsState.Example1;
var
  Pen: TGdipPen;
begin
  Pen := TGdipPen.Create(TGdipColor.Lime, 3);
  Graphics.SmoothingMode := TGdipSmoothingMode.AntiAlias8x4;
  Graphics.DrawEllipse(Pen, 0, 0, 200, 100);
  Graphics.SmoothingMode := TGdipSmoothingMode.HighSpeed;
  Graphics.DrawEllipse(Pen, 0, 150, 200, 100);

  Pen.Free();
end;

/// As retic�ncias verdes na ilustra��o acima mostram o resultado.
///
/// <H>Transforma��es</H>
/// Um objeto <A>TGdipGraphics</A> mant�m duas transforma��es (mundo e p�gina)
/// que s�o aplicados a todos os itens desenhados por esse objeto <A>TGdipGraphics</A>. Qualquer
/// transforma��o afim pode ser armazenada na transforma��o mundial. Afim
/// as transforma��es incluem dimensionamento, rota��o, reflex�o, inclina��o e
/// traduzindo. A transforma��o da p�gina pode ser usada para dimensionamento e para
/// alterando unidades (por exemplo, pixels para polegadas). Para mais informa��es sobre
/// transforma��es, consulte Sistemas de Coordenadas e Transforma��es no
/// Plataforma SDK.
///
/// O exemplo a seguir define as transforma��es de mundo e de p�gina de um
/// Objeto <A>TGdipGraphics</A>. A transforma��o mundial est� definida para um ritmo de 30 graus
/// rota��o. A transforma��o da p�gina � definida de forma que as coordenadas passadas para
/// o segundo <A>DrawEllipse</A> ser� tratado como mil�metros em vez de
/// p�xeis. O c�digo faz duas chamadas id�nticas ao m�todo <A>DrawEllipse</A>.
/// A transforma��o mundial � aplicada � primeira chamada <A>DrawEllipse</A>,
/// e ambas as transforma��es (mundo e p�gina) s�o aplicadas ao segundo
/// Chamada <A>DrawEllipse</A>.

procedure TDemoGraphicsState.Example2;
var
  Pen: TGdipPen;
begin
  Pen := TGdipPen.Create(TGdipColor.Red);

  Graphics.ResetTransform;
  Graphics.RotateTransform(30);             // Transforma��o de mundial
  Graphics.DrawEllipse(Pen, 30, 0, 50, 25);
  Graphics.PageUnit := TGdipGraphicsUnit.Millimeter;      //Transforma��o de p�gina
  Graphics.DrawEllipse(Pen, 30, 0, 50, 25);

  Pen.Free();
end;

/// As retic�ncias vermelhas na ilustra��o acima mostram o resultado. Observe que o
/// A rota��o de 30 graus � sobre a origem do sistema de coordenadas (canto superior esquerdo
/// canto da �rea do cliente), n�o sobre os centros das elipses. Observe tamb�m
/// que a largura da caneta de 1 significa 1 pixel para a primeira elipse e 1 mil�metro
/// para a segunda elipse.
///
/// <H>Regi�o de recorte</H>
/// Um objeto <A>TGdipGraphics</A> mant�m uma regi�o de recorte que se aplica a todos
/// itens desenhados por esse objeto <A>TGdipGraphics</A>. Voc� pode definir a regi�o de recorte
/// chamando o m�todo <A>SetClip</A> ou definindo a propriedade <A>Clip</A>.
///
/// O exemplo a seguir cria uma regi�o em formato de mais formando a uni�o de
/// dois ret�ngulos. Essa regi�o � designada como regi�o de recorte de um
/// Objeto <A>TGdipGraphics</A>. Ent�o o c�digo desenha duas linhas que s�o restritas
/// para o interior da regi�o de recorte.

procedure TDemoGraphicsState.Example3;
var
  Pen: TGdipPen;
  Brush: TGdipBrush;
  Region: TGdipRegion;
begin
  Pen := TGdipPen.Create(TGdipColor.Red, 5);
  Brush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 180, 255, 255));

  // Crie uma regi�o em formato de positivo formando a uni�o de dois ret�ngulos.
  Region := TGdipRegion.Create(TRectangle.Create(300, 0, 50, 150));
  Region.Union(TRectangle.Create(250, 50, 150, 50));
  Graphics.FillRegion(Brush, Region);

  //Defina a regi�o de recorte.
  Graphics.Clip := Region;

  // Desenhe duas linhas recortadas.
  Graphics.DrawLine(Pen, 250, 30, 400, 160);
  Graphics.DrawLine(Pen, 290, 20, 440, 150);

  Region.Free();
  Brush.Free();
  Pen.Free();
end;
{$ENDREGION}

procedure TDemoGraphicsState.Run;
begin
  Example1;
  Example2;
  Graphics.PageUnit := TGdipGraphicsUnit.Pixel;
  Graphics.ResetTransform();
  Example3;
end;

initialization
  RegisterDemo('Usando cont�ineres gr�ficos\O estado de um objeto gr�fico', TDemoGraphicsState);

end.
