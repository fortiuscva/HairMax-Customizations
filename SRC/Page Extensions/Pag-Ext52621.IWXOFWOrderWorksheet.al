pageextension 52621 "HMX IWX OFW Order Worksheet" extends "IWX OFW Order Worksheet"
{
    actions
    {
        /* modify(IWKM_BatchPack)
        {
            Visible = false;
        } */
        addlast(Processing)
        {
            action("HMX HairmaxChangeShippingAgent")
            {
                Caption = 'Change Shipping Agent';
                ApplicationArea = All;
                Image = Shipment;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    ShippingAgent: Record "Shipping Agent";
                    ShippingAgentService: Record "Shipping Agent Services";
                begin
                    if Rec."Document Type" <> Rec."Document Type"::"Sales Order" then
                        Error('The selected document is not a Sales Order.');

                    if Rec."Document No." = '' then
                        Error('No Sales Order is selected.');

                    if not SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Document No.") then
                        Error('Sales Order %1 was not found.', Rec."Document No.");

                    ShippingAgent.Reset();
                    if Page.RunModal(Page::"Shipping Agents", ShippingAgent) <> Action::LookupOK then
                        exit;

                    ShippingAgentService.Reset();
                    ShippingAgentService.SetRange("Shipping Agent Code", ShippingAgent.Code);
                    if Page.RunModal(Page::"Shipping Agent Services", ShippingAgentService) <> Action::LookupOK then
                        exit;

                    SalesHeader.Validate("Shipping Agent Code", ShippingAgent.Code);
                    SalesHeader.Validate("Shipping Agent Service Code", ShippingAgentService.Code);
                    SalesHeader.Modify(true);

                    Refresh(true);
                    CurrPage.Update(false);
                    Message('Shipping Agent and Shipping Agent Service have been updated for Sales Order %1.', SalesHeader."No.");
                end;
            }
            action("HMX HMXBatchPackAndShip")
            {
                Caption = 'TEST Batch Pack & Ship';
                ApplicationArea = All;
                Image = Post;
                ToolTip = 'Batch Pack, Ship and automatically post Sales Shipments.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    BatchShip: Codeunit "IW HI Batch Ship";
                    BatchNo: Code[35];
                begin
                    BuildSalesHeaderFilter(SalesHeader);

                    BatchShip.BatchPackShip(SalesHeader, BatchNo);

                    if BatchNo <> '' then begin
                        PostBatchSalesShipments(BatchNo);

                        Message('Batch %1 created and all Sales Shipments have been posted.', BatchNo);
                    end;
                end;
            }
        }

        addlast(Promoted)
        {
            actionref(HairmaxChangeShippingAgent_Promoted; "HMX HairmaxChangeShippingAgent")
            {
            }
        }
    }

    local procedure BuildSalesHeaderFilter(var SalesHeader: Record "Sales Header")
    var
        OutboundBuffer: Record "IWX OFW Outbound Header Buffer" temporary;
        SalesOrderFilter: Text;
    begin
        OutboundBuffer.Copy(Rec, true);
        CurrPage.SetSelectionFilter(OutboundBuffer);

        if OutboundBuffer.FindSet() then
            repeat
                if OutboundBuffer."Document Type" <> OutboundBuffer."Document Type"::"Sales Order" then
                    Error('Only Sales Orders can be processed.');

                if SalesOrderFilter <> '' then
                    SalesOrderFilter += '|';

                SalesOrderFilter += OutboundBuffer."Document No.";
            until OutboundBuffer.Next() = 0;

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter("No.", SalesOrderFilter);
    end;

    local procedure PostBatchSalesShipments(BatchNo: Code[35])
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("IW HI Batch No", BatchNo);
        if SalesHeader.FindSet() then
            repeat
                PostSalesShipment(SalesHeader);
            /* IWXLPHeader.Reset();
            IWXLPHeader.SetRange("Source Document", IWXLPHeader."Source Document"::"Sales Order");
            IWXLPHeader.SetRange("Source No.", docNo);
            If IWXLPHeader.FindSet() then begin
                if IWXLPHeader.Count = 1 then
                    if IWXLPHeader."Has Carrier Label" then begin
                        SalesHeader.SetRange("No.", docNo);
                        if SalesHeader.FindFirst() then
                            Report.RunModal(Report::"HMX Sales Order Packing Slip", false, true, SalesHeader);
                    end; 
            end;*/
            until SalesHeader.Next() = 0;
    end;

    local procedure PostSalesShipment(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("Completely Shipped");

        if SalesHeader."Completely Shipped" then
            exit;

        SalesHeader.Ship := true;
        SalesHeader.Invoice := false;

        Codeunit.Run(Codeunit::"Sales-Post", SalesHeader);
    end;
}