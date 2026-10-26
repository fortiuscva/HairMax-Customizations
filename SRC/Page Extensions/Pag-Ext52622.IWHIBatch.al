pageextension 52622 "HMX IW HI Batch" extends "IW HI Batch"
{
    actions
    {
        addlast(Reporting)
        {
            action("HMX PrintPackingSlip")
            {
                ApplicationArea = All;
                Caption = 'Print Packing Slip';
                Image = Print;
                ToolTip = 'Print the sales order packing slip when a carrier label exists.';

                trigger OnAction()
                var
                    IWXLPHeader: Record "IWX LP Header";
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("IW HI Batch No", Rec."Batch No.");
                    if SalesHeader.FindSet() then begin
                        repeat
                            Report.RunModal(Report::"HMX Sales Order Packing Slip", false, true, SalesHeader);
                        /* IWXLPHeader.Reset();
                        IWXLPHeader.SetRange("Source Document", IWXLPHeader."Source Document"::"Sales Order");
                        IWXLPHeader.SetRange("Source No.", SalesHeader."No.");
                        if IWXLPHeader.Count() = 1 then
                            if IWXLPHeader.FindFirst() then
                                if IWXLPHeader."Has Carrier Label" then 
                                    Report.RunModal(Report::"HMX Sales Order Packing Slip", false, true, SalesHeader);
                         */
                        until SalesHeader.Next() = 0;
                    end;
                end;
            }
        }
    }
}