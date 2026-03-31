namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.History;

pageextension 52615 "HMX Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("HMX Shipping Agent Code"; Rec."HMX Shipping Agent Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shipping Agent Code field.', Comment = '%';
            }
        }
    }
}
