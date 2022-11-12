unit Import;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.ListBox, FMX.Controls.Presentation;

type
  TFrmImport = class(TForm)
    LblImportDatabaseName: TLabel;
    CbxImport: TComboBox;
    LbiKaspersky: TListBoxItem;
    OpenDialogImport: TOpenDialog;
    BtnOpen: TButton;
    MemoImport: TMemo;
    BtnImport: TButton;
    AniIndicator1: TAniIndicator;
    procedure BtnImportClick(Sender: TObject);
  private
    { Private declarations }
    function ReadTextFile(sFile: string): boolean;
  public
    { Public declarations }
  end;

var
  FrmImport: TFrmImport;

implementation

{$R *.fmx}

uses DataModule;

procedure pSplitIT(BreakString, BaseString: string; StringList: TStrings; ForceRightSideOfBreakString: boolean = false; Offset: integer = 1);
var
  EndOfCurrentString: byte;
  iLengthenBreakString: integer;
begin
  StringList.Clear;

  iLengthenBreakString := 0;

  // if the BreakString is greater than 1, it will force the break to be on the right side
  // of the BreakString instead of the left side
  if ForceRightSideOfBreakString = true then
    if length(BreakString) > 0 then iLengthenBreakString := length(BreakString);

  repeat
    if Offset = 1 then
      EndOfCurrentString := Pos(BreakString, BaseString) + iLengthenBreakString
    else
      EndOfCurrentString := Pos(BreakString, BaseString, Offset) + iLengthenBreakString;

    if EndOfCurrentString > length(BaseString) then EndOfCurrentString := length(BaseString);

    if EndOfCurrentString = 0 then
      StringList.add(BaseString)
    else
      StringList.add(Copy(BaseString, 1, EndOfCurrentString - 1));
    BaseString := Copy(BaseString, EndOfCurrentString + length(BreakString), length(BaseString) - EndOfCurrentString);

  until EndOfCurrentString = 0;
end;

function TFrmImport.ReadTextFile(sFile: string): boolean;
var
  Txt: TextFile;
  s: string;
  iTmp : integer;
  sWebsiteName,sURL,sLoginName,sLogin,sPassword,sComment,sName,sText: string;
  OutPutList: TStringList;
  AddEntry, SkipReadLine: boolean;
begin
  result := false;
  if FileExists(sFile) = false then exit;

  AniIndicator1.Enabled := true;

  AddEntry := false;

  OutPutList := TStringList.Create;

  AssignFile(Txt, sFile);
  Reset(Txt);  // open file for reading
  while not Eof(Txt) do
  begin
    if SkipReadLine = true then
    begin
      SkipReadLine := false;
    end
    else
    begin
      Readln(Txt, s);
    end;

    if Pos('Website name:', s) > 0 then
      begin
        pSplitIT('Website name:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then sWebsiteName := Trim(OutPutList[1]);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Website URL:', s) > 0 then
      begin
        pSplitIT('Website URL:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then sURL := Trim(OutPutList[1]);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Login name:', s) > 0 then
      begin
        pSplitIT('Login name:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then sLoginName := Trim(OutPutList[1]);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Password:', s) > 0 then
      begin
        pSplitIT('Password:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then sPassword := Trim(OutPutList[1]);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Name:', s) > 0 then
      begin
        pSplitIT('Name:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then sName := Trim(OutPutList[1]);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    // multi-line

    if Pos('Comment:', s) > 0 then
      begin
        pSplitIT('Comment:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then
        begin
          sComment := Trim(OutPutList[1]);
          while not Eof(Txt) do
          begin
            Readln(Txt, s);

            if Pos('Website name:', s) > 0 then
            begin
              SkipReadLine := true;
              break;
            end
            else if Pos('Name:', s) > 0 then
            begin
              SkipReadLine := true;
              break;
            end
            else
              begin
                sComment := sComment + s;
              end;
          end;
          AddEntry := true;
        end;
      end;

    if Pos('Text:', s) > 0 then
      begin
        pSplitIT('Text:',s,OutPutList,true); // split on right side
        if OutPutList.Count > 1 then
        begin
          sText := Trim(OutPutList[1]);
          while not Eof(Txt) do
          begin
            Readln(Txt, s);

            if Pos('Website name:', s) > 0 then
            begin
              SkipReadLine := true;
              break;
            end
            else if Pos('Name:', s) > 0 then
            begin
              SkipReadLine := true;
              break;
            end
            else
              begin
                sText := sText + s;
              end;
          end;
          AddEntry := true;
        end;
      end;

    // Save to Database
    if AddEntry = true then
     begin

      // STUCK RIGHT HERE TRYING TO ADD / INSERT INTO DATABASE BY CODE

      DM.FDQueryImportAdd.SQ
     end;
  end;
  CloseFile(Txt);

  OutPutList.Free;

  AniIndicator1.Enabled := false;

  result := true
end;

procedure TFrmImport.BtnImportClick(Sender: TObject);
begin
  //OpenDialogImport

  // Display the open file dialog
  if OpenDialogImport.Execute
    then ShowMessage('File : '+OpenDialogImport.FileName)
    else ShowMessage('Open file was cancelled');
end;

end.
