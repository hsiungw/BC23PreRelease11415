codeunit 790 "IC Inbox Outbox Subscribers"
{
    TableNo = "IC Inbox Transaction";

    trigger OnRun()
    begin
        Rec.SetRecFilter();
        Rec."Line Action" := Rec."Line Action"::Accept;
        Rec.Modify();
        REPORT.Run(REPORT::"Complete IC Inbox Action", false, false, Rec);
        Rec.Reset();
    end;

    var
        ICOutboxExport: Codeunit "IC Outbox Export";
        JobQueueCategoryCodeTxt: Label 'ICAUTOACC', Locked = true;
        AutoAcceptTransactionTxt: Label 'Auto. accept transaction %1 of partner %2 for document %3', Comment = '%1 = Transaction ID, %2 = Partner Code, %3 = Document No.';

    local procedure IsICInboxTransactionReturnedByPartner(TransactionSource: Option): Boolean
    var
        ICInboxTransaction: Record "IC Inbox Transaction";
    begin
        exit(TransactionSource = ICInboxTransaction."Transaction Source"::"Returned by Partner");
    end;

    local procedure EnqueueAutoAcceptJobQueueEntry(ICInboxTransaction: Record "IC Inbox Transaction"; PartnerCompanyName: Text)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.ChangeCompany(PartnerCompanyName);

        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"IC Inbox Outbox Subs. Runner";
        JobQueueEntry."Record ID to Process" := ICInboxTransaction.RecordId;
        JobQueueEntry."Job Queue Category Code" := JobQueueCategoryCodeTxt;
        JobQueueEntry."Run in User Session" := false;
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Description := StrSubstNo(AutoAcceptTransactionTxt, ICInboxTransaction."Transaction No.", ICInboxTransaction."IC Partner Code", ICInboxTransaction."Document No.");
        JobQueueEntry.Insert(true);
        CODEUNIT.Run(CODEUNIT::"Job Queue - Enqueue", JobQueueEntry);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Move IC Trans. to Partner Comp", 'OnICInboxTransactionCreated', '', false, false)]
    local procedure AcceptOnAfterInsertICInboxTransaction(var Sender: Report "Move IC Trans. to Partner Comp"; var ICInboxTransaction: Record "IC Inbox Transaction"; PartnerCompanyName: Text)
    var
        ICSetup: Record "IC Setup";
        ICPartner: Record "IC Partner";
        FeatureTelemetry: Codeunit "Feature Telemetry";
        ICMapping: Codeunit "IC Mapping";
    begin
        ICSetup.Get();
        ICPartner.ChangeCompany(PartnerCompanyName);

        if not ICPartner.Get(ICSetup."IC Partner Code") then
            exit;

        FeatureTelemetry.LogUptake('0000IIX', ICMapping.GetFeatureTelemetryName(), Enum::"Feature Uptake Status"::Used);
        FeatureTelemetry.LogUsage('0000IIY', ICMapping.GetFeatureTelemetryName(), 'IC Inbox Transaction Created');

        if ICPartner."Auto. Accept Transactions" then
            if not IsICInboxTransactionReturnedByPartner(ICInboxTransaction."Transaction Source") then
                EnqueueAutoAcceptJobQueueEntry(ICInboxTransaction, PartnerCompanyName);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnInsertICOutboxPurchDocTransaction', '', false, false)]
    local procedure AutoSendOnInsertICOutboxPurchDocTransaction(var ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutboxExport.ProcessAutoSendOutboxTransactionNo(ICOutboxTransaction."Transaction No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnInsertICOutboxSalesDocTransaction', '', false, false)]
    local procedure AutoSendOnInsertICOutboxSalesDocTransaction(var ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutboxExport.ProcessAutoSendOutboxTransactionNo(ICOutboxTransaction."Transaction No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnInsertICOutboxSalesInvTransaction', '', false, false)]
    local procedure AutoSendOnInsertICOutboxSalesInvTransaction(var ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutboxExport.ProcessAutoSendOutboxTransactionNo(ICOutboxTransaction."Transaction No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnInsertICOutboxSalesCrMemoTransaction', '', false, false)]
    local procedure AutoSendOnInsertICOutboxSalesCrMemoTransaction(var ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICOutboxExport.ProcessAutoSendOutboxTransactionNo(ICOutboxTransaction."Transaction No.");
    end;
}

