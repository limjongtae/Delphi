unit Format;

interface

uses
  Winapi.Windows ,
  Winapi.Messages ,
  System.SysUtils ,
  System.Variants ,
  System.Classes ,
  Vcl.Graphics ,
  Vcl.Controls ,
  Vcl.Forms ,
  Vcl.Dialogs ,
  cxGraphics ,
  cxControls ,
  cxLookAndFeels ,
  cxLookAndFeelPainters ,
  dxSkinsCore ,
  dxSkinGolfzon ,
  dxSkinscxPCPainter ,
  cxContainer ,
  cxEdit ,
  dxLayoutcxEditAdapters ,
  dxLayoutControlAdapters ,
  Vcl.Menus ,
  dxLayoutContainer ,
  Vcl.StdCtrls ,
  cxButtons ,
  cxGroupBox ,
  cxRadioGroup ,
  cxClasses ,
  dxLayoutControl;

type
  TFormatF = class(TForm)
    dxLayoutControl1Group_Root : TdxLayoutGroup;
    dxLayoutControl1 : TdxLayoutControl;
    dxLayoutItem1 : TdxLayoutItem;
    cxRadioGroup1 : TcxRadioGroup;
    cxButton1 : TcxButton;
    dxLayoutItem2 : TdxLayoutItem;
    cxButton2 : TcxButton;
    dxLayoutItem3 : TdxLayoutItem;
    dxLayoutAutoCreatedGroup1 : TdxLayoutAutoCreatedGroup;
    procedure cxButton2Click(Sender : TObject);
    procedure cxButton1Click(Sender : TObject);
    procedure FormCreate(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormatF                                         : TFormatF;

implementation

{$R *.dfm}

procedure TFormatF.cxButton1Click(Sender : TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormatF.cxButton2Click(Sender : TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormatF.FormCreate(Sender : TObject);
begin
  cxRadioGroup1.ItemIndex := 0;
end;

end.

