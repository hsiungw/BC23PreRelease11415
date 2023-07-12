#if not CLEAN21
page 2160 "O365 Sales Graph"
{
    Caption = 'O365 Sales Graph';
    SourceTable = "O365 Sales Graph";
    SourceTableTemporary = true;
    ObsoleteReason = 'Microsoft Invoicing has been discontinued.';
    ObsoleteState = Pending;
    ObsoleteTag = '21.0';

    layout
    {
        area(content)
        {
            field(Component; Rec.Component)
            {
                ApplicationArea = Invoicing, Basic, Suite;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = Invoicing, Basic, Suite;
            }
            field("Schema"; Rec.Schema)
            {
                ApplicationArea = Invoicing, Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec.ParseRefresh();
    end;
}
#endif
