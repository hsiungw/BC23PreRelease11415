query 5001 "Locations from items Sales"
{
    Caption = 'Locations from items Sales';

    elements
    {
        dataitem(Sales_Line; "Sales Line")
        {
            DataItemTableFilter = "Document Type" = const(Order), Type = const(Item), "Location Code" = filter(<> ''), "No." = filter(<> ''), Quantity = filter(<> 0);
            column(Document_No; "Document No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            dataitem(Location; Location)
            {
                DataItemLink = Code = Sales_Line."Location Code";
                DataItemTableFilter = "Use As In-Transit" = const(false);
                column(Require_Shipment; "Require Shipment")
                {
                }
                column(Require_Pick; "Require Pick")
                {
                }
            }
        }
    }
}

