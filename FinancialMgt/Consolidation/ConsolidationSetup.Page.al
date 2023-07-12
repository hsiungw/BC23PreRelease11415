page 243 "Consolidation Setup"
{
    ApplicationArea = All;
    Caption = 'Consolidation Setup';
    PageType = Card;
    SourceTable = "Consolidation Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field(MaxAttempts; Rec.MaxAttempts)
            {
                Caption = 'Maximum number of retries';
                ApplicationArea = All;
                ToolTip = 'Maximum number of retries for the complete consolidation process';
            }
            group(API)
            {
                Caption = 'Cross Environment';
                field(ApiUrl; ApiUrl)
                {
                    Caption = 'Current environment''s API Endpoint';
                    ApplicationArea = All;
                    ToolTip = 'The URL of the API for the current environment. Copy this value to set up the consolidation company';
                    Editable = false;
                }
                field(PageSize; Rec.PageSize)
                {
                    ApplicationArea = All;
                    ToolTip = 'The number of records to import in each API call';
                    Caption = 'API page size';
                }
                field(MaxAttempts429; Rec.MaxAttempts429)
                {
                    ApplicationArea = All;
                    ToolTip = 'The maximum number of times to retry API calls that return a 429 error';
                    Caption = 'Maximum attempts when receiving HTTP 429 responses';
                }
                field(WaitMsRetries; Rec.WaitMsRetries)
                {
                    ApplicationArea = All;
                    ToolTip = 'The number of milliseconds to wait between retries';
                    Caption = 'Wait between retries (ms)';
                }
            }
        }
    }

    var
        ApiUrl: Text;

    trigger OnOpenPage()
    begin
        Rec.GetOrCreateWithDefaults();
        ApiUrl := GetUrl(ClientType::Api);
    end;
}