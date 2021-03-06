{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit JCC;

interface

uses
  Board, EngineView, ChessClock, StrTools, Game, Ply, PGNdbase, PGNGame, 
  BitBoard, NotationMemo, NotationToken, Geom2DTools, Database, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('Board', @Board.Register);
  RegisterUnit('EngineView', @EngineView.Register);
  RegisterUnit('ChessClock', @ChessClock.Register);
  RegisterUnit('NotationMemo', @NotationMemo.Register);
end;

initialization
  RegisterPackage('JCC', @Register);
end.
