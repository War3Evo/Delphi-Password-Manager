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
    procedure BtnImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmImport: TFrmImport;

implementation

{$R *.fmx}

procedure TFrmImport.BtnImportClick(Sender: TObject);
begin
  //OpenDialogImport

  // Display the open file dialog
  if OpenDialogImport.Execute
    then ShowMessage('File : '+OpenDialogImport.FileName)
    else ShowMessage('Open file was cancelled');
end;

end.
