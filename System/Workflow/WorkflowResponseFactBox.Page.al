page 1525 "Workflow Response FactBox"
{
    Caption = 'Workflow Response';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Workflow Step Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Response Description"; Rec."Response Description")
                {
                    ApplicationArea = Suite;
                    ShowCaption = false;
                    ToolTip = 'Specifies the workflow response.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnFindRecord(Which: Text): Boolean
    var
        CurrFilterGroup: Integer;
    begin
        CurrFilterGroup := Rec.FilterGroup(0);
        Rec.SetRange("Parent Event Step ID");
        Rec.SetRange("Workflow Code");
        Rec.FilterGroup(4);
        if (ParentEventStepID <> Rec.GetRangeMax("Parent Event Step ID")) or (WorkflowCode <> Rec.GetRangeMax("Workflow Code")) then begin
            ParentEventStepID := Rec.GetRangeMax("Parent Event Step ID");
            WorkflowCode := Rec.GetRangeMax("Workflow Code");
            Rec.ClearBuffer();
        end;
        Rec.FilterGroup(CurrFilterGroup);

        if Rec.IsEmpty() then
            Rec.PopulateTableFromEvent(WorkflowCode, ParentEventStepID);

        exit(Rec.Find(Which));
    end;

    var
        ParentEventStepID: Integer;
        WorkflowCode: Code[20];

    procedure UpdateData()
    begin
        if (ParentEventStepID = 0) or (WorkflowCode = '') then
            exit;

        Rec.ClearBuffer();
        Rec.PopulateTableFromEvent(WorkflowCode, ParentEventStepID);
        CurrPage.Update(false);
    end;
}

