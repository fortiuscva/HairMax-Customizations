pageextension 52621 "HMX IWX OFW Order Worksheet" extends "IWX OFW Order Worksheet"
{
    actions
    {
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
        }

        addlast(Promoted)
        {
            actionref(HairmaxChangeShippingAgent_Promoted; "HMX HairmaxChangeShippingAgent")
            {
            }
        }
    }
}