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

uses DataModule, EntryList, CodeSiteLogging;


////////////////////////////////////////////////////   GOING TO HAVE TO FIX THIS AREA
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////  NEED TO FIX SPLITIT SO THAT IT ONLY CUTS IN HALF AND NOT MULTIPLE!
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////
///////////////////////////////////////////////////


procedure pSplitIT(BreakString, BaseString: string; StringList: TStrings; ForceRightSideOfBreakString: boolean = false; Offset: integer = 1);
var
  EndOfCurrentString: byte;
  iLengthenBreakString, iCount: integer;
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

    if Pos(BreakString, BaseString) > 0 then break;

  until EndOfCurrentString = 0;
end;

function TFrmImport.ReadTextFile(sFile: string): boolean;
var
  Txt: TextFile;
  s: string;
  iTmp : integer;
  sWebsiteName,sURL,sLoginName,sLogin,sPassword,sComment,sName,sText: string;

//                 'values(:title, :username, :password, :url, :notes, :datetimedb)',
  srTitle, srUsername, srPassword,srURL,srNotes: string;

  srDateTimedb: TDate;

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
      CodeSite.Send('SkipReadLine = true');
    end
    else
    begin
      Readln(Txt, s);
      CodeSite.Send('Readln(Txt, s):'+s);
    end;

      srTitle := '';
      srUsername := '';
      srPassword := '';
      srURL := '';
      srNotes := '';

    if Pos('Website name:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:Website name:'+s);
        pSplitIT(':',s,OutPutList,true,1); // split on right side
        CodeSite.Send('Website name:Debug:OutPutList[0]:'+OutPutList[0]);
        if OutPutList.Count > 0 then sWebsiteName := Trim(OutPutList[0]);
        srTitle := sWebsiteName;
        CodeSite.Send('Website name:srTitle:'+srTitle);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Website URL:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:URL:'+s);
        pSplitIT(':',s,OutPutList,false,1); // split on right side
        CodeSite.Send('Website URL:Debug:OutPutList[0]:'+OutPutList[0]);
        if OutPutList.Count > 0 then sURL := Trim(OutPutList[0]);
        srURL := sURL;
        CodeSite.Send('srURL:'+srURL);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Login name:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:Login name:'+s);
        pSplitIT(':',s,OutPutList,false,1); // split on right side
        CodeSite.Send('Login name:Debug:OutPutList[1]:'+OutPutList[1]);
        if OutPutList.Count > 0 then sLoginName := Trim(OutPutList[1]);
        srUsername := sLoginName;
        CodeSite.Send('srUsername:'+srUsername);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Password:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:Password:'+s);
        pSplitIT(':',s,OutPutList,false,1); // split on right side
        CodeSite.Send('Password:Debug:OutPutList[1]:'+OutPutList[1]);
        if OutPutList.Count > 0 then sPassword := Trim(OutPutList[1]);
        srPassword := sPassword;
        CodeSite.Send('srPassword:'+srPassword);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    if Pos('Name:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:Name:'+s);
        pSplitIT(':',s,OutPutList,false,1); // split on right side
        CodeSite.Send('Name:Debug:OutPutList[1]:'+OutPutList[1]);
        if OutPutList.Count > 0 then sName := Trim(OutPutList[1]);
        srTitle := sName;
        CodeSite.Send('Name:srTitle:'+srTitle);
        if not Eof(Txt) then Readln(Txt, s);
        AddEntry := true;
      end;

    // multi-line

    if Pos('Comment:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:Comment:'+s);
        pSplitIT(':',s,OutPutList,false,1); // split on right side
        CodeSite.Send('Comment:Debug:OutPutList[1]:'+OutPutList[1]);
        if OutPutList.Count > 0 then
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
                sComment := sComment + #13#10 + s;
              end;
          end;
          srNotes := sComment;
          CodeSite.Send('srNotes:'+srNotes);
          AddEntry := true;
        end;
      end;

    if Pos('Text:', s) > 0 then
      begin
        CodeSite.Send('BeforeSplitIt:Text:'+s);
        pSplitIT(':',s,OutPutList,false,1); // split on right side
        CodeSite.Send('Text:Debug:OutPutList[1]:'+OutPutList[1]);
        if OutPutList.Count > 0 then
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
                sText := sText + #13#10 + s;
              end;
          end;
          srNotes := sText;
          CodeSite.Send('srNotes:'+srNotes);
          AddEntry := true;
        end;
      end;

    srDateTimedb := Now();

    // Save to Database
    if AddEntry = true then
     begin
      // STUCK RIGHT HERE TRYING TO ADD / INSERT INTO DATABASE BY CODE
        // Insert a record
    //  dbMain.ExecSQL('insert into Categories(CategoryName, Description, Picture) ' +
            //     'values(:N, :D, :P)', ['New category', 'New description', $0334]);

            //srTitle, srUsername, srPassword,srURL,srNotes: string;

      DM.FDConnection.ExecSQL('insert into ENTRY(title, username, password, url, notes, datetimedb) ' +
                 'values(:title, :username, :password, :url, :notes, :datetimedb)',
                  [srTitle, srUsername, srPassword, srURL, srNotes, srDateTimedb]);
      CodeSite.Send('after DM.FDConnection.ExecSQL');

      //DM.FDQuEntry.ExecSQL;
      srTitle := '';
      srUsername := '';
      srPassword := '';
      srURL := '';
      srNotes := '';
      AddEntry := false;
     end;

  end;
  CloseFile(Txt);

  OutPutList.Free;

  AniIndicator1.Enabled := false;

  result := true;
end;

procedure TFrmImport.BtnImportClick(Sender: TObject);
begin
  //OpenDialogImport

  // Display the open file dialog
  if OpenDialogImport.Execute
    then
    begin
      //ShowMessage('File : '+OpenDialogImport.FileName)
      if ReadTextFile(OpenDialogImport.FileName) = false then ShowMessage('File : '+OpenDialogImport.FileName+' not found');
    end
    else ShowMessage('Open file was cancelled');
end;

end.
