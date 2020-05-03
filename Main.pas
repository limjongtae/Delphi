{
  1. 접근방법
  - 쿼리수행시 결과값을 csv, sql 포멧으로 변환
  - 그리드의 데이트를 csv, sql 포멧으로 변환
  - 확장성을 고려하여 변환 포멧을 지정할수있도록 설계
  - 내보내기 진행사항확인 및 중단을 수행할수있게 쓰레드 처리

  * 화면설계
  1. 그리드, 프로그레스바, 내보내기/중단버튼 , 다이얼로그, 메모 , 가상테이블
  - 그리드 : 출력된 데이터를 보기위함과 , 변환에 사용
  - 프로그레스바 : 데이터내보내기 상태를 확인
  - 내보내기/중단버튼 : 데이터내보내기,중단을 위한 수행로직
  - 다이얼로그 : 데이터 저장경로설정을 위한 버튼
  - 메모 : 데이터내보내기 진행사항을 확인하기위함

  * 프로그램설계
  1. 데이터 변환 CSV, SQL 포멧 추후 확장가능한 프로시저를 작성
  2. 데이터 변환시 익명쓰레드로 처리
  3. 가상테이블을 통한 임의의 데이터 생성

  ※ 문제점
  1. CSV, SQL 포멧에 대한 이해도 부족
  해결 : 구글링 -> SQLGate로 변환된 파일들을 분석하여 데이터 변환형태를 파악 }

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
    property isFilePath : string read sFilePath write SetFilePath; // 파일경로
    property isRunning : Boolean read FRunning write SetRunning; // 스레드 동작여부
    property isThread : TThread read FThread write SetThread; // 익명스레드
    property isSW : TStreamWriter read SW write SetSW; // 메모
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
  // 데이터 생성
  with dxMemData1 do
  begin
    Close;
    Open;
    DisableControls;
    for i := 1 to 1000 do
    begin
      Append;
      FieldByName('Num').AsInteger := i;
      FieldByName('Name').AsString := '홍길동' + IntToStr(i);
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
  // SQLGate 기준
  // 1. 내보낼 데이터베이스, 테이블 선택
  // 2. 파일유형 선택 dbf, txt/csv, xlsx/xls, sql, mdb
  // 3. 세부옵션 필드구분기호, 고정된너비, 필드구분기호 선택, 줄바꿈, 한정자 선택
  // 4. 파일경로선택, 최대 레코드수, 내보낸후 파일열기, 파일인코딩선택

  // 데이터 내보내기
  // 1. 경로설정
  // 2. 데이터 파싱
  // 3. 내보내기

  if isRunning then
  begin
    if MessageDlg('내보내기 진행중인 작업이 있습니다 중단하시겠습니까?' , mtInformation , [mbOk , mbNo] ,
      0) = mrOk then
    begin
      with FThread do
      begin
        if not Suspended then
          Suspend;                                // 실행상태의 쓰레드를 중지

        Terminate;                                // 쓰레드 종료
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
    // 파일 포멧 설정
    if FormatF.ShowModal = mrOk then
    begin
      // 경로 설정
      if SaveDialog1.Execute then
      begin
        // 확장자 설정
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

        // 익명쓰레드 생성
        FThread := TThread.CreateAnonymousThread(procedure
        var
          i                                               : Integer;
        begin
          TThread.Synchronize(FThread,
          procedure
          begin
            SetSW(TStreamWriter.Create(sFilePath , False,  TEncoding.UTF8)); //작성파일생성
            SetRunning(True); // 상태 변경
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
                          // 데이터 타입에 따른 값 처리
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
                // 포멧형태에 따른 문장 작성
                  cxMemo1.Lines.Add(s);
                  SW.WriteLine(s);
                  // 작업 후 상태값 갱신
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
    cxButton1.Caption := '중단'
  end
  else
  begin
    cxButton1.Caption := '실행';
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

