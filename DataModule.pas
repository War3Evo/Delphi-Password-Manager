unit DataModule;

interface

uses

{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows,
{$ENDIF MSWINDOWS}

{$IFDEF ANDROID}
  Androidapi.Helpers, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
{$ENDIF ANDROID}

{$IFDEF MACOS}
  Macapi.Helpers,
  {$IFNDEF IOS}
    Macapi.Foundation, Macapi.AppKit, MacApi.CoreFoundation, MacApi.CoreGraphics,
    MacApi.KeyCodes, MacApi.CocoaTypes,
  {$ENDIF nIOS}
  {$IFDEF IOS}
    iOSapi.Foundation, FMX.Helpers.iOS, IdURI,
  {$ENDIF IOS}
{$ENDIF MACOS}

  System.SysUtils, System.Classes, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.FMXUI.Login, FireDAC.Comp.Client, fmx.dialogs,
  FMX.Types, System.UITypes, FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQuEntry: TFDQuery;
    dsEntry: TDataSource;
    FDSQLiteSecurity: TFDSQLiteSecurity;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDGUIxLoginDialog: TFDGUIxLoginDialog;
    FDQuEntryTitle: TStringField;
    FDQuEntryIcon: TBlobField;
    FDQuEntryUserN: TStringField;
    FDQuEntryPassw: TStringField;
    FDQuEntryDateC: TDateField;
    FDQuEntryDelete: TFDQuery;
    Lang: TLang;
    FDQuEntryMemoURL: TMemoField;
    FDQuEntryMemoNotes: TMemoField;
    procedure FDQuEntryNewRecord(DataSet: TDataSet);
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure LaunchBrowser(sURL: String);
    { Public-Deklarationen }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.FDConnectionAfterConnect(Sender: TObject);
begin
  // The maximum length of a VARCHAR2 data type is 4000 bytes.

  // SQLite blobs have an absolute maximum size of 2GB and a default maximum size of 1GB.
  {
      What is maximum length of a URL?  There is no fixed length, but recommended 2048.
      Since there is no maximum, we'll use BLOB for that
  }
  // select Title, Icon, UserN, Passw, URLpa, Notes, DateC from ENTRY changed to
  // select title, icon, username, password, url, notes, datetimedb from ENTRY

  // SQLite does not impose any length restrictions

  FDConnection.ExecSQL(
  'CREATE TABLE IF NOT EXISTS ENTRY( '+
    'id INTEGER PRIMARY KEY, '+          // On an INSERT, if the ROWID or INTEGER PRIMARY KEY column is not explicitly given a value,
                                      // then it will be filled automatically with an unused integer, usually one more than the
                                      // largest ROWID currently in use.
                                      // This is true regardless of whether or not the AUTOINCREMENT keyword is used.

    'title VARCHAR(254), '+                   // Title should be longer ------- was 60      //VARCHAR2(254)
    'username VARCHAR(254), '+                 // A username can also be a email address, which can be larger than 40 characters //VARCHAR2(254)
                                            // This limits the Mailbox (i.e. the email address) to 254 characters
                                            // https://www.rfc-editor.org/errata_search.php?rfc=3696&eid=1690
    'password VARCHAR(64), '+            // 64 characters is max for sqlite as it only handles 32 bytes of password length // CHAR(64) NOT NULL
    'url VARCHAR(65535), '+                         // https://mywebshosting.com/what-is-the-maximum-url-length-limit-in-browsers/    // was VARCHAR2(100)
  //  'nickname TEXT, '+                 // VARCHAR2(20)     ???
  //  'CustN TEXT, '+                    // VARCHAR2(20)     ???
    'notes VARCHAR(65535), '+                          // Limit on notes??  Nope! BLOB     2 GB LIMIT    // was VARCHAR2(400)
    'datetimedb DATETIME, '+                   // TEXT as ISO8601 strings ("YYYY-MM-DD HH:MM:SS.SSS").
                                            // REAL as Julian day numbers, the number of days since noon in Greenwich on November 24, 4714 B.C. according to the proleptic Gregorian calendar.
                                            // INTEGER as Unix Time, the number of seconds since 1970-01-01 00:00:00 UTC.

    'icon IMAGE)');                          // I found no references where IMAGE is a correct Database type for sqlite or Delphi
end;

procedure TDM.FDQuEntryNewRecord(DataSet: TDataSet);
begin
  // https://stackoverflow.com/questions/37066250/delphi-xe7-multidevice-sql-error-timestamp-ret-field
  FDQuEntry.FieldByName('datetimedb').AsSQLTimeStamp       // was  .AsDateTime := Now;
end;

procedure TDM.LaunchBrowser(sURL: String);
{$IFDEF ANDROID}
var
  Intent: JIntent;
{$ENDIF ANDROID}

{$IFDEF IOS}
var
  URL: NSUrl;
{$ENDIF IOS}

{$IF Defined(MACOS) and not Defined(IOS)}
var
  URL: NSUrl;
  Workspace: NSWorkspace;
{$ENDIF MacOS}
begin
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(sURL), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}

{$IFDEF ANDROID}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(sURL));
  TAndroidHelper.Activity.startActivity(Intent);
{$ENDIF ANDROID}

{$IFDEF IOS}
  URL := StrToNSUrl(TIdURI.URLEncode(sURL));
  if SharedApplication.canOpenURL(URL) then
    SharedApplication.openUrl(URL);
{$ENDIF IOS}

{$IF Defined(MACOS) and not Defined(IOS)}
  URL := TNSURL.Wrap(TNSURL.OCClass.URLWithString(StrToNSStr(sURL)));
  Workspace := TNSWorkspace.Wrap(TNSWorkspace.OCClass.sharedWorkspace);
  Workspace.openURL(URL);
{$ENDIF MacOS}
end;

end.
