unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,graph3d, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   h:Trender3D;
    ii:TbitMap;
    tt,t,t1:double;

  AI:PRGB;
  AB:PRGB;
  i,j:integer;
  B,b1:TBitMap;
    tr:Ttriangles;
    v1,v2:array[0..100,0..100] of TVertex3D2D;
    col:array[0..100,0..100] of byte;
    Tex:TTexture;
    f:boolean;

implementation

{$R *.dfm}
procedure DrawTex  ;
  var
 RT:byte;
begin

b1.Canvas.FillRect(rect(0,0,500,500));
 for i:=0 to 499  do begin

    for j:=0 to 499 do begin
           tex.Texture[i][j].r:=ab[i][j].r;
      tex.Texture[i][j].g:=ab[i][j].r;
       tex.Texture[i][j].b:=ab[i][j].r;

        if (ab[i][j].r<tt+3) and (ab[i][j].r>(tt-3)) then
       begin

      tex.Texture[i][j].r:=ab[i][j].r;
      tex.Texture[i][j].g:=ab[i][j].r;
       tex.Texture[i][j].b:=ab[i][j].r;
        end;
         if (ab[i][j].r<tt+3) then
       begin
      tex.Texture[i][j].r:=255;
      tex.Texture[i][j].g:=0;
       tex.Texture[i][j].b:=0;
        end;
       if (ab[i][j].r>tt) and (ab[i][j].r<tt+3) then
       begin
       tex.Texture[i][j].r:=255-ab[i][j].r;
      tex.Texture[i][j].g:=255-ab[i][j].r;
       tex.Texture[i][j].b:=255-ab[i][j].r;
        end;
    if (i mod 20 =0) or (j mod 40 =0) then begin
    tex.Texture[i][j].r:=0;
      tex.Texture[i][j].g:=255-ab[i][j].r;
       tex.Texture[i][j].b:=0;
     end;
    end; 
end;
 end;
 
procedure TForm1.Timer1Timer(Sender: TObject);
var
i,j:integer;
c:byte;
begin
if f=true then tt:=tt+1 else tt:=tt-1;
DrawTex;
 h.FillZBuffer;
 t1:=t1+1;
 t:=t+1;
ii.Canvas.FillRect(Rect(0,0,640,480));
h.MoveKamera(700*cos(t/100)*sin(t/300),800*cos(t/200),700*sin(t/100));
 h.SetPointKamera(0,0,0);
  for i:=0 to 50 do
    for j:=0 to 100 do
    begin
    h.xyz2D(v2[i,j]) ;
    end;
  for i:=0 to 49 do
    for j:=0 to 99 do
    begin
    h.FillTriangle(v2[i,j],v2[i,j+1],v2[i+1,j],col[i,j],0,0);
   h.FillTriangle(v2[i,j+1],v2[i+1,j+1],v2[i+1,j],col[i,j],0,0);
    end;
    h.Fog.R:=0;
    h.Fog.g:=0;
    h.Fog.b:=0;
    h.Fog.L:=600;
    //  h.CreateFog;
       Form1.Canvas.stretchDraw(rect(0,0,clientwidth,clientheight),ii);
         if tt>254 then begin;f:=False end;
         if tt<1 then begin ;f:=true end;
end;

procedure TForm1.FormCreate(Sender: TObject);
 var
i,j:integer;
k:integer;
begin
 B:=TBitMap.Create;
B1:=TBitMap.Create;
b1.PixelFormat:=pf24bit;
b1.Width:=500;
b1.Height:=500;
B.Assign(Image1.Picture.Bitmap);
b1.Canvas.Brush.Color:=0;
 image1.Canvas.Pen.Color:=rgb(0,0,0);
 for j:=0 to 499  do begin
       AB[j]:=B.ScanLine[j];
       AI[j]:=b1.ScanLine[j];
end;
  ii:=TBitMAp.Create;
ii.PixelFormat:=pf24bit;
h:=Trender3D.Create(640,480,ii);
h.RotateKamera(0,0,1);
  h.NoneFace:=true;
 ii.Canvas.Brush.Color:=rgb(0,0,0);
Timer1.Enabled :=true;
h.BitMapToPointer(Tex.Texture,b1);
tex.width:=499;
tex.height:=499;
h.Texture:=@tex;
h.TextureEnabled:=true;
k:=0;
for i:=0 to 50 do
    for j:=0 to 100 do
        begin

            v2[i,j].TX:=9.98*i;
            v2[i,j].Ty:=4.99*j;
            v1[i,j].X3DM:=(300+AB[round(4.99*j),round(9.98*i)].g)*sin(pi2*i/100)*cos(pi2*j/100);
            v1[i,j].Y3DM:=500*cos(pi2*i/100);
            v1[i,j].Z3DM:=(300+AB[round(4.99*j),round(9.98*i)].g)*sin(pi2*i/100)*sin(pi2*j/100);
        end;
    for i:=0 to 50 do
    for j:=0 to 100 do
    begin
    v2[i,j].y3DM:=v1[i,j].y3DM;
    v2[i,j].X3DM:=v1[i,j].x3DM;
    v2[i,j].z3DM:=v1[i,j].z3DM;
    end;

end;

end.
