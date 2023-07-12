codeunit 77 "Report Selections Impl"
{
    procedure TryGetReportLayout(reportId: Integer; layoutName: Text[250]; layoutAppId: Guid; var reportLayoutList: Record "Report Layout List"): Boolean
    begin
        reportLayoutList.SetRange("Name", layoutName);
        reportLayoutList.SetRange("Report ID", reportId);
        reportLayoutList.SetRange("Application ID", layoutAppId);

        if (reportLayoutList.FindFirst()) then
            exit(true);
    end;

    procedure GetReportLayoutCaption(reportId: Integer; layoutName: Text[250]; layoutAppId: Guid): Text[250]
    var
        reportLayoutList: Record "Report Layout List";
    begin
        if TryGetReportLayout(reportId, layoutName, layoutAppId, reportLayoutList) then
            exit(reportLayoutList.Caption);
    end;

    procedure GetReportLayoutDescription(reportId: Integer; layoutName: Text[250]; layoutAppId: Guid): Text[250]
    var
        reportLayoutList: Record "Report Layout List";
    begin
        if TryGetReportLayout(reportId, layoutName, layoutAppId, reportLayoutList) then
            exit(reportLayoutList.Description);
    end;
}
