namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.Document;

pageextension 52613 "HMX Purchase Order" extends "Purchase Order"
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
