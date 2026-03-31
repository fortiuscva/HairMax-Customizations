namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.History;

pageextension 52616 "HMX Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("HMX Shipping Agent Code"; Rec."HMX Shipping Agent Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Agent Code field.', Comment = '%';
            }
        }
    }
}
