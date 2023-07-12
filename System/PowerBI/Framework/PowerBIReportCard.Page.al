page 6323 "Power BI Report Card"
{
    Caption = 'Power BI';
    DataCaptionExpression = Rec.ReportName;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    RefreshOnActivate = false;
    PageType = Card;
    SourceTable = "Power BI Report Configuration";

    layout
    {
        area(content)
        {
            group(ReportGroup)
            {
                ShowCaption = false;
                Visible = not HasError;

                usercontrol(PowerBIManagement; "Microsoft.Dynamics.Nav.Client.PowerBIManagement")
                {
                    ApplicationArea = All;

                    trigger AddInReady()
                    begin
                        InitializeAddIn();
                    end;

                    trigger ReportLoaded(ReportFilters: Text; ActivePageName: Text; activePageFilters: Text; CorrelationId: Text)
                    begin
                        LogCorrelationIdForEmbedType(CorrelationId, Enum::"Power BI Element Type"::Report);
                    end;

                    trigger DashboardLoaded(CorrelationId: Text)
                    begin
                        LogCorrelationIdForEmbedType(CorrelationId, Enum::"Power BI Element Type"::Dashboard);
                    end;

                    trigger DashboardTileLoaded(CorrelationId: Text)
                    begin
                        LogCorrelationIdForEmbedType(CorrelationId, Enum::"Power BI Element Type"::"Dashboard Tile");
                    end;

                    trigger ErrorOccurred(Operation: Text; ErrorText: Text)
                    begin
                        LogEmbedError(Operation);
                        ShowError(ErrorText);
                    end;
                }
            }
            group(ErrorGroup)
            {
                ShowCaption = false;
                Visible = HasError;

                field(ErrorMessageText; ErrorMessageText)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Specifies the error message from Power BI.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(FullScreen)
            {
                ApplicationArea = All;
                Caption = 'Fullscreen';
                ToolTip = 'Shows the Power BI report as full screen.';
                Image = View;

                trigger OnAction()
                begin
                    CurrPage.PowerBIManagement.FullScreen();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(FullScreen_Promoted; FullScreen)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not PowerBIServiceMgt.IsUserReadyForPowerBI() then
            ShowError(UnauthorizedErr);
    end;

    var
        PowerBIServiceMgt: Codeunit "Power BI Service Mgt.";
        HasError: Boolean;
        ErrorMessageText: Text;
        UnauthorizedErr: Label 'You do not have a Power BI account. If you have just activated a license, it might take several minutes for the changes to be effective in Power BI.';
        EmbedCorrelationTelemetryTxt: Label 'Embed element started with type: %1, and correlation: %2', Locked = true;
        EmbedErrorOccurredTelemetryTxt: Label 'Embed error occurred with category: %1', Locked = true;

    local procedure ShowError(NewErrorMessageText: Text)
    begin
        HasError := true;
        ErrorMessageText := NewErrorMessageText;
    end;

    [NonDebuggable]
    local procedure InitializeAddIn()
    var
        AccessToken: Text;
    begin
        AccessToken := PowerBiServiceMgt.GetEmbedAccessToken();

        if AccessToken = '' then begin
            ShowError(GetLastErrorText());
            exit;
        end;

        if not IsNullGuid(Rec."Report ID") and (Rec.ReportEmbedUrl <> '') then begin
            CurrPage.PowerBIManagement.InitializeFrame(true, '');
            CurrPage.PowerBIManagement.EmbedReport(Rec.ReportEmbedUrl, Rec."Report ID", AccessToken, '');
            CurrPage.Update();
        end;
    end;

    local procedure LogCorrelationIdForEmbedType(CorrelationId: Text; EmbedType: Enum "Power BI Element Type")
    begin
        Session.LogMessage('0000KAF', StrSubstNo(EmbedCorrelationTelemetryTxt, EmbedType, CorrelationId),
        Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', PowerBiServiceMgt.GetPowerBiTelemetryCategory());
    end;

    local procedure LogEmbedError(ErrorCategory: Text)
    begin
        Session.LogMessage('0000KAG', StrSubstNo(EmbedErrorOccurredTelemetryTxt, ErrorCategory),
        Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', PowerBiServiceMgt.GetPowerBiTelemetryCategory());
    end;
}
