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
            column(HMXShipment_Method_Code; "Shipment Method Code")
            {
            }
            column(HMXAgent_Code; ShippingAgentName)
            {
            }
        }
        modify("Purch. Inv. Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                ShippingAgent: Record "Shipping Agent";
            begin
                ShippingAgent.Get("Purch. Inv. Header"."HMX Shipping Agent Code");
                ShippingAgentName := ShippingAgent.Name;
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

}
