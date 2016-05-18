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
procedure Kompas(B, L0, a, bH, b6, ba, c, h, dw1, dw2, dw3, dw4: extended);
implementation

{$R *.dfm}
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
procedure Kompas(B, L0, a, bH, b6, ba, c, h, dw1, dw2, dw3, dw4: extended);
var
  j, G, x0, y0, Y2, X2, X3, Y3, Ab, Bc, X1, Y1, De, Fg,D5: extended;
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
  LineSeg2: array [0 .. 20] of ILineDimension;
  ArcSeg: array [0 .. 20] of IArc;
  Fds: array [0 .. 20] of IDiametralDimension;
  branchs: IBranchs;
  baseLeader: IBaseLeader;
  leader: Ileader;
  txtOnSh: IText;
  symbCont: ISymbols2DContainer;
  leadersCol: ILeaders;
  lead: Ileader;
  bLeader: IBaseLeader;
begin
//  D5 := (D1 - D) / 2;
//  Ab := (L1 - L6) / 2;
//  Bc := (L2 - L4) / 2;
//  De := (L2 - L5) / 2;
//  Fg := L - L8;
//  G := 100;
//  x0 := 150;
//  y0 := 150;
//  X1 := 150 - D / 2;
//  Y1 := 400;
//  j := 6;
//  KP := Co_Application.Create;
//  KP.Visible := true;
//  KD := KP.Documents.Add(1, true);
//  KD := KP.ActiveDocument;
//  KD.LayoutSheets.Item[0].Format.Format := ksFormatUser;
//  KD.LayoutSheets.Item[0].Format.FormatWidth := 300;
//  KD.LayoutSheets.Item[0].Format.FormatHeight := 500;
//  KD.LayoutSheets.Item[0].Update;
//
//  AW := (KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView;
//  LSS := ((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
//    IDrawingContainer).LineSegments;
//  Skk := (AW as ISymbols2DContainer).LineDimensions;
//  Fd := (AW as ISymbols2DContainer).DiametralDimensions;
//  Arcs := ((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
//    IDrawingContainer).Arcs;
//  ArcSeg[1] := AddArc(Arcs, x0, y0, D1 / 2);
//  ArcSeg[2] := AddArc(Arcs, x0, y0, D / 2); // окружность
//  ArcSeg[3] := AddArc1(Arcs, x0, y0, D5);
//  ArcSeg[4] := AddArc(Arcs, x0 - D5, y0, M / 2);
//  ArcSeg[5] := AddArc(Arcs, x0 + D5, y0, M / 2);
//  ArcSeg[6] := AddArc(Arcs, x0, y0 - D5, M / 2);
//  ArcSeg[7] := AddArc(Arcs, x0, y0 + D5, M / 2);
//  LineSeg[1] := AddLine2(LSS, x0, y0 - L1 / 2 - 5, x0, y0 + L1 / 2 + 5);
//  LineSeg[2] := AddLine2(LSS, x0 - L1 / 2 - 5, y0, x0 + L1 / 2 + 5, y0);
//  LineSeg[3] := AddLine(LSS, x0 - L2 / 2, y0 + L1 / 2, x0 - L2 / 2 + L2,
//    y0 + L1 / 2);
//  LineSeg[4] := AddLine(LSS, x0 - L2 / 2, y0 - L1 / 2, x0 - L2 / 2 + L2,
//    y0 - L1 / 2);
//  LineSeg[5] := AddLine(LSS, x0 - L2 / 2 + L2, y0 + L1 / 2, x0 - L2 / 2 + L2,
//    y0 + L1 / 2 - Ab);
//  LineSeg[6] := AddLine(LSS, x0 - L2 / 2 + L2, y0 + L1 / 2 - Ab,
//    x0 - L2 / 2 + L2 - Bc, y0 + L1 / 2 - Ab);
//  LineSeg[7] := AddLine(LSS, x0 - L2 / 2 + L2 - Bc, y0 + L1 / 2 - Ab,
//    x0 - L2 / 2 + L2 - Bc, y0 + L1 / 2 - Ab - L6);
//  LineSeg[14] := AddLine(LSS, x0 - L2 / 2 + L2 - Bc, y0 + L1 / 2 - Ab - L6,
//    x0 - L2 / 2 + L2 - Bc + Bc, y0 + L1 / 2 - Ab - L6);
//  LineSeg[8] := AddLine(LSS, x0 - L2 / 2 + L2 - Bc + Bc, y0 + L1 / 2 - Ab - L6,
//    x0 - L2 / 2 + L2 - Bc + Bc, y0 + L1 / 2 - Ab - L6 - Ab);
//  LineSeg[9] := AddLine(LSS, x0 - L2 / 2, y0 + L1 / 2, x0 - L2 / 2,
//    y0 + L1 / 2 - Ab);
//  LineSeg[10] := AddLine(LSS, x0 - L2 / 2, y0 + L1 / 2 - Ab, x0 - L2 / 2 + Bc,
//    y0 + L1 / 2 - Ab);
//  LineSeg[11] := AddLine(LSS, x0 - L2 / 2 + Bc, y0 + L1 / 2 - Ab,
//    x0 - L2 / 2 + Bc, y0 + L1 / 2 - Ab - L6);
//  LineSeg[12] := AddLine(LSS, x0 - L2 / 2 + Bc, y0 + L1 / 2 - Ab - L6,
//    x0 - L2 / 2 + Bc - Bc, y0 + L1 / 2 - Ab - L6);
//  LineSeg[13] := AddLine(LSS, x0 - L2 / 2 + Bc - Bc, y0 + L1 / 2 - Ab - L6,
//    x0 - L2 / 2 + Bc - Bc, y0 + L1 / 2 - Ab - L6 - Ab);
//
//  ArcSeg[8] := AddArc(Arcs, x0 - L5 / 2, y0 - L7 / 2, D4 / 2);
//  LineSeg[15] := AddLine2(LSS, x0 - L5 / 2, y0 - L7 / 2 - 5, x0 - L5 / 2,
//    y0 - L7 / 2 + 5);
//  LineSeg[16] := AddLine2(LSS, x0 - L5 / 2 - 5, y0 - L7 / 2, x0 - L5 / 2 + 5,
//    y0 - L7 / 2);
//  ArcSeg[9] := AddArc(Arcs, x0 - L5 / 2, y0 + L7 / 2, D4 / 2);
//  LineSeg[17] := AddLine2(LSS, x0 - L5 / 2, y0 + L7 / 2 - 5, x0 - L5 / 2,
//    y0 + L7 / 2 + 5);
//  LineSeg[18] := AddLine2(LSS, x0 - L5 / 2 - 5, y0 + L7 / 2, x0 - L5 / 2 + 5,
//    y0 + L7 / 2);
//  ArcSeg[8] := AddArc(Arcs, x0 + L5 / 2, y0 + L7 / 2, D4 / 2);
//  LineSeg[19] := AddLine2(LSS, x0 + L5 / 2, y0 + L7 / 2 - 5, x0 + L5 / 2,
//    y0 + L7 / 2 + 5);
//  LineSeg[20] := AddLine2(LSS, x0 + L5 / 2 - 5, y0 + L7 / 2, x0 + L5 / 2 + 5,
//    y0 + L7 / 2);
//  ArcSeg[8] := AddArc(Arcs, x0 + L5 / 2, y0 - L7 / 2, D4 / 2);
//  LineSeg[15] := AddLine2(LSS, x0 + L5 / 2, y0 - L7 / 2 - 5, x0 + L5 / 2,
//    y0 - L7 / 2 + 5);
//  LineSeg[16] := AddLine2(LSS, x0 + L5 / 2 - 5, y0 - L7 / 2, x0 + L5 / 2 + 5,
//    y0 - L7 / 2);
//
//  LineSeg[17] := AddLine(LSS, X1, Y1, X1 + D1 - 5, Y1);
//  LineSeg[18] := AddLine(LSS, X1, Y1, X1 - 2.5, Y1 - 2.5);
//  LineSeg[19] := AddLine(LSS, X1 - 2.5, Y1 - 2.5, X1 - 2.5 + D1 / 2, Y1 - 2.5);
//  LineSeg[20] := AddLine(LSS, X1 - 2.5, Y1 - 2.5, X1 - 2.5, Y1 - (L - L3));
//  LineSeg[21] := AddLine(LSS, X1 - 2.5 - Bc, Y1 - (L - L3),
//    X1 - 2.5 - Bc + D1 / 2 + Bc, Y1 - (L - L3));
//  LineSeg[22] := AddLine(LSS, X1 - 2.5 - Bc, Y1 - (L - L3), X1 - 2.5 - Bc,
//    Y1 - (L - L3) - L3);
//  LineSeg[23] := AddLine(LSS, X1 - 2.5 - Bc, Y1 - (L - L3) - L3,
//    X1 - 2.5 - Bc + L2, Y1 - (L - L3) - L3);
//  LineSeg[24] := AddLine2(LSS, X1 + D1 / 2 - 2.5, Y1 + 2, X1 + D1 / 2 - 2.5,
//    Y1 - L - 2);
//  LineSeg[25] := AddLine(LSS, X1 - 2.5 - Bc + De - De / 2, Y1 - (L - L3),
//    X1 - 2.5 - Bc + De - De / 2, Y1 - (L - L3) - L3);
//  LineSeg[26] := AddLine2(LSS, X1 - 2.5 - Bc + De, Y1 - (L - L3) + 2,
//    X1 - 2.5 - Bc + De, Y1 - (L - L3) - L3 - 2);
//  LineSeg[27] := AddLine(LSS, X1 - 2.5 - Bc + De + De / 2, Y1 - (L - L3),
//    X1 - 2.5 - Bc + De + De / 2, Y1 - (L - L3) - L3);
//  LineSeg[28] := AddLine(LSS, X1 + D1 / 2 + D / 2 - 2.5, Y1,
//    X1 + D1 / 2 + D / 2 - 2.5, Y1 - Fg);
//  LineSeg[31] := AddLine(LSS, X1 + D1 - 5, Y1, X1 + D1 - 5 + 2.5, Y1 - 2.5);
//  LineSeg[32] := AddLine(LSS, X1 + D1 - 5 + 2.5, Y1 - 2.5, X1 + D1 - 5 + 2.5,
//    Y1 - 2.5 - (L - L3));
//  LineSeg[33] := AddLine(LSS, X1 + D1 - 5 + 2.5, Y1 - 2.5 - (L - L3),
//    X1 + D1 - 5 + 2.5 + Bc + (L4 - D1), Y1 - 2.5 - (L - L3));
//  LineSeg[29] := AddLine(LSS, X1 + D1 / 2 - 2.5, Y1 - (L - L8),
//    X1 + D1 / 2 - 2.5 + D2 / 2, Y1 - (L - L8));
//  LineSeg[30] := AddLine(LSS, X1 + D1 / 2 - 2.5 + D2 / 2, Y1 - (L - L8),
//    X1 + D1 / 2 - 2.5 + D2 / 2, Y1 - (L - L8) - L8);
//  LineSeg[34] := AddLine(LSS, X1 + D1 - 5 + 2.5 + Bc + (L4 - D1),
//    Y1 - 2.5 - (L - L3), X1 + D1 - 5 + 2.5 + Bc + (L4 - D1),
//    Y1 - (L - L3) - L3);
//  LineSeg[35] := AddLine(LSS, X1 + L4 - 2.5, Y1 - 2.5 - (L - L3), X1 + L4 - 2.5,
//    Y1 - (L - L3) - L3);
//  LineSeg[36] := AddLine2(LSS, X1 + L4 - 2.5 + De, Y1 - (L - L3) + 0.5,
//    X1 + L4 - 2.5 + De, Y1 - (L - L3) - L3 - 2);
//  LineSeg[37] := AddLine(LSS, X1 + D1 - 5, Y1, X1 + D1 - 5 - 2, Y1 - 2);
//  LineSeg[38] := AddLine(LSS, X1 + D1 - 5 - 2, Y1 - 2, X1 + D1 - 5 - 2,
//    Y1 - 2 - (L - L8) + 2);
//  LineSeg[39] := AddLine(LSS, X1 + D1 - 5 - 2, Y1 - 2,
//    X1 + D1 - 5 - 2 - M, Y1 - 2);
//  LineSeg[40] := AddLine(LSS, X1 + D1 - 5 - 2 - M, Y1 - 2,
//    X1 + D1 - 5 - 2 - M - 2, Y1 - 2 + 2);
//  LineSeg[41] := AddLine(LSS, X1 + D1 - 5 - 2 - M, Y1 - 2, X1 + D1 - 5 - 2 - M,
//    Y1 - 2 - (L - L8) + 2);
//  LineSeg[41] := AddLine2(LSS, X1 + D1 - 5 - 2 - M / 2, Y1 + 2,
//    X1 + D1 - 5 - 2 - M / 2, Y1 - 2 - (L - L8));
//
//  LineSeg2[1] := AddLine1(Skk, x0 - L4 / 2, y0, x0 + L4 / 2, y0, x0,
//    y0 - L1 / 2 - 10);
//  LineSeg2[2] := AddLine1(Skk, x0 - L5 / 2, y0 - ((L1 - L7) / 2), x0 + L5 / 2,
//    y0 - ((L1 - L7) / 2), x0, y0 - L1 / 2 - 20);
//  LineSeg2[3] := AddLine1(Skk, x0 - L2 / 2, y0 - L1 / 2, x0 + L2 / 2,
//    y0 - L1 / 2, x0, y0 - L1 / 2 - 30);
//  LineSeg2[4] := AddLine1(Skk, x0 + L2 / 2, y0 + L6 / 2, x0 + L2 / 2,
//    y0 - L6 / 2, x0 + L2 / 2 + 10, y0);
//  LineSeg2[5] := AddLine1(Skk, x0 + L5 / 2, y0 + L7 / 2, x0 + L5 / 2,
//    y0 - L7 / 2, x0 + L2 / 2 + 20, y0);
//  LineSeg2[6] := AddLine1(Skk, x0 + L2 / 2, y0 + L1 / 2, x0 + L2 / 2,
//    y0 - L1 / 2, x0 + L2 / 2 + 30, y0);
//  LineSeg2[7] := AddLine1(Skk, X1 - Bc, Y1 - (L - L3), X1 - Bc,
//    Y1 - (L - L3) - L3, X1 - Bc - 10, Y1 - (L - L3));
//  LineSeg2[8] := AddLine1(Skk, X1, Y1, X1, Y1 - L, X1 - 20, Y1 - L);
//  LineSeg2[9] := AddLine1(Skk, X1, Y1, X1, Y1 - 2.5, X1 - 10, Y1);
//  LineSeg2[10] := AddLine1(Skk, X1 + D1 - 5, Y1, X1 + D1 - 5, Y1 - 2.5,
//    X1 + D1 - 5 + 10, Y1);
//  LineSeg2[11] := AddLine1(Skk, X1 + D1 / 2 - 2.5 + D2 / 2, Y1 - (L - L8),
//    X1 + D1 / 2 - 2.5 + D2 / 2, Y1 - (L - L8) - L8, X1 + D1 / 2 - 2.5 + D2 / 2 +
//    L2 / 2, Y1 - (L - L8));
//
//  dimText := LineSeg2[9] as IDimensionText; // текст рядом с размером
//  dimText.Suffix.Str := 'x45&01';
//  LineSeg2[9].Update;
//  dimText := LineSeg2[10] as IDimensionText; // текст рядом с размером
//  dimText.Suffix.Str := 'x45&01';
//  LineSeg2[10].Update;
//
//  LineSeg2[12] := AddLine1(Skk, X1 + (D1 / 2 - D / 2) - 2.5, Y1,
//    X1 + D1 / 2 + D / 2 - 2.5, Y1, X1 + D1 / 2 + D / 2 - 2.5, Y1 + 10);
//  dimParam := LineSeg2[12] as IDimensionParams; // текст с одной стрелочкой
//  dimParam.RemoteLine1 := False;
//  dimParam.ArrowType1 := ksLeaderWithoutArrow;
//  LineSeg2[12].Update;
//  LineSeg2[13] := AddLine1(Skk, X1 - 2.5, Y1 - 2.5, X1 + D1 - 2.5, Y1-2.5,
//    X1 + D1 - 2.5, Y1 + 20);
//  dimParam := LineSeg2[13] as IDimensionParams; // текст с одной стрелочкой
//  dimParam.RemoteLine1 := False;
//  dimParam.ArrowType1 := ksLeaderWithoutArrow;
//  LineSeg2[13].Update;
//
//  symbCont := (KD as IKompasDocument2D).ViewsAndLayersManager.Views.ActiveView
//    As ISymbols2DContainer;
//  leadersCol := symbCont.Leaders;
//  leader := leadersCol.Add(ksDrLeader) As Ileader;
  // CreateLeader(leader);
//  if (leader <> nil) then
//  begin
//    // Направление полки - вправо
//    leader.ShelfDirection := ksLSLeft;
//
//    // Получаем интерфейс ответвлений
//    branchs := leader As IBranchs;
//
//    if (branchs <> nil) then
//    begin
//      // Координаты начала полки или точка привязки
//      branchs.x0 := x0 - L5 / 5;
//      branchs.y0 := y0 + L1 / 2 + 10;
//      // Добавить прямолинейные ответвления
//      branchs.AddBranchByPoint(-1, x0 - M / 2, y0 + L7 / 2 + 2);
//      // branchs.AddBranchByPoint(-1, x0 - L4 / 2 + 20, y0 - L7 / 2 + 10);
//    end;
//
//    // Получить интерфейс текста над полкой
//    txtOnSh := leader.TextOnShelf;
//
//    if (txtOnSh <> nil) then
//      // Изменить текст
//      txtOnSh.Str := '4 отв. M' + FloatToStr(M);
//
//    baseLeader := leader As IBaseLeader;
//
//    if (baseLeader <> nil) then
//      // Применить параметры
//      baseLeader.Update();
//    leader := leadersCol.Add(ksDrLeader) As Ileader;
//    // CreateLeader(leader);
//    if (leader <> nil) then
//    begin
//      // Направление полки - вправо
//      leader.ShelfDirection := ksLSLeft;
//
//      // Получаем интерфейс ответвлений
//      branchs := leader As IBranchs;
//
//      if (branchs <> nil) then
//      begin
//        // Координаты начала полки или точка привязки
//        branchs.x0 := x0 - L2 / 2 - 10;
//        branchs.y0 := y0 - L7 / 2 - 5;
//        // Добавить прямолинейные ответвления
//
//        branchs.AddBranchByPoint(-1, x0 - L5 / 2 - D4 / 2,
//          y0 - L7 / 2 - D4 / 2);
//      end;
//
//      // Получить интерфейс текста над полкой
//      txtOnSh := leader.TextOnShelf;
//
//      if (txtOnSh <> nil) then
//        // Изменить текст
//        txtOnSh.Str := '4 отв. M' + FloatToStr(D4);
//
//      baseLeader := leader As IBaseLeader;
//
//      if (baseLeader <> nil) then
//        // Применить параметры
//        baseLeader.Update();
//    end;
//  end;
end;
procedure TForm2.Button1Click(Sender: TObject);
var x0, y0 :extended;
  KP: IApplication;
  KD: IKompasDocument;
  DP: IDispatch;
  LSS: ILineSegments;
  Arcs: IArcs;
  AW: IView;
  es: ICircles;
  Skk: ILineDimensions;
  LineSeg: array [0 .. 45] of ILineSegment;
  LineSeg2: array [0 .. 20] of ILineDimension;
  ArcSeg: array [0 .. 20] of IArc;
begin


x0 := 130;
y0 := 170;

  KP := Co_Application.Create;
  KP.Visible := true;
  KD := KP.Documents.Add(1, true);
  KD := KP.ActiveDocument;
  KD.LayoutSheets.Item[0].Format.Format := ksFormatUser;
  KD.LayoutSheets.Item[0].Format.FormatWidth := 500;
  KD.LayoutSheets.Item[0].Format.FormatHeight := 300;
  KD.LayoutSheets.Item[0].Update;

  AW := (KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView;
  LSS := ((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
    IDrawingContainer).LineSegments;
  Skk := (AW as ISymbols2DContainer).LineDimensions;
  //Fd := (AW as ISymbols2DContainer).DiametralDimensions;
  Arcs := ((KD as IDrawingDocument).ViewsAndLayersManager.Views.ActiveView as
   IDrawingContainer).Arcs;
 ArcSeg[1] := AddArc(Arcs, x0, y0, dv2/2);
 ArcSeg[2] := AddArc(Arcs, x0, y0, dcm2/2); // окружность
 ArcSeg[3] := AddArc(Arcs, x0, y0, (df2-q1)/2);
 ArcSeg[4] := AddArc(Arcs, x0, y0, df2/2);
 ArcSeg[5] := AddArc1(Arcs, x0, y0, d2/2);  // осевая окружность
 ArcSeg[6] := AddArc(Arcs, x0, y0, da2/2);

LineSeg2[1] := AddLine1(Skk, x0 - d2 / 2, y0, x0 + d2 / 2, y0, x0, y0 - da2 / 2 - 10);
LineSeg2[2] := AddLine1(Skk, x0 - d2 / 2, y0, x0 + d2 / 2, y0, x0, y0 - da2 / 2 - 10);//указание размера
LineSeg[3] := AddLine2(LSS, x0 + da2 / 2 + 20, y0, x0 + da2 / 2 +Lcm2+ 40, y0);//осевая прямая линия
LineSeg[4] := AddLine(LSS, x0 + da2 / 2+30, y0 + dv2 / 2, x0 + da2 / 2+30, y0 +Dcm2/2);
LineSeg[5] := AddLine(LSS, x0 + da2 / 2+30, y0 +Dcm2/2, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +Dcm2/2);
LineSeg[6] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +Dcm2/2, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +(df2-q1)/2);
LineSeg[7] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2, y0 +(df2-q1)/2, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +(df2-q1)/2);
LineSeg[8] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +(df2-q1)/2, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +da2/2);
LineSeg[9] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 +da2/2, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +da2/2);
LineSeg[10] := AddLine(LSS, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +da2/2, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +(df2-q1)/2);
LineSeg[11] := AddLine(LSS, x0 + da2 / 2+30+b2+(Lcm2-b2)/2, y0 +(df2-q1)/2, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +(df2-q1)/2);
LineSeg[12] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +(df2-q1)/2, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +Dcm2/2);
LineSeg[13] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-q2)/2+q2, y0 +Dcm2/2,  x0 + da2 / 2+30+Lcm2, y0 +Dcm2/2);
LineSeg[14] := AddLine(LSS, x0 + da2 / 2+30+Lcm2, y0 +Dcm2/2, x0 + da2 / 2+30+Lcm2, y0 +dv2/2);
LineSeg[15] := AddLine(LSS, x0 + da2 / 2+30+Lcm2, y0 +dv2/2, x0 + da2 / 2+30, y0 + dv2 / 2);
LineSeg[16] := AddLine(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 + da2/2-h, x0 + da2 / 2+30+(Lcm2-b2)/2, y0 + da2/2-h);
LineSeg[17] := AddLine2(LSS, x0 + da2 / 2+30+(Lcm2-b2)/2, y0+d2/2, x0 + da2 / 2+30+(Lcm2-b2)/2+b2, y0+d2/2);
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
