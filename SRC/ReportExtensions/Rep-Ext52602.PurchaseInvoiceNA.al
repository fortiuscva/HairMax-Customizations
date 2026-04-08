namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.Shipping;

reportextension 52602 "HMX Purchase Invoice NA" extends "Purchase Invoice NA"
{
    RDLCLayout = './SRC/ReportExtensions/Layouts/PurchaseInvoiceNA.rdlc';
    dataset
    {
        add("Purch. Inv. Header")
        {
            column(HMXShipment_Method_Code; ShippingAgentName)
            {
            }
            column(HMXAgent_Code; ShipmentMethodRec.Description)
            {
            }
            column(HMXShipmentMethodCodeCaptionLbl; ShipmentMethodCodeCaptionLbl)
            { }
            column(HMXShippingAgentCodeCaptionLbl; ShippingAgentCodeCaptionLbl)
            { }
        }
        modify("Purch. Inv. Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                ShippingAgent: Record "Shipping Agent";
            begin
                ShippingAgent.Get("Purch. Inv. Header"."HMX Shipping Agent Code");
                ShippingAgentName := ShippingAgent.Name;
                ShipmentMethodRec.Get("Purch. Inv. Header"."Shipment Method Code");
            end;
        }
    }
    labels
    {
        ShipmentMethodCodeCaption = 'Shipment Method Code';
        ShippingAgentName = 'Shipping Agent Code';
    }

    var
        ShippingAgentName: Text;
        ShipmentMethodRec: Record "Shipment Method";
        ShipmentMethodCodeCaptionLbl: Label 'Shipment Method Code';
        ShippingAgentCodeCaptionLbl: Label 'Shipping Agent Code';
}
