codeunit 5372 "Enable CDS Virtual Tables"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        CDSIntegrationImpl: Codeunit "CDS Integration Impl.";
        FilterTxt: Text;
    begin
        FilterTxt := Rec.GetXmlContent();
        CDSIntegrationImpl.EnableVirtualTables(FilterTxt);
    end;
}