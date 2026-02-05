unit ModuleRegistry;

/// ---------------------------------------------------------------------------
///  Copyright © 2026 RocketCitySoft LLC
///  https://www.rocketcitysoft.com
///
///  Author: Dmitry Konnov  (konnov72@gmail.com)
///  License: MGPL – Modified GNU Public License
///  This module requires attribution to the original author in derivative works.
///
///  History:
///    Jan 2026 – Initial version
/// ---------------------------------------------------------------------------

interface

uses
  System.Generics.Collections, System.SysUtils, UniGUIFrame, Data.DB;

type
  TModuleInfo = class
    Name: string;
    Icon: string;
    IconIndex: Integer;
    FrameClass: TUniFrameClass;
    MainQuery: string;
  end;

  TModuleRegistry = class
  private
    class var FList: TObjectList<TModuleInfo>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure RegisterModule(const AName: string; AIconIndex: Integer; AFrame: TUniFrameClass; AMainQueryName: string);
    class function GetModules: TObjectList<TModuleInfo>;
    class function FindModule(const AName: string): TModuleInfo;
  end;

implementation

class constructor TModuleRegistry.Create;
begin
  FList := TObjectList<TModuleInfo>.Create;
end;

class destructor TModuleRegistry.Destroy;
begin
  FList.Free;
end;

class procedure TModuleRegistry.RegisterModule(const AName: string; AIconIndex: Integer; AFrame: TUniFrameClass; AMainQueryName: string);
var
  M: TModuleInfo;
begin
  M := TModuleInfo.Create;
  M.Name := AName;
  M.IconIndex := AIconIndex;
  M.FrameClass := AFrame;
  M.MainQuery := AMainQueryName;
  FList.Add(M);
end;

class function TModuleRegistry.GetModules: TObjectList<TModuleInfo>;
begin
  Result := FList;
end;

class function TModuleRegistry.FindModule(const AName: string): TModuleInfo;
var
  M: TModuleInfo;
begin
  Result := nil;

  for M in FList do
    if SameText(M.Name, AName) then
      Exit(M);
end;


end.

