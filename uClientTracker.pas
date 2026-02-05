unit uClientTracker;

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
  System.SysUtils, System.Classes, System.DateUtils, IniFiles,
  uIdCustomHTTPServer, uIdCookie;

type
  TClientTracker = class
  private
    FFileName: string;
  public
    constructor Create(const AFileName: string);

    // Called from MainModule: reads cookie from UniSession.Request
    function ExtractClientIDFromRequest(AReq: TIdHTTPRequestInfo): string;

    // Called from MainModule: logs session start
    procedure LogSessionStart(const ClientID, SessionID, IP, UserAgent: string);
  end;

implementation

constructor TClientTracker.Create(const AFileName: string);
begin
  FFileName := AFileName;
end;

function TClientTracker.ExtractClientIDFromRequest(AReq: TIdHTTPRequestInfo): string;
var
  C: TIdCookie;
begin
  C := AReq.Cookies.Cookie['ClientID', ''];
  if Assigned(C) then
    Exit(C.Value);

  // No cookie → return empty string, MainModule will create one
  Result := '';
end;

procedure TClientTracker.LogSessionStart(const ClientID, SessionID, IP, UserAgent: string);
var
  Ini: TIniFile;
  Count: Integer;
begin
  if ClientID = '' then
    Exit;

  Ini := TIniFile.Create(FFileName);
  try
    Count := Ini.ReadInteger(ClientID, 'SessionCount', 0);
    Inc(Count);

    if Count = 1 then
      Ini.WriteDateTime(ClientID, 'FirstSeen', Now);

    Ini.WriteInteger(ClientID, 'SessionCount', Count);
    Ini.WriteString(ClientID, 'LastSessionID', SessionID);
    Ini.WriteDateTime(ClientID, 'LastSeen', Now);
    Ini.WriteString(ClientID, 'IP', IP);
    Ini.WriteString(ClientID, 'UserAgent', UserAgent);
  finally
    Ini.Free;
  end;
end;

end.


