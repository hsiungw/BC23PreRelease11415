report 153 "Customer Statement"
{
    Caption = 'Customer Statement';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        CustomerLayoutStatement: Codeunit "Customer Layout - Statement";
    begin
        CustomerLayoutStatement.RunReport();
    end;
}

