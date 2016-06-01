unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,COMObj, KompasAPI7_TLB,Kompas6Constants_TLB,Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button2: TButton;
    Label4: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  d2,da2,df2,Lcm2, Dcm2,Dd2, q1,q2,b2,m,z,Dv2,h: extended;
   tolTable  : ITable;
  txt       : ITextLine;
  cell      : ITableCell;
procedure Kompas(d2,da2,df2,Lcm2, Dcm2,Dd2, q1,q2,b2,m,z,Dv2,h: extended);
procedure SponkaCalc(out W, H: Extended);
implementation

{$R *.dfm}

procedure SetToleranceText( tolPar : IToleranceParam );
var
  tolTable  : ITable;
  txt       : ITextLine;
  cell      : ITableCell;
begin
	if ( tolPar <> nil ) then
	begin
		// Получить интерфейс таблицы с текстом допуска формы
		tolTable := tolPar.Table;

		if ( tolTable <> nil ) then
		begin
			// Добавить 3 столбца (1 уже есть)
		//tolTable.AddColumn( -1, TRUE {справа} );
		//	tolTable.AddColumn( -1, TRUE {справа} );
		 //	tolTable.AddColumn( -1, TRUE {справа} );
			// Записать текст в 1-ю ячейку
			cell := tolTable.Cell[ 0, 0 ];
			if ( cell <> nil ) then
			begin
				txt:= cell.Text As ITextLine;
				if ( txt <> nil ) then
					txt.Str := 'A';
			end;
			// Записать текст во 2-ю ячейку
			cell := tolTable.Cell[ 0, 1 ];
			if ( cell <> nil ) then
			begin
				txt := cell.Text As ITextLine;
				if ( txt <> nil ) then
					txt.Str := '@27~';
			end;
			// Записать текст в 3-ю ячейку
			cell := tolTable.Cell[ 0, 2 ];
			if ( cell <> nil ) then
			begin
				txt := cell.Text As ITextLine;
				if ( txt <> nil ) then
					txt.Str := '@26~';
			end;
			// Записать текст в 4-ю ячейку
			cell := tolTable.Cell[ 0, 3 ];
			if ( cell <> nil ) then
			begin
				txt := cell.Text As ITextLine;

				if ( txt <> nil ) then
					txt.Str := '@25~';
			end;
		end;
	end;
end;

function AddLine(LSS: ILineSegments; X1, Y1, X2, Y2: extended): ILineSegment;
var
  LS: ILineSegment;
begin
  LS := LSS.Add;
  LS.X1 := X1;
  LS.Y1 := Y1;
  LS.X2 := X2;
  LS.Y2 := Y2;
  LS.Style := ksCSNormal;
  LS.Update;
  Result := LS;
end;

function AddLine2(LSS: ILineSegments; X1, Y1, X2, Y2: extended): ILineSegment;
var
  LS: ILineSegment;
begin
  LS := LSS.Add;
  LS.X1 := X1;
  LS.Y1 := Y1;
  LS.X2 := X2;
  LS.Y2 := Y2;
  LS.Style := ksCSAxial;
  LS.Update;
  Result := LS;
end;

function AddLineAxial(LSS: ILineSegments; X1, Y1, X2, Y2: extended)
  : ILineSegment;
var
  LS: ILineSegment;
begin
  LS := LSS.Add;
  LS.X1 := X1;
  LS.Y1 := Y1;
  LS.X2 := X2;
  LS.Y2 := Y2;
  LS.Style := ksCSThin;
  LS.Update;
  Result := LS;
end;

function AddLineAxial2(LSS: ILineSegments; X1, Y1, X2, Y2: extended)
  : ILineSegment;
var
  LS: ILineSegment;
begin
  LS := LSS.Add;
  LS.X1 := X1;
  LS.Y1 := Y1;
  LS.X2 := X2;
  LS.Y2 := Y2;
  LS.Style := ksCSAxial;
  LS.Update;
  Result := LS;
end;

function AddArc(Arcs: IArcs; Xc, Yc, R: extended): IArc;
var
  Arc: IArc;
begin
  Arc := Arcs.Add;
  Arc.Xc := Xc;
  Arc.Yc := Yc;
  Arc.Radius := R;
  Arc.Angle1 := 0;
  Arc.Angle2 := 360;
  Arc.Style := ksCSNormal;
  Arc.Update;
  Result := Arc;
end;

function AddArc1(Arcs: IArcs; Xc, Yc, R: extended): IArc;
var
  Arc: IArc;
begin
  Arc := Arcs.Add;
  Arc.Xc := Xc;
  Arc.Yc := Yc;
  Arc.Radius := R;
  Arc.Angle1 := 0;
  Arc.Angle2 := 360;
  Arc.Style := ksCSAxial;
  Arc.Update;
  Result := Arc;
end;
function AddLine1(LSS: ILineDimensions; X1, Y1, X2, Y2, X3, Y3: extended)
  : ILineDimension;
var
  LS2: ILineDimension;

begin

  LS2 := LSS.Add;
  LS2.X1 := X1;
  LS2.Y1 := Y1;
  LS2.X2 := X2;
  LS2.Y2 := Y2;
  LS2.X3 := X3;
  LS2.Y3 := Y3;
  LS2.Update;
  Result := LS2;
end;

function AddArcAxial(Arcs: IArcs; X1, Y1, X2, Y2, X3, Y3: extended): IArc;
var
  Arc: IArc;
begin
  Arc := Arcs.Add;
  Arc.X1 := X1;
  Arc.Y1 := Y1;
  Arc.X2 := X2;
  Arc.Y2 := Y2;
  Arc.X3 := X3;
  Arc.Y3 := Y3;
  Arc.Style := ksCSNormal;
  Arc.Update;
  Result := Arc;
end;

function Addarv(LSS: IDiametralDimensions; X1, Y1, X2: extended)
  : IDiametralDimension;
var
  LS2: IDiametralDimension;
begin
  LS2 := LSS.Add;
  LS2.Xc := X1;
  LS2.Yc := Y1;
  LS2.DimensionType := False;
  LS2.Radius := X2;
  LS2.Angle := 80;
  LS2.Update;
  Result := LS2;
end;

procedure SponkaCalc(out W, H: Extended);
begin
  if (dv2 > 12) and (dv2 <= 17) then
  begin
    W:=5;
    H:=2.3;
  end
  else if (dv2 > 17) and (dv2 <= 22) then
  begin
    W:=6;
    H:=2.8;
  end
  else if (dv2 > 22) and (dv2 <= 30) then
  begin
    W:=8;
    H:=3.3;
  end
  else if (dv2 > 30) and (dv2 <= 38) then
  begin
    W:=10;
    H:=3.3;
  end
  else if (dv2 > 38) and (dv2 <= 44) then
  begin
    W:=12;
    H:=3.3;
  end
  else if (dv2 > 44) and (dv2 <= 50) then
  begin
    W:=14;
    H:=3.8;
  end
  else if (dv2 > 50) and (dv2 <= 58) then
  begin
    W:=16;
    H:=4.3;
  end
  else if (dv2 > 58) and (dv2 <= 65) then
  begin
    W:=18;
    H:=4.4;
  end
  else if (dv2 > 65) and (dv2 <= 75) then
  begin
    W:=20;
    H:=4.9;
  end
  else if (dv2 > 75) and (dv2 <= 85) then
  begin
    W:=22;
    H:=5.4;
  end
  else if (dv2 > 85) and (dv2 <= 95) then
  begin
    W:=25;
    H:=5.4;
  end
  else
    ShowMessage('Невозможно подобрать параметры шпоночного паза');
end;

procedure Kompas;
var
  j, G, x0, y0, Y2, X2, X3, Y3, Ab, Bc, X1, Y1, De, Fg,D5,t1,t2: extended;
  KP: IApplication;
  KD: IKompasDocument;
  DP: IDispatch;
  LSS: ILineSegments;
  Arcs: IArcs;
  AW: IView;
  es: ICircles;
  Fd: IDiametralDimensions;
  Fd2: IRadialDimensions;
  Skk: ILineDimensions;
  dimText: IDimensionText;
  dimParam: IDimensionParams;
  LineSeg: array [0 .. 45] of ILineSegment;
  LineSeg2: array [0 .. 30] of ILineDimension;
  ArcSeg: array [0 .. 20] of IArc;
  Fds: array [0 .. 20] of IDiametralDimension;
  branchs: IBranchs;
  baseLeader: IBaseLeader;
  leader: Ileader;
  tx1,tx2,tx3: IText;
  rounghs:IRoughs ;
  roughPar  : IRoughParams;
  symbCont: ISymbols2DContainer;
  leadersCol: ILeaders;
  lead: Ileader;
  bLeader: IBaseLeader;
  center: ICentreMarkers ;
  hat:IHatch;
  hatpar:IHatchParam;
  hats:IHatches;
  toler: ITolerance;
  tolers: ITolerances;
  tolerpar: IToleranceParam;
begin
x0 := 130;
y0 := 170;

  KP := Co_Application.Create;
  KP.Visible := true;
  KD := KP.Documents.Add(ksDocumentDrawing, true);
  KD := KP.ActiveDocument;
  KD.LayoutSheets.Item[0].Format.Format := ksFormatUser;
  KD.LayoutSheets.Item[0].Format.FormatWidth := 420;
  KD.LayoutSheets.Item[0].Format.FormatHeight := 297;
  KD.LayoutSheets.Item[0].Update;

  AW := (KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView;
  LSS := ((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
    IDrawingContainer).LineSegments;
  Skk := (AW as ISymbols2DContainer).LineDimensions;
  Fd := (AW as ISymbols2DContainer).DiametralDimensions;
  Arcs := ((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
   IDrawingContainer).Arcs;
  rounghs:=(AW as ISymbols2DContainer).Roughs;
   center:=  (AW as ISymbols2DContainer).CentreMarkers;
   hats:=((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
    IDrawingContainer).Hatches as IHatches;
  tolers:= (AW as ISymbols2DContainer).Tolerances;

 ArcSeg[1] := AddArc(Arcs, x0, y0, dv2/2);
 ArcSeg[2] := AddArc(Arcs, x0, y0, dcm2/2); // окружность
 ArcSeg[3] := AddArc(Arcs, x0, y0, (df2-q1)/2);
 ArcSeg[4] := AddArc(Arcs, x0, y0, df2/2);
 ArcSeg[5] := AddArc1(Arcs, x0, y0, d2/2);  // осевая окружность
 ArcSeg[6] := AddArc(Arcs, x0, y0, da2/2);



LineSeg2[2] := AddLine1(Skk, x0 + da2 / 2+30+Lcm2/2+b2/2, y0 + da2/2, x0 + da2 / 2+30+Lcm2/2+b2/2, y0 - da2/2, x0 + da2 / 2+80+Lcm2+b2/2, y0 );
dimText:=LineSeg2[2] as Idimensiontext;
dimText.Prefix.Str:='@2~' ;
LineSeg2[2].Update;

LineSeg[3] := AddLine2(LSS, x0 + da2 / 2 + 20, y0, x0 + da2 / 2 +Lcm2+ 40, y0);//осевая прямая линия
LineSeg[4] := AddLine(LSS, x0 + da2 / 2+30, y0 + dv2 / 2, x0 + da2 / 2+30, y0 +Dcm2/2);
LineSeg[5] := AddLine(LSS, x0 + da2 / 2+30, y0 +Dcm2/2, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +Dcm2/2);
LineSeg[6] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +Dcm2/2, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +df2/2-q1);
LineSeg[7] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +df2/2-q1, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +df2/2-q1);
LineSeg[8] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +df2/2-q1, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +da2/2);
LineSeg[9] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +da2/2, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +da2/2);
LineSeg[10] := AddLine(LSS, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +da2/2, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 + df2/2-q1);
LineSeg[11] := AddLine(LSS, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +df2/2-q1, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0+df2/2-q1);
LineSeg[12] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +df2/2-q1, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +Dcm2/2);
LineSeg[13] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +Dcm2/2,  x0 + da2 / 2+30+Lcm2, y0 +Dcm2/2);
LineSeg[14] := AddLine(LSS, x0 + da2 / 2+30+Lcm2, y0 +Dcm2/2, x0 + da2 / 2+30+Lcm2, y0 +dv2/2);
LineSeg[15] := AddLine(LSS, x0 + da2 / 2+30+Lcm2, y0 +dv2/2, x0 + da2 / 2+30, y0 + dv2 / 2);
LineSeg[16] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 + df2/2, x0 + da2 / 2+30+(Lcm2-b2)/2+b2, y0 + df2/2);
LineSeg[17] := AddLine2(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0+d2/2, x0 + da2 / 2+30+(Lcm2-b2)/2+b2, y0+d2/2);

LineSeg2[18] := AddLine1(Skk, x0 + da2 / 2+30+Lcm2/2+b2/2, y0 + d2/2, x0 + da2 / 2+30+Lcm2/2+b2/2, y0 - d2/2, x0 + da2 / 2+70+Lcm2+b2/2, y0 );
dimText:=LineSeg2[18] as Idimensiontext;
dimText.Prefix.Str:='@2~' ;
LineSeg2[18].Update;

LineSeg2[19] := AddLine1(Skk, x0 + da2 / 2+30+Lcm2, y0 +dv2/2, x0 + da2 / 2+30, y0 + dv2 / 2, x0 + da2 / 2+30+Lcm2/2, y0 +2);
LineSeg2[20] := AddLine1(Skk, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +Dcm2/2, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +Dcm2/2, x0 + da2 / 2+30+Lcm2/2+q2, y0 +Dcm2/2+3);
LineSeg2[21] := AddLine1(Skk, x0 + da2 / 2+30+Lcm2, y0 +dv2/2, x0 + da2 / 2+30+Lcm2, y0 -Dv2/2, x0 + da2 / 2+45+Lcm2, y0 );
dimText:=LineSeg2[21] as Idimensiontext;
dimText.Prefix.Str:='@2~' ;
LineSeg2[21].Update;
LineSeg2[22] := AddLine1(Skk, x0 + da2 / 2+30+Lcm2, y0 +dcm2/2, x0 + da2 / 2+30+Lcm2, y0 -Dcm2/2, x0 + da2 / 2+55+Lcm2, y0 );
dimText:=LineSeg2[22] as Idimensiontext;
dimText.Prefix.Str:='@2~' ;
LineSeg2[22].Update;
LineSeg2[23] := AddLine1(Skk, x0 + da2 / 2+30+(Lcm2-b2)/2+b2, y0 + df2/2, x0 + da2 / 2+30+(Lcm2-b2)/2+b2, y0 - df2/2, x0 + da2 / 2+65+Lcm2, y0 );
dimText:=LineSeg2[23] as Idimensiontext;
dimText.Prefix.Str:='@2~' ;
LineSeg2[23].Update;
LineSeg2[24] := AddLine1(Skk, x0 + da2 / 2+30+(Lcm2-b2)/2+b2, y0 + df2/2, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +df2/2-q1, x0 + da2 / 2+40, (y0 + df2/2-y0 -(df2-q1)/2)/2+y0 +(df2-q1)/2 );

LineSeg[25] := AddLine2(LSS, x0 + da2 / 2 + 10, y0, x0 - da2 / 2 - 10, y0); //осевые у окружности
LineSeg[26] := AddLine2(LSS, x0 , y0+ da2 / 2 + 10, x0, y0 - da2 / 2 - 10);

SponkaCalc(T1,T2);
LineSeg[27] := AddLine(LSS, x0 -t1/2, y0 + dv2 / 2-t2/2, x0 - t1/2, y0 +dv2 / 2+t2/2);
LineSeg[28] := AddLine(LSS, x0 - t1/2, y0 +dv2 / 2+t2/2, x0 + t1/2, y0 +dv2 / 2+t2/2);
LineSeg[29] := AddLine(LSS, x0 + t1/2, y0 +dv2 / 2+t2/2, x0 +t1/2, y0 + dv2 / 2-t2/2);
LineSeg[30] := AddLine(LSS, x0 - t1/2, y0 +dv2 / 2-t2/2, x0 + t1/2, y0 +dv2 / 2-t2/2);
LineSeg[31] := AddLine(LSS, x0 + da2 / 2+30, y0 +dv2 / 2+t2/2, x0 + da2 / 2+30+Lcm2, y0 +dv2 / 2+t2/2);


rounghs.Add;  //шероховатость
rounghs.Rough[0].X0:=x0+200;
rounghs.Rough[0].Y0:=y0+100;
roughPar := rounghs.Rough[0] As IRoughParams;
roughPar.ProcessingByContour:=false;
roughPar.ArrowInside:=true;
tx1:=roughPar.RoughParamText;
	if ( tx1 <> nil ) then
  begin
						tx1.Str := '3,2 ( @78~ '+ ' )';
            //tx1.Str:= tx1.Str+'@1~';
  end;
rounghs.Rough[0].Update;

rounghs.Add;  //шероховатость
rounghs.Rough[1].X0:=x0+da2/2+27+Lcm2;
rounghs.Rough[1].Y0:=y0+Dcm2/2;
roughPar := rounghs.Rough[1] As IRoughParams;
roughPar.ArrowType:=0;
roughPar.ShelfDirection:= ksLSNone;
tx2:=roughPar.RoughParamText;
if ( tx2 <> nil ) then
  tx2.Str := '1,6';
roughPar.SignType:=1;
rounghs.Rough[1].Update;

rounghs.Add;  //шероховатость
rounghs.Rough[2].X0:=x0+da2/2+30;
rounghs.Rough[2].Y0:=y0+Dv2/2;
roughPar := rounghs.Rough[2] As IRoughParams;
roughPar.ShelfDirection:= ksLSolderingSign;// Изменение положения шероховатости в вертикальность
roughPar.ArrowType:=0;
tx3:=roughPar.RoughParamText;
if ( tx3 <> nil ) then
  tx3.Str := '2,5';
rounghs.Rough[2].Update;

Toler:=Tolers.Add;
   	if ( toler <> nil ) then
	begin
		// Получить интерфейс ответвления
		branchs := toler As IBranchs;
 		if ( branchs <> nil ) then
		begin
			branchs.X0 := x0+da2/2+15;   	// Задать точку привязки
			branchs.Y0 := y0+dv2/2+5;
			branchs.AddBranchByPoint( 1, x0+da2/2+30, y0+dv2/2+5 );	// Добавить ответвление
		end;
 		// Получить интерфейс параметров допуска формы
		TolerPar := toler As IToleranceParam;
  		if ( TolerPar <> nil ) then
		  begin
				if ( tolerpar <> nil ) then
begin
		// Получить интерфейс таблицы с текстом допуска формы
		    tolTable := tolerpar.Table;
   		  if ( tolTable <> nil ) then
		  begin
			  cell := tolTable.Cell[ 0, 0 ];
			  if ( cell <> nil ) then
			    begin
				    txt:= cell.Text As ITextLine;
				    if ( txt <> nil ) then
					  txt.Str := 'A';
		    	end;

		  end;
	  end;
			// Положение базовой точки относительно таблицы - внизу посередине
			TolerPar.BasePointPos := ksTPRightCenter;
		end;
  		// Тип стрелки 1-го ответвления - треугольник
		toler.Set_ArrowType( 0, FALSE );
		// Положение 1-го ответвления относительно таблицы - внизу посередине
		Toler.Set_BranchPos( 0, ksTPRightCenter );
		// Тип стрелки 2-го ответвления - стрелка
	 //	toler.Set_ArrowType( 1, TRUE );
		// Положение 2-го ответвления относительно таблицы - слева посередине
//		toler.Set_BranchPos( 1, ksTPLeftCenter );
  toler.Update();
	end;

Toler:=Tolers.Add;
   	if ( toler <> nil ) then
	begin
		// Получить интерфейс ответвления
		branchs := toler As IBranchs;
 		if ( branchs <> nil ) then
		begin
			// Задать точку привязки
			branchs.X0 := x0+da2/2+30+Lcm2/2;
			branchs.Y0 := y0+da2/2+15;
			// Добавить 2 ответвления
			branchs.AddBranchByPoint( 1, x0+da2/2+30+Lcm2/2, y0+da2/2 );
			//branchs.AddBranchByPoint( -1, 50, 155 );
		end;
 		// Получить интерфейс параметров допуска формы
		TolerPar := toler As IToleranceParam;
  		if ( TolerPar <> nil ) then
		begin
				if ( tolerpar <> nil ) then
	begin
		// Получить интерфейс таблицы с текстом допуска формы
		tolTable := tolerpar.Table;
   		if ( tolTable <> nil ) then
		begin
			// Добавить 3 столбца  {справа}
		  tolTable.AddColumn( -1, TRUE  );
			tolTable.AddColumn( -1, TRUE  );
			cell := tolTable.Cell[ 0, 0 ];  	// Записать текст в 1-ю ячейку
			if ( cell <> nil ) then
			begin
				txt:= cell.Text As ITextLine;
				if ( txt <> nil ) then
					txt.Str := '@28~';
			end;
			// Записать текст во 2-ю ячейку
			cell := tolTable.Cell[ 0, 1 ];
			if ( cell <> nil ) then
			begin
				txt := cell.Text As ITextLine;
				if ( txt <> nil ) then
					txt.Str := '0.01';
			end;
			// Записать текст в 3-ю ячейку
			cell := tolTable.Cell[ 0, 2 ];
			if ( cell <> nil ) then
			begin
				txt := cell.Text As ITextLine;
				if ( txt <> nil ) then
					txt.Str := 'A';
			end;
		end;
	end;
			// Положение базовой точки относительно таблицы
			TolerPar.BasePointPos := ksTPLeftCenter;
		end;
  		// Тип стрелки 1-го ответвления - треугольник
		toler.Set_ArrowType( 1, FALSE );
		// Положение 1-го ответвления относительно таблицы
		Toler.Set_BranchPos( 0, ksTPLeftUp );
		// Тип стрелки 2-го ответвления - стрелка
//		toler.Set_ArrowType( 1, TRUE );
//		// Положение 2-го ответвления относительно таблицы
//		toler.Set_BranchPos( 1, ksTPLeftCenter );
		// Применить параметры

  toler.Update();
	end;
end;


procedure TForm2.Button1Click(Sender: TObject);
begin
kompas(d2,da2,df2,Lcm2, Dcm2,Dd2, q1,q2,b2,m,z,Dv2,h);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
if (Edit1.Text='') or (Edit2.Text='') or (Edit3.Text='') then
  begin
    ShowMessage('Заполните все поля!');
    exit;
  end;
m:=StrToFloat(Edit1.Text);
z:=StrToFloat(Edit2.Text);
d2:=m*z;
Dv2:=StrToFloat(Edit3.Text);
da2:=d2+2*m;
df2:=d2-2.5*m;
Lcm2:=1.5*Dv2;
Dcm2:=1.6*Dv2;
Dd2:=1.2*Dv2;
q1:=2.25*m;
if q1<8 then
  q1:=8;
b2:=7*m;
q2:=0.4*b2;
h:=da2-df2;
Label4.Caption:=Label4.Caption+FloatToStr(d2);
Label5.Caption:=Label5.Caption+FloatToStr(dd2);
Label6.Caption:=Label6.Caption+FloatToStr(Dcm2);
Label7.Caption:=Label7.Caption+FloatToStr(Lcm2);
Label8.Caption:=Label8.Caption+FloatToStr(b2);
Label9.Caption:=Label9.Caption+FloatToStr(h);
Label10.Caption:=Label10.Caption+FloatToStr(q1);
Label11.Caption:=Label11.Caption+FloatToStr(q2);
Label12.Caption:=Label12.Caption+FloatToStr(da2);
Label13.Caption:=Label13.Caption+FloatToStr(df2);
Button1.Enabled:=true;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Button1.Enabled:=False;
end;

end.
