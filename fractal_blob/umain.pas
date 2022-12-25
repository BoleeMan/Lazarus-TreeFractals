{
 Fractal Tree
 Based on https://www.rosettacode.org/wiki/Fractal_tree#JavaScript
 2018 by Lainz
}

unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  BGRAVirtualScreen, BGRABitmap, BCTypes, BGRABitmapTypes, Types,
  Math;

const
  deg_to_rad = pi / 180;

type

  { TfrmFractalTree }

  TfrmFractalTree = class(TForm)
    vsCanvas: TBGRAVirtualScreen;
    procedure FormCreate(Sender: TObject);
    procedure vsCanvasMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure vsCanvasMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure vsCanvasRedraw(Sender: TObject; Bitmap: TBGRABitmap);
  private
    multiplier: single;
  public

  end;

var
  frmFractalTree: TfrmFractalTree;

implementation

{$R *.lfm}

{ TfrmFractalTree }

procedure TfrmFractalTree.vsCanvasRedraw(Sender: TObject; Bitmap: TBGRABitmap);

procedure drawLine(x1, y1, x2, y2, depth: single);
begin
  Bitmap.DrawLineAntialias(x1, y1, x2, y2, BGRABlack, depth, False);
end;

procedure drawTree(x1, y1, angle, depth: single);
var
  x2, y2: single;
begin
  if (depth > 0) then
  begin
    x2 := x1 + (cos(angle * deg_to_rad) * depth * multiplier);
    y2 := y1 + (sin(angle * deg_to_rad) * depth * multiplier);
    drawLine(x1, y1, x2, y2, depth);


    drawTree(x2, y2, angle - 28 , depth - 2);
    drawTree(x2, y2, angle + 28 , depth - 2);

   end;
 end;

 begin
    Bitmap.GradientFill(0, 0, Bitmap.Width, Bitmap.Height, clSkyBlue, BGRA(90,235,125), gtLinear, PointF(0,0), PointF(0, Bitmap.Height), dmSet);
   drawTree(Bitmap.Width div 2, Bitmap.Height - Bitmap.Height / 2, -1+45, 19);
   drawTree(Bitmap.Width div 2, Bitmap.Height - Bitmap.Height / 2, -91+45, 19);
   drawTree(Bitmap.Width div 2, Bitmap.Height - Bitmap.Height / 2, -181+45, 19);
   drawTree(Bitmap.Width div 2, Bitmap.Height - Bitmap.Height / 2, -271+45, 19);
end;

procedure TfrmFractalTree.vsCanvasMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  // zoom out
  multiplier -= 0.25;
  if multiplier <= 0 then
    multiplier := 0.25;

  vsCanvas.DiscardBitmap;
end;

procedure TfrmFractalTree.FormCreate(Sender: TObject);
begin
  // default zoom
  multiplier := 3.8;
end;

procedure TfrmFractalTree.vsCanvasMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  // zoom in
  multiplier += 0.25;

  vsCanvas.DiscardBitmap;
end;

end.
