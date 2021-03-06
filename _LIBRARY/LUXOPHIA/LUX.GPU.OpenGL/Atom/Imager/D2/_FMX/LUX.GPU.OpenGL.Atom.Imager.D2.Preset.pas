﻿unit LUX.GPU.OpenGL.Atom.Imager.D2.Preset;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX, LUX.GPU.OpenGL.Atom.Imager.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer2D_TAlphaColorF

     TGLBricer2D_TAlphaColorF = class( TGLBricer2D<TAlphaColorF> )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
       ///// メソッド
       procedure ImportFrom( const BMP_:TBitmap );
       procedure ExportTo( const BMP_:TBitmap );
       procedure LoadFromFile( const FileName_:String );
       procedure SaveToFile( const FileName_:String );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses Winapi.OpenGL, Winapi.OpenGLext;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TGLBricer2D_TAlphaColorF

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TGLBricer2D_TAlphaColorF.Create;
begin
     inherited;

     _TexelF := GL_RGBA;
     _PixelF := GL_RGBA;
     _PixelT := GL_FLOAT;
end;

destructor TGLBricer2D_TAlphaColorF.Destroy;
begin

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TGLBricer2D_TAlphaColorF.ImportFrom( const BMP_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     _Texels.BricsX := BMP_.Width ;
     _Texels.BricsY := BMP_.Height;

     BMP_.Map( TMapAccess.Read, B );

     for Y := 0 to _Texels.BricsY-1 do
     begin
          for X := 0 to _Texels.BricsX-1 do
          begin
               Texels[ X, Y ] := TAlphaColorF.Create( B.GetPixel( X, Y ) );
          end;
     end;

     BMP_.Unmap( B );

     SendData;
end;

procedure TGLBricer2D_TAlphaColorF.ExportTo( const BMP_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     BMP_.SetSize( _Texels.BricsX, _Texels.BricsY );

     BMP_.Map( TMapAccess.Write, B );

     for Y := 0 to _Texels.BricsY-1 do
     begin
          for X := 0 to _Texels.BricsX-1 do
          begin
               B.SetPixel( X, Y, Texels[ X, Y ].ToAlphaColor );
          end;
     end;

     BMP_.Unmap( B );
end;

//------------------------------------------------------------------------------

procedure TGLBricer2D_TAlphaColorF.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     ImportFrom( B );

     B.DisposeOf;
end;

procedure TGLBricer2D_TAlphaColorF.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     ExportTo( B );

     B.SaveToFile( FileName_ );

     B.DisposeOf;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■