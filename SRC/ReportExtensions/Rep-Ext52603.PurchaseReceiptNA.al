namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.Shipping;

reportextension 52603 "HMX Purchase Receipt NA" extends "Purchase Receipt NA"
{

    RDLCLayout = './SRC/ReportExtensions/Layouts/PurchaseReceiptNA.rdlc';
    dataset
    {
        add("Purch. Rcpt. Header")
        {
            column(HMXShipment_Method_Code; "Shipment Method Code")
            {
            }
            column(HMXAgent_Code; ShippingAgentName)
            {
            }
            column(HMXShipmentMethodCodeCaptionLbl; ShipmentMethodCodeCaptionLbl)
            { }
            column(HMXShippingAgentCodeCaptionLbl; ShippingAgentCodeCaptionLbl)
            { }
        }
        modify("Purch. Rcpt. Header")
        {
            trigger OnAfterAfterGetRecord()
            var

                ShippingAgent: Record "Shipping Agent";
            begin
                ShippingAgent.Get("Purch. Rcpt. Header"."HMX Shipping Agent Code");
                ShippingAgentName := ShippingAgent.Name;

            end;
        }
    }
    var
        ShippingAgentName: Text;
        ShipmentMethodCodeCaptionLbl: Label 'Shipment Method Code';
        ShippingAgentCodeCaptionLbl: Label 'Shipping Agent Code';
}
