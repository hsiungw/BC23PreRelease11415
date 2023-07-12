enum 660 TableID
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(4; "Currency") { }
    value(13; "Salesperson/Purchaser") { }
    value(14; "Location") { }
    value(15; "G/L Account") { }
    value(17; "G/L Entry") { }
    value(18; "Customer") { }
    value(23; "Vendor") { }
    value(27; "Item") { }
    value(32; "Item Ledger Entry") { }
    value(36; "Sales Header") { }
    value(37; "Sales Line") { }
    value(38; "Purchase Header") { }
    value(39; "Purchase Line") { }
    value(81; "Gen. Journal Line") { }
    value(83; "Item Journal Line") { }
    value(98; "General Ledger Setup") { }
    value(110; "Sales Shipment Header") { }
    value(111; "Sales Shipment Line") { }
    value(112; "Sales Invoice Header") { }
    value(113; "Sales Invoice Line") { }
    value(114; "Sales Cr.Memo Header") { }
    value(115; "Sales Cr.Memo Line") { }
    value(120; "Purch. Rcpt. Header") { }
    value(121; "Purch. Rcpt. Line") { }
    value(122; "Purch. Inv. Header") { }
    value(123; "Purch. Inv. Line") { }
    value(124; "Purch. Cr. Memo Hdr.") { }
    value(125; "Purch. Cr. Memo Line") { }
    value(152; "Resource Group") { }
    value(156; "Resource") { }
    value(167; "Job") { }
    value(169; "Job Ledger Entry") { }
    value(207; "Res. Journal Line") { }
    value(210; "Job Journal Line") { }
    value(220; "Business Unit") { }
    value(221; "Gen. Jnl. Allocation") { }
    value(246; "Requisition Line") { }
    value(270; "Bank Account") { }
    value(273; "Bank Acc. Reconciliation") { }
    value(274; "Bank Acc. Reconciliation Line") { }
    value(295; "Reminder Header") { }
    value(302; "Finance Charge Memo Header") { }
    value(308; "No. Series") { }
    value(336; "Tracking Specification") { }
    value(337; "Reservation Entry") { }
    value(348; "Dimension") { }
    value(349; "Dimension Value") { }
    value(350; "Dimension Combination") { }
    value(351; "Dimension Value Combination") { }
    value(352; "Default Dimension") { }
    value(360; "Dimension Buffer") { }
    value(411; "IC Dimension") { }
    value(412; "IC Dimension Value") { }
    value(413; "IC Partner") { }
    value(480; "Dimension Set Entry") { }
    value(484; "Change Global Dim. Header") { }
    value(751; "Standard General Journal Line") { }
    value(753; "Standard Item Journal Line") { }
    value(840; "Cash Flow Forecast") { }
    value(841; "Cash Flow Account") { }
    value(849; "Cash Flow Manual Revenue") { }
    value(850; "Cash Flow Manual Expense") { }
    value(900; "Assembly Header") { }
    value(901; "Assembly Line") { }
    value(910; "Posted Assembly Header") { }
    value(911; "Posted Assembly Line") { }
    value(1001; "Job Task") { }
    value(1003; "Job Planning Line") { }
    value(1381; "Customer Templ.") { }
    value(1382; "Item Templ.") { }
    value(1383; "Vendor Templ.") { }
    value(1384; "Employee Templ.") { }
    value(5108; "Sales Line Archive") { }
    value(5065; "Interaction Log Entry") { }
    value(5071; "Campaign") { }
    value(5080; "To-do") { }
    value(5110; "Purchase Line Archive") { }
    value(5200; "Employee") { }
    value(5214; "Misc. Article Information") { }
    value(5405; "Production Order") { }
    value(5406; "Prod. Order Line") { }
    value(5407; "Prod. Order Component") { }
    value(5050; "Contact") { }
    value(5600; "Fixed Asset") { }
    value(5621; "FA Journal Line") { }
    value(5628; "Insurance") { }
    value(5635; "Insurance Journal Line") { }
    value(5700; "Stockkeeping Unit") { }
    value(5714; "Responsibility Center") { }
    value(5740; "Transfer Header") { }
    value(5741; "Transfer Line") { }
    value(5742; "Transfer Route") { }
    value(5744; "Transfer Shipment Header") { }
    value(5745; "Transfer Shipment Line") { }
    value(5746; "Transfer Receipt Header") { }
    value(5747; "Transfer Receipt Line") { }
    value(5767; "Warehouse Activity Line") { }
    value(5773; "Registered Whse. Activity Line") { }
    value(5800; "Item Charge") { }
    value(5850; "Invt. Document Header") { }
    value(5851; "Invt. Document Line") { }
    value(5853; "Invt. Receipt Line") { }
    value(5855; "Invt. Shipment Line") { }
    value(5856; "Direct Trans. Header") { }
    value(5857; "Direct Trans. Line") { }
    value(5876; "Phys. Invt. Order Line") { }
    value(5900; "Service Header") { }
    value(5901; "Service Item Line") { }
    value(5902; "Service Line") { }
    value(5903; "Service Order Type") { }
    value(5904; "Service Item Group") { }
    value(5905; "Service Cost") { }
    value(5913; Loaner) { }
    value(5940; "Service Item") { }
    value(5941; "Service Item Component") { }
    value(5964; "Service Contract Line") { }
    value(5965; "Service Contract Header") { }
    value(5968; "Service Contract Template") { }
    value(5971; "Filed Contract Line") { }
    value(5990; "Service Shipment Header") { }
    value(5991; "Service Shipment Line") { }
    value(5992; "Service Invoice Header") { }
    value(5993; "Service Invoice Line") { }
    value(5994; "Service Cr.Memo Header") { }
    value(5995; "Service Cr.Memo Line") { }
    value(5997; "Standard Service Line") { }
    value(6504; "Serial No. Information") { }
    value(6505; "Lot No. Information") { }
    value(6515; "Package No. Information") { }
    value(6650; "Return Shipment Header") { }
    value(6651; "Return Shipment Line") { }
    value(6660; "Return Receipt Header") { }
    value(6661; "Return Receipt Line") { }
    value(7311; "Warehouse Journal Line") { }
    value(7312; "Warehouse Entry") { }
    value(7316; "Warehouse Receipt Header") { }
    value(7317; "Warehouse Receipt Line") { }
    value(7319; "Posted Whse. Receipt Line") { }
    value(7320; "Warehouse Shipment Header") { }
    value(7321; "Warehouse Shipment Line") { }
    value(7323; "Posted Whse. Shipment Line") { }
    value(7326; "Whse. Worksheet Line") { }
    value(7332; "Whse. Internal Put-away Line") { }
    value(7334; "Whse. Internal Pick Line") { }
    value(7341; "Posted Invt. Put-away Line") { }
    value(7343; "Posted Invt. Pick Line") { }
    value(7347; "Internal Movement Line") { }
    value(99000754; "Work Center") { }
    value(99000758; "Machine Center") { }
    value(99000763; "Routing Header") { }
    value(99000765; "Manufacturing Setup") { }
    value(99000771; "Production BOM Header") { }
    value(99000779; "Production BOM Version") { }
    value(99000786; "Routing Version") { }
    value(99000829; "Planning Component") { }
    value(99000851; "Production Forecast Name") { }
    value(99000852; "Production Forecast Entry") { }
}
