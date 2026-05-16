namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Inventory.Item;

pageextension 52618 "HMX Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("HMX Signature"; Rec."HMX Signature")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Signature field.', Comment = '%';
            }
        }
    }
}
