codeunit 106 "Ledg. Entry-Track Changes"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Change Log Management", 'OnAfterIsAlwaysLoggedTable', '', false, false)]
    local procedure OnAfterIsAlwaysLoggedTable(TableID: Integer; var AlwaysLogTable: Boolean)
    begin
        if TableID in [Database::"Vendor Ledger Entry", Database::"Cust. Ledger Entry"] then
            AlwaysLogTable := true;
    end;
}