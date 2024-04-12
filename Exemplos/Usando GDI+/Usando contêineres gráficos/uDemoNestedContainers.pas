unit uDemoNestedContainers;

interface

uses
   Types,
   Se7e.Drawing,
   Se7e.Drawing.Gdiplus.Types,
   uDemo;

type
  TDemoNestedContainers = class(TDemo)
  strict private
    procedure Example1;
    procedure Example2;
    procedure Example3;
  strict protected
    procedure Run; override;
  end;

implementation

{ TDemoNestedContainers }

{$REGION}
/// O Microsoft Windows GDI+ fornece cont�ineres que voc� pode usar para temporariamente
/// substitui ou aumenta parte do estado em um objeto <A>TGdipGraphics</A>. Voc�
/// cria um cont�iner chamando o m�todo <A>BeginContainer</A> de um
/// Objeto <A>TGdipGraphics</A>. Voc� pode chamar <A>BeginContainer</A> repetidamente para
/// forma cont�ineres aninhados.
///
/// <H>Transforma��es em cont�ineres aninhados</H>
/// O exemplo a seguir cria um objeto <A>TGdipGraphics</A> e um cont�iner
/// dentro desse objeto <A>TGdipGraphics</A>. A transforma��o mundial do
/// O objeto <A>TGdipGraphics</A> � uma transla��o de 100 unidades na dire��o x e 80
/// unidades na dire��o y. A transforma��o mundial do cont�iner � uma
/// rota��o de 30 graus. O c�digo faz a chamada
///
/// <C>DrawRectangle(Caneta, -60, -30, 120, 60)</C>
///
/// duas vezes. A primeira chamada para <A>DrawRectangle</A> est� dentro do cont�iner; que
/// � que a chamada est� entre as chamadas para <A>BeginContainer</A> e
/// <A>EndContainer</A>. A segunda chamada para <A>DrawRectangle</A> � ap�s o
/// chamada para <A>EndContainer</A>.

procedure TDemoNestedContainers.Example1;
var
   Pen: TGdipPen;
   Container: TGdipGraphicsContainer;
begin
   Pen := TGdipPen.Create(TGdipColor.Red);
   Graphics.TranslateTransform(100, 80);

   Container := Graphics.BeginContainer();
   Graphics.RotateTransform(30);
   Graphics.DrawRectangle(Pen, -60, -30, 120, 60);
   Graphics.EndContainer(Container);

   Graphics.DrawRectangle(Pen, -60, -30, 120, 60);

   Pen.Free();
end;

/// No c�digo anterior, o ret�ngulo desenhado de dentro do cont�iner �
/// transformado primeiro pela transforma��o mundial do cont�iner (rota��o)
/// e depois pela transforma��o mundial do objeto <A>TGdipGraphics</A>
/// (tradu��o). O ret�ngulo desenhado de fora do cont�iner � transformado
/// somente pela transforma��o mundial do objeto <A>TGdipGraphics</A>
/// (tradu��o). A ilustra��o superior esquerda acima mostra os dois ret�ngulos.
///
/// <H>Recorte em cont�ineres aninhados</H>
/// O exemplo a seguir ilustra como os cont�ineres aninhados lidam com o recorte
/// regi�es. O c�digo cria um cont�iner dentro de um objeto <A>TGdipGraphics</A>. O
/// regi�o de recorte do objeto <A>TGdipGraphics</A> � um ret�ngulo, e o
/// a regi�o de recorte do cont�iner � uma elipse. O c�digo faz duas chamadas para
/// o m�todo <A>DrawLine</A>. A primeira chamada para <A>DrawLine</A> est� dentro do
/// container, e a segunda chamada para <A>DrawLine</A> est� fora do container
/// (ap�s a chamada para <A>EndContainer</A>). A primeira linha � cortada pelo
/// interse��o das duas regi�es de recorte. A segunda linha � cortada apenas por
/// a regi�o de recorte retangular do objeto <A>TGdipGraphics</A>.

procedure TDemoNestedContainers.Example2;
var
   Container: TGdipGraphicsContainer;
   RedPen, BluePen: TGdipPen;
   AquaBrush, GreenBrush: TGdipBrush;
   Path: TGdipGraphicsPath;
   Region: TGdipRegion;
begin
   RedPen := TGdipPen.Create(TGdipColor.Red, 2);
   BluePen := TGdipPen.Create(TGdipColor.Blue, 2);
   AquaBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 180, 255, 255));
   GreenBrush := TGdipSolidBrush.Create(TGdipColor.FromArgb(255, 150, 250, 130));

   Graphics.SetClip(TRectangle.Create(250, 65, 150, 120));
   Graphics.FillRectangle(AquaBrush, 250, 65, 150, 120);

   Container := Graphics.BeginContainer;

   // Crie um caminho que consista em uma �nica elipse.
   Path := TGdipGraphicsPath.Create;
   Path.AddEllipse(275, 50, 100, 150);

   // Construa uma regi�o com base no caminho.
   Region := TGdipRegion.Create(Path);
   Graphics.FillRegion(GreenBrush, Region);

   Graphics.Clip := Region;
   Graphics.DrawLine(RedPen, 250, 0, 550, 300);
   Graphics.EndContainer(Container);

   Graphics.DrawLine(BluePen, 270, 0, 570, 300);

   Region.Free();
   Path.Free();
   GreenBrush.Free();
   AquaBrush.Free();
   BluePen.Free();
   RedPen.Free();
end;

/// Como mostram as ilustra��es acima, as transforma��es e regi�es de recorte s�o
/// cumulativo em cont�ineres aninhados. Se voc� definir as transforma��es mundiais do
/// container e o objeto <A>TGdipGraphics</A>, ambas as transforma��es ser�o aplicadas
/// para itens extra�dos de dentro do cont�iner. A transforma��o do
/// o cont�iner ser� aplicado primeiro, e a transforma��o do
/// O objeto <A>TGdipGraphics</A> ser� aplicado em segundo lugar. Se voc� definir o recorte
/// regi�es do container e do objeto <A>TGdipGraphics</A>, itens extra�dos de
/// dentro do cont�iner ser� cortado pela interse��o dos dois recortes
/// regi�es.
///
/// <H>Configura��es de qualidade em cont�ineres aninhados</H>
/// Configura��es de qualidade (<A>SmoothingMode</A>, <A>TextRenderingHint</A> e o
/// like) em cont�ineres aninhados n�o s�o cumulativos; em vez disso, as configura��es de qualidade
/// do cont�iner substitui temporariamente as configura��es de qualidade de um
/// Objeto <A>TGdipGraphics</A>. Quando voc� cria um novo cont�iner, a qualidade
/// as configura��es desse cont�iner s�o definidas com valores padr�o. Por exemplo, suponha
/// voc� tem um objeto <A>TGdipGraphics</A> com um modo de suaviza��o de
/// <A>SmoothingModeAntiAlias</A>. Ao criar um cont�iner, a suaviza��o
/// modo dentro do cont�iner � o modo de suaviza��o padr�o. Voc� � livre para definir
/// o modo de suaviza��o do cont�iner e quaisquer itens extra�dos de dentro do
/// o container ser� desenhado de acordo com o modo que voc� definiu. Itens sorteados ap�s o
/// chamada para <A>EndContainer</A> ser� desenhada de acordo com o modo de suaviza��o
/// (SmoothingModeAntiAlias) que estava em vigor antes da chamada para
/// <A>BeginContainer</A>.
///
/// <H>V�rias camadas de cont�ineres aninhados</H>
/// Voc� n�o est� limitado a um cont�iner em um objeto <A>TGdipGraphics</A>. Voc� pode
/// cria uma sequ�ncia de cont�ineres, cada um aninhado no anterior, e voc� pode
/// especifica a transforma��o mundial, regi�o de recorte e configura��es de qualidade de
/// cada um desses cont�ineres aninhados. Se voc� chamar um m�todo de desenho de dentro
/// o cont�iner mais interno, as transforma��es ser�o aplicadas em ordem,
/// come�ando com o cont�iner mais interno e terminando com o mais externo
///cont�iner. Os itens retirados de dentro do cont�iner mais interno ser�o cortados
/// pela interse��o de todas as regi�es de recorte.
///
/// O exemplo a seguir define a dica de renderiza��o de texto do <A>TGdipGraphics</A>
/// objeto para <A>TextRenderingHintAntiAlias</A>. O c�digo cria dois
/// containers, um aninhado dentro do outro. A dica de renderiza��o de texto do
/// o cont�iner externo � definido como <A>TextRenderingHintSingleBitPerPixel</A> e o
/// a dica de renderiza��o de texto do cont�iner interno � definida como
/// <A>TextRenderingHintAntiAlias</A>. O c�digo desenha tr�s strings: uma de
/// do cont�iner interno, um do cont�iner externo e um do cont�iner externo
/// objeto <A>TGdipGraphics</A> em si.

procedure TDemoNestedContainers.Example3;
var
   InnerContainer,
   OuterContainer: TGdipGraphicsContainer;
   Brush: TGdipBrush;
   Family: TGdipFontFamily;
   Font: TGdipFont;
begin
   Brush := TGdipSolidBrush.Create(TGdipColor.Blue);
   Family := TGdipFontFamily.Create('Times New Roman');
   Font := TGdipFont.Create(Family, 36, TGdipFontStyle.Regular, TGdipGraphicsUnit.Pixel);

   Graphics.TextRenderingHint := TGdipTextRenderingHint.AntiAlias;

   OuterContainer := Graphics.BeginContainer();
         Graphics.TextRenderingHint := TGdipTextRenderingHint.SingleBitPerPixel;

         InnerContainer := Graphics.BeginContainer();
               Graphics.TextRenderingHint := TGdipTextRenderingHint.AntiAlias;
               Graphics.DrawString('Cont�iner Interno', Font, Brush, TPointF.Create(20, 210));
         Graphics.EndContainer(InnerContainer);

         Graphics.DrawString('Cont�iner Externo', Font, Brush, TPointF.Create(20, 250));
   Graphics.EndContainer(OuterContainer);

   Graphics.DrawString('Objeto gr�fico', Font, Brush, TPointF.Create(20, 290));


   Font.Free();
   Family.Free();
   Brush.Free();
end;

/// A �ltima ilustra��o acima das tr�s strings. As cordas extra�das do
/// cont�iner interno e o objeto <A>TGdipGraphics</A> s�o suavizados por
/// antialiasing. O barbante retirado do recipiente externo n�o � alisado por
/// antialiasing por causa do <A>TextRenderingHintSingleBitPerPixel</A>
/// contexto.
{$ENDREGION}

procedure TDemoNestedContainers.Run;
begin
  Example1();
  Graphics.ResetTransform();
  Example2();
  Graphics.ResetClip();
  Example3();
end;

initialization
  RegisterDemo('Usando cont�ineres gr�ficos\Cont�ineres gr�ficos aninhados', TDemoNestedContainers);

end.
