{ JCC (Jan's Chess Componenents) - This file contains constants and functions to handle bitboards
  Copyright (C) 2016  Jan Dette

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
}
unit BitBoard;

{$mode objfpc}{$H+}{$J-}

interface

uses
  Classes, SysUtils;

// We map a 8x8 board from the upper left corner (a8) to the lower right corner (h1)
// by going left to right and then up to down.
// So a8 would be 2^0 and h1 is 2^63

type
  TBitBoard = QWord;

const
  // From 1 to 8
  Ranks: array[1..8] of TBitBoard =
    (18374686479671623680, 71776119061217280, 280375465082880,
    1095216660480, 4278190080, 16711680, 65280, 255);

  // From A to H
  Files: array[1..8] of TBitBoard =
    (72340172838076673, 144680345676153346, 289360691352306692, 578721382704613384,
    1157442765409226768, 2314885530818453536, 4629771061636907072, 9259542123273814144);

  // Diagonals from top left to bottom right
  Diagonals: array[1..15] of TBitBoard =
    (1, 258, 66052, 16909320, 4328785936, 1108169199648,
    283691315109952, 72624976668147840, 145249953336295424,
    290499906672525312, 580999813328273408, 1161999622361579520,
    2323998145211531264, 4647714815446351872, 9223372036854775808);

  // Anti-Diagonals from top right to bottom left
  AntiDiagonals: array[1..15] of TBitBoard =
    (128, 32832, 8405024, 2151686160, 550831656968,
    141012904183812, 36099303471055874, 9241421688590303745, 4620710844295151872,
    2310355422147575808, 1155177711073755136, 577588855528488960,
    288794425616760832, 144396663052566528, 72057594037927936);

function BitBoardToStr(ABitBoard: TBitBoard): string;
function IsBitSet(ABitBoard: TBitBoard; Index: byte): boolean;
function NumberOfLeadingZeroes(const ABitBoard: TBitBoard): integer;
function NumberOfTrailingZeroes(const ABitBoard: TBitBoard): integer;
function ReverseBitBoard(ABitBoard: TBitBoard): TBitBoard;

implementation

function BitBoardToStr(ABitBoard: TBitBoard): string;
var
  j: integer;
begin
  Result := '';
  for j := 1 to 64 do
  begin
    if (ABitBoard and 1) = 1 then
      Result := Result + '1'
    else
      Result := Result + '0';
    ABitBoard := ABitBoard shr 1;
  end;
  for j := 8 downto 1 do
    Insert(LineEnding, Result, j * 8 + 1);
end;

function IsBitSet(ABitBoard: TBitBoard; Index: byte): boolean;
begin
  Result := ((ABitBoard shr Index) and 1) = 1;
end;

function NumberOfLeadingZeroes(const ABitBoard: TBitBoard): integer;
begin
  Result := 63 - BsrQWord(ABitBoard);
end;

function NumberOfTrailingZeroes(const ABitBoard: TBitBoard): integer;
begin
  Result := BsfQWord(ABitBoard);
end;

function ReverseBitBoard(ABitBoard: TBitBoard): TBitBoard;
var
  i: integer;
begin
  Result := 0;
  // quick 'n' dirty
  for i := 1 to 63 do
  begin
    Result := Result + (ABitBoard and 1);
    ABitBoard := ABitBoard shr 1;
    Result := Result shl 1;
  end;
  Result := Result + (ABitBoard and 1);
end;

end.
