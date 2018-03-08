﻿unit LUX.GPU.OpenGL.Shaper.Preset.TMarcubes;

interface //#################################################################### ■

uses Winapi.OpenGL, Winapi.OpenGLext,
     LUX, LUX.D2, LUX.D3, LUX.M4,
     LUX.GPU.OpenGL,
     LUX.GPU.OpenGL.Atom.Buffer.Unifor,
     LUX.GPU.OpenGL.Atom.Imager.D2.Preset,
     LUX.GPU.OpenGL.Atom.Imager.D3.Preset,
     LUX.GPU.OpenGL.Matery,
     LUX.GPU.OpenGL.Shaper;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TMarcubes = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarcubesMateryFaces

     IMarcubesMateryFaces = interface( IGLMateryNorTexG )
     ['{1FD800E2-12D5-4021-825F-368CEFFEFAA5}']
     {protected}
     {public}
     end;

     //-------------------------------------------------------------------------

     TMarcubesMateryFaces = class( TGLMateryNorTexG, IMarcubesMateryFaces )
     private
     protected
       _Imager :TGLBricer2D_TAlphaColorF;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Imager :TGLBricer2D_TAlphaColorF read _Imager;
       ///// メソッド
       procedure Use; override;
       procedure Unuse; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarcubesMateryCells

     IMarcubesMateryCells = interface( IGLMateryNorTexG )
     ['{9FD0E274-E7F3-4B90-85A5-21B0C52FC9CB}']
     {protected}
     {public}
     end;

     //-------------------------------------------------------------------------

     TMarcubesMateryCells = class( TGLMateryNorTexG, IMarcubesMateryCells )
     private
     protected
     public
       constructor Create;
       destructor Destroy; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarcubes

     TMarcubes = class( TGLShaperZeroPoins )
     private
     protected
       _MaterC :IMarcubesMateryCells;
       _Grider :TGLGrider3D_Single;
       _Size   :TGLUnifor<TSingle3D>;
       _LineS  :Single;
       ///// アクセス
       function GetSizeX :Single;
       procedure SetSizeX( const SizeX_:Single );
       function GetSizeY :Single;
       procedure SetSizeY( const SizeY_:Single );
       function GetSizeZ :Single;
       procedure SetSizeZ( const SizeZ_:Single );
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Grider :TGLGrider3D_Single read   _Grider               ;
       property SizeX  :Single             read GetSizeX  write SetSizeX;
       property SizeY  :Single             read GetSizeY  write SetSizeY;
       property SizeZ  :Single             read GetSizeZ  write SetSizeZ;
       property LineS  :Single             read   _LineS  write   _LineS;
       ///// メソッド
       procedure BeginDraw; override;
       procedure EndDraw; override;
       procedure MakeModel;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarcubesMateryFaces

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMarcubesMateryFaces.Create;
begin
     inherited;

     with _Engine do
     begin
          with Verters do
          begin
               Del( 0{BinP} );
               Del( 1{BinP} );
               Del( 2{BinP} );
          end;

          with Unifors do
          begin
               Add( 4{BinP}, 'TGriderS'{Name} );
          end;

          with Imagers do
          begin
               Add( 0{BinP}, '_Grider'{Name} );
               Add( 1{BinP}, '_Imager'{Name} );
          end;

          ShaderV.LoadFromResource( 'LUX_GPU_OpenGL_Shaper_Preset_TMarcubes_FacesV_glsl' );
          ShaderG.LoadFromResource( 'LUX_GPU_OpenGL_Shaper_Preset_TMarcubes_FacesG_glsl' );
          ShaderF.LoadFromResource( 'LUX_GPU_OpenGL_Shaper_Preset_TMarcubes_FacesF_glsl' );
     end;

     _Imager := TGLBricer2D_TAlphaColorF.Create;
end;

destructor TMarcubesMateryFaces.Destroy;
begin
     _Imager.DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TMarcubesMateryFaces.Use;
begin
     inherited;

     _Imager.Use( 1 );
end;

procedure TMarcubesMateryFaces.Unuse;
begin
     _Imager.Unuse( 1 );

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarcubesMateryCells

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMarcubesMateryCells.Create;
begin
     inherited;

     with _Engine do
     begin
          with Verters do
          begin
               Del( 0{BinP} );
               Del( 1{BinP} );
               Del( 2{BinP} );
          end;

          with Unifors do
          begin
               Add( 4{BinP}, 'TGriderS'{Name} );
          end;

          with Imagers do
          begin
               Add( 0{BinP}, '_Grider'{Name} );
          end;

          ShaderV.LoadFromResource( 'LUX_GPU_OpenGL_Shaper_Preset_TMarcubes_CellsV_glsl' );
          ShaderG.LoadFromResource( 'LUX_GPU_OpenGL_Shaper_Preset_TMarcubes_CellsG_glsl' );
          ShaderF.LoadFromResource( 'LUX_GPU_OpenGL_Shaper_Preset_TMarcubes_CellsF_glsl' );
     end;
end;

destructor TMarcubesMateryCells.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMarcubes

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TMarcubes.GetSizeX :Single;
begin
     Result := _Size[ 0 ].X;
end;

procedure TMarcubes.SetSizeX( const SizeX_:Single );
begin
     _Size[ 0 ] := TSingle3D.Create( SizeX_, SizeY, SizeZ );
end;

function TMarcubes.GetSizeY :Single;
begin
     Result := _Size[ 0 ].Y;
end;

procedure TMarcubes.SetSizeY( const SizeY_:Single );
begin
     _Size[ 0 ] := TSingle3D.Create( SizeX, SizeY_, SizeZ );
end;
function TMarcubes.GetSizeZ :Single;
begin
     Result := _Size[ 0 ].Z;
end;

procedure TMarcubes.SetSizeZ( const SizeZ_:Single );
begin
     _Size[ 0 ] := TSingle3D.Create( SizeX, SizeY, SizeZ_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TMarcubes.Create;
begin
     inherited;

     _Grider := TGLGrider3D_Single.Create;
     _Size   := TGLUnifor<TSingle3D>.Create( GL_STATIC_DRAW );  _Size.Count := 1;

     _Matery := TMarcubesMateryFaces.Create;
     _MaterC := TMarcubesMateryCells.Create;

     with Grider.Texels do
     begin
          MargsX := 1;
          MargsY := 1;
          MargsZ := 1;
          BricsX := 100;
          BricsY := 100;
          BricsZ := 100;
     end;

     SizeX := 2;
     SizeY := 2;
     SizeZ := 2;

     _LineS := 1;
end;

destructor TMarcubes.Destroy;
begin
     _Grider.DisposeOf;
     _Size  .DisposeOf;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TMarcubes.BeginDraw;
begin
     inherited;

     _Grider.Use( 0 );
     _Size  .Use( 4 );
end;

procedure TMarcubes.EndDraw;
begin
     _MaterC.Use;

       glLineWidth( _LineS );

       DrawMain;

     _MaterC.Unuse;

     _Grider.Unuse( 0 );
     _Size  .Unuse( 4 );

     inherited;
end;

procedure TMarcubes.MakeModel;
begin
     with _Grider do
     begin
          SendData;

          with Texels do PoinsN := BricsX * BricsY * BricsZ;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■