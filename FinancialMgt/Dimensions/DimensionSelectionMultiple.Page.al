page 562 "Dimension Selection-Multiple"
{
    Caption = 'Dimension Selection';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Dimension Selection Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies that this dimension will be included.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the dimension.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies a description of the dimension.';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetDimSelBuf(var DimensionSelectionBuffer: Record "Dimension Selection Buffer")
    begin
        DimensionSelectionBuffer.DeleteAll();
        if Rec.Find('-') then
            repeat
                DimensionSelectionBuffer := Rec;
                DimensionSelectionBuffer.Insert();
            until Rec.Next() = 0;
    end;

    procedure InsertDimSelBuf(NewSelected: Boolean; NewCode: Text[30]; NewDescription: Text[30])
    var
        Dimension: Record Dimension;
        GLAccount: Record "G/L Account";
        BusinessUnit: Record "Business Unit";
    begin
        if NewDescription = '' then
            if Dimension.Get(NewCode) then
                NewDescription := Dimension.GetMLName(GlobalLanguage);

        Rec.Init();
        Rec.Selected := NewSelected;
        Rec.Code := NewCode;
        Rec.Description := NewDescription;
        case Rec.Code of
            GLAccount.TableCaption:
                Rec."Filter Lookup Table No." := Enum::TableID::"G/L Account".AsInteger();
            BusinessUnit.TableCaption:
                Rec."Filter Lookup Table No." := Enum::TableID::"Business Unit".AsInteger();
        end;
        Rec.Insert();
    end;
}

