{
  1. ���ٹ��
  - ��������� ������� csv, sql �������� ��ȯ
  - �׸����� ����Ʈ�� csv, sql �������� ��ȯ
  - Ȯ�强�� ����Ͽ� ��ȯ ������ �����Ҽ��ֵ��� ����
  - �������� �������Ȯ�� �� �ߴ��� �����Ҽ��ְ� ������ ó��

  * ȭ�鼳��
  1. �׸���, ���α׷�����, ��������/�ߴܹ�ư , ���̾�α�, �޸� , �������̺�
  - �׸��� : ��µ� �����͸� �������԰� , ��ȯ�� ���
  - ���α׷����� : �����ͳ������� ���¸� Ȯ��
  - ��������/�ߴܹ�ư : �����ͳ�������,�ߴ��� ���� �������
  - ���̾�α� : ������ �����μ����� ���� ��ư
  - �޸� : �����ͳ������� ��������� Ȯ���ϱ�����

  * ���α׷�����
  1. ������ ��ȯ CSV, SQL ���� ���� Ȯ�尡���� ���ν����� �ۼ�
  2. ������ ��ȯ�� �͸������ ó��
  3. �������̺��� ���� ������ ������ ����

  �� ������
  1. CSV, SQL ���信 ���� ���ص� ����
  �ذ� : ���۸� -> SQLGate�� ��ȯ�� ���ϵ��� �м��Ͽ� ������ ��ȯ���¸� �ľ� }

unit Main;

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
  cxStyles ,
  cxCustomData ,
  cxFilter ,
  cxData ,
  cxDataStorage ,
  cxEdit ,
  cxNavigator ,
  Data.DB ,
  cxDBData ,
  dxLayoutContainer ,
  dxLayoutcxEditAdapters ,
  dxLayoutControlAdapters ,
  cxContainer ,
  Vcl.Menus ,
  cxTextEdit ,
  cxMemo ,
  Vcl.StdCtrls ,
  cxButtons ,
  cxProgressBar ,
  cxGridLevel ,
  cxClasses ,
  cxGridCustomView ,
  cxGridCustomTableView ,
  cxGridTableView ,
  cxGridDBTableView ,
  cxGrid ,
  dxLayoutControl ,
  DBAccess ,
  Uni ,
  dxmdaset ,
  cxLabel ,
  dxSkinOffice2016Colorful ,
  dxSkinOffice2016Dark ,
  dxSkinVisualStudio2013Blue ,
  dxSkinVisualStudio2013Dark ,
  dxSkinVisualStudio2013Light ,
  MemDS ,
  VirtualTable;

type
  TDataType = (CSV = 0 , SQL = 1);

type
  TMainF = class(TForm)
    dxLayoutControl1Group_Root : TdxLayoutGroup;
    dxLayoutControl1 : TdxLayoutControl;
    cxGrid1DBTableView1 : TcxGridDBTableView;
    cxGrid1Level1 : TcxGridLevel;
    cxGrid1 : TcxGrid;
    dxLayoutItem1 : TdxLayoutItem;
    cxProgressBar1 : TcxProgressBar;
    dxLayoutItem2 : TdxLayoutItem;
    cxButton1 : TcxButton;
    dxLayoutItem3 : TdxLayoutItem;
    dxLayoutAutoCreatedGroup1 : TdxLayoutAutoCreatedGroup;
    cxMemo1 : TcxMemo;
    dxLayoutItem4 : TdxLayoutItem;
    dxLayoutAutoCreatedGroup2 : TdxLayoutAutoCreatedGroup;
    dxMemData1 : TdxMemData;
    dxMemData1Num : TAutoIncField;
    dxMemData1Name : TStringField;
    dxMemData1InputTime : TDateTimeField;
    UniDataSource1 : TUniDataSource;
    cxGrid1DBTableView1RecId : TcxGridDBColumn;
    cxGrid1DBTableView1Num : TcxGridDBColumn;
    cxGrid1DBTableView1Name : TcxGridDBColumn;
    cxGrid1DBTableView1InputTime : TcxGridDBColumn;
    SaveDialog1 : TSaveDialog;
    VirtualTable1 : TVirtualTable;
    procedure FormCreate(Sender : TObject);
    procedure cxButton1Click(Sender : TObject);
  private
    FRunning : Boolean;
    FThread : TThread;
    sFilePath : string;
    SW: TStreamWriter;
    { Private declarations }
    procedure NP_DataExport;
    procedure NP_CreateData;
    procedure SetRunning(const Value : Boolean);
    procedure SetThread(const Value : TThread);
    procedure SetFilePath(const Value : string);
    procedure SetSW(const Value: TStreamWriter);
  public
    { Public declarations }
    property isFilePath : string read sFilePath write SetFilePath; // ���ϰ��
    property isRunning : Boolean read FRunning write SetRunning; // ������ ���ۿ���
    property isThread : TThread read FThread write SetThread; // �͸�����
    property isSW : TStreamWriter read SW write SetSW; // �޸�
  end;

var
  MainF                                           : TMainF;

implementation

{$R *.dfm}

uses
  format;

procedure TMainF.cxButton1Click(Sender : TObject);
begin
  NP_DataExport;
end;

procedure TMainF.FormCreate(Sender : TObject);
begin
  //
  NP_CreateData;
end;

procedure TMainF.NP_CreateData;
var
  i                                               : Integer;
begin
  // ������ ����
  with dxMemData1 do
  begin
    Close;
    Open;
    DisableControls;
    for i := 1 to 1000 do
    begin
      Append;
      FieldByName('Num').AsInteger := i;
      FieldByName('Name').AsString := 'ȫ�浿' + IntToStr(i);
      FieldByName('InputTime').AsDateTime := Now;
    end;
    Post;
    First;
    EnableControls;
  end;
end;

procedure TMainF.NP_DataExport;

  procedure Clear;
  begin
    cxProgressBar1.Position := 0;
    cxProgressBar1.Properties.Text := '0';
    cxMemo1.Clear;
    dxMemData1.First;
  end;

var
  DataType                                        : TDataType;
  s                                               : string;
  txtFile                                         : TextFile;
  FS                                              : TStreamWriter;
  i                                               : Integer;
begin
  // SQLGate ����
  // 1. ������ �����ͺ��̽�, ���̺� ����
  // 2. �������� ���� dbf, txt/csv, xlsx/xls, sql, mdb
  // 3. ���οɼ� �ʵ屸�б�ȣ, �����ȳʺ�, �ʵ屸�б�ȣ ����, �ٹٲ�, ������ ����
  // 4. ���ϰ�μ���, �ִ� ���ڵ��, �������� ���Ͽ���, �������ڵ�����

  // ������ ��������
  // 1. ��μ���
  // 2. ������ �Ľ�
  // 3. ��������

  if isRunning then
  begin
    if MessageDlg('�������� �������� �۾��� �ֽ��ϴ� �ߴ��Ͻðڽ��ϱ�?' , mtInformation , [mbOk , mbNo] ,
      0) = mrOk then
    begin
      with FThread do
      begin
        if not Suspended then
          Suspend;                                // ��������� �����带 ����

        Terminate;                                // ������ ����
        SetRunning(False);
        SetFilePath('');
        SetThread(nil);
        SW.Close;
        SW.Free;
        Clear;
      end;
    end
    else
    begin
      with FThread do
      begin
        if Suspended then
          Start;

        SetRunning(True);
      end;
    end
  end
  else
  begin
    FormatF := TFormatF.Create(nil);
    // ���� ���� ����
    if FormatF.ShowModal = mrOk then
    begin
      // ��� ����
      if SaveDialog1.Execute then
      begin
        // Ȯ���� ����
        DataType := TDataType(FormatF.cxRadioGroup1.ItemIndex);
        case DataType of
          CSV :
            begin
              SaveDialog1.Filter := '.csv|csv';
              sFilePath := SaveDialog1.FileName + '.csv';
            end;
          SQL :
            begin
              SaveDialog1.Filter := '.sql|sql';
              sFilePath := SaveDialog1.FileName + '.sql';
            end;
        end;

        // �͸����� ����
        FThread := TThread.CreateAnonymousThread(procedure
        var
          i                                               : Integer;
        begin
          TThread.Synchronize(FThread,
          procedure
          begin
            SetSW(TStreamWriter.Create(sFilePath , False,  TEncoding.UTF8)); //�ۼ����ϻ���
            SetRunning(True); // ���� ����
          end);

          try
            with dxMemData1 do
            begin
              TThread.Synchronize(FThread,
              procedure
              begin
                DisableControls;
              end);

              cxProgressBar1.Properties.Max := Data.RecordCount;

              while not Eof do
              begin
                s := '';

                case DataType of
                  CSV :
                    begin
                      for i := 0 to FieldList.Count - 1 do
                      begin
                        if i < FieldList.Count - 1 then
                          s := s + FieldList[i].AsString + ','
                        else
                          s := s + FieldList[i].AsString;
                      end;
                    end;
                  SQL :
                    begin
                      s := 'INSERT INTO TABLENAME ' + #13#10 + '(';
                      for i := 0 to FieldList.Count - 1 do
                      begin
                        if i < FieldList.Count - 1 then
                          s := s + FieldList[i].FieldName + ','
                        else
                          s := s + FieldList[i].FieldName + ')' + #13#10;
                      end;
                      s := s + 'VALUES (';
                      for i := 0 to FieldList.Count - 1 do
                      begin
                        if i < FieldList.Count - 1 then
                        begin
                          // ������ Ÿ�Կ� ���� �� ó��
                          case FieldList[i].DataType of
                            ftString :
                              begin
                                s := s + '''' + FieldList[i].AsString + '''' + ',';
                              end;
                          else
                            begin
                              s := s + FieldList[i].AsString + ',';
                            end;
                          end;

                        end
                        else
                          s := s + FieldList[i].AsString + ');';
                      end;
                    end;
                else
                  begin

                  end;
                end;
                TThread.Synchronize(FThread,
                procedure
                begin
                // �������¿� ���� ���� �ۼ�
                  cxMemo1.Lines.Add(s);
                  SW.WriteLine(s);
                  // �۾� �� ���°� ����
                  cxProgressBar1.Properties.Text := IntToStr(RecNo) + ' / ' + IntToStr(Data.RecordCount);
                  cxProgressBar1.Position := cxProgressBar1.Position + 1;
                  cxProgressBar1.Update;
                  Application.ProcessMessages;
                end);
                Next;
              end;
              TThread.Synchronize(FThread,
              procedure
              begin
                EnableControls;
              end);
            end;
          finally
            TThread.Synchronize(FThread,
            procedure
            begin
              SetRunning(False);
              SW.Close;
              SW.Free;
            end);
          end;
        end);
        FThread.Start;
      end;
    end;
    FormatF.Free;
  end;
end;

procedure TMainF.SetFilePath(const Value : string);
begin
  sFilePath := Value;
end;

procedure TMainF.SetRunning(const Value : Boolean);
begin
  FRunning := Value;

  if FRunning then
  begin
    cxButton1.Caption := '�ߴ�'
  end
  else
  begin
    cxButton1.Caption := '����';
  end;

end;

procedure TMainF.SetSW(const Value: TStreamWriter);
begin
  SW := Value;
end;

procedure TMainF.SetThread(const Value : TThread);
begin
  FThread := Value;
end;


end.

