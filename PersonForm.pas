unit PersonForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm;

type
  TPersonFrm = class(TUniForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function PersonFrm: TPersonFrm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function PersonFrm: TPersonFrm;
begin
  Result := TPersonFrm(UniMainModule.GetFormInstance(TPersonFrm));
end;

end.
