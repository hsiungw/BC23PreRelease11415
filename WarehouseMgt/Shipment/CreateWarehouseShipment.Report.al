report 5708 "Create Warehouse Shipment"
{
    UsageCategory = Tasks;
    ApplicationArea = Warehouse;
    ProcessingOnly = true;
    Caption = 'Create Warehouse Shipment';

    dataset
    {
        dataitem("Warehouse Request"; "Warehouse Request")
        {
            DataItemTableView = sorting("Source Document", "Source No.") where(Type = const(Outbound), "Document Status" = const(Released));
            RequestFilterFields = "Source Document", "Source No.", "Location Code";

            trigger OnAfterGetRecord()
            begin
                case "Source Document" of
                    "Source Document"::"Purchase Order":
                        ;
                    "Source Document"::"Purchase Return Order":
                        ;
                    "Source Document"::"Sales Order":
                        CreateWarehouseShipmentForSalesOrder();
                    "Source Document"::"Sales Return Order":
                        ;
                    "Source Document"::"Outbound Transfer":
                        ;
                    "Source Document"::"Prod. Consumption":
                        ;
                    "Source Document"::"Assembly Consumption":
                        ;
                    "Source Document"::"Job Usage":
                        ;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field("Do Not Fill Qty. to Handle"; DoNotFillQtytoHandle)
                    {
                        Caption = 'Do not fill Qty. to Handle';
                        ToolTip = 'Specifies if the Quantity to Handle field in the warehouse document is prefilled according to the source document quantities.';
                    }
                    field("Reserved Stock Only"; ReservedFromStock)
                    {
                        Caption = 'Reserved stock only';
                        ToolTip = 'Specifies if you want to include only source document lines that are fully or partially reserved from current stock.';
                        ValuesAllowed = " ", "Full and Partial", Full;
                    }
                }
            }
        }

    }

    var
        DoNotFillQtytoHandle: Boolean;
        ReservedFromStock: Enum "Reservation From Stock";

    procedure InitializeRequest(NewDoNotFillQtyToHandle: Boolean; NewReservedFromStock: Enum "Reservation From Stock")
    begin
        DoNotFillQtytoHandle := NewDoNotFillQtyToHandle;
        ReservedFromStock := NewReservedFromStock;
    end;

    local procedure CreateWarehouseShipmentForSalesOrder()
    var
        SalesHeader: Record "Sales Header";
        WarehouseRequest: Record "Warehouse Request";
        GetSourceDocuments: Report "Get Source Documents";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        WarehouseRequest.Copy("Warehouse Request");

        SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.");
        if SalesHeader.Status <> SalesHeader.Status::Released then
            exit;

        if not SalesHeader.IsApprovedForPostingBatch() then
            exit;

        if SalesHeader.WhseShipmentConflict(SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Shipping Advice") then
            exit;

        if GetSourceDocOutbound.CheckSalesHeader(SalesHeader, false) then
            exit;

        Clear(GetSourceDocuments);
        GetSourceDocuments.SetDoNotFillQtytoHandle(DoNotFillQtytoHandle);
        GetSourceDocuments.SetReservedFromStock(ReservedFromStock);
        GetSourceDocuments.UseRequestPage(false);
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.SetHideDialog(true);
        GetSourceDocuments.RunModal();
    end;
}