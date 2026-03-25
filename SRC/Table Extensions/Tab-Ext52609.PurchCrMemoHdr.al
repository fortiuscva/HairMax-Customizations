namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.History;
using Microsoft.Foundation.Shipping;

tableextension 52609 "HMX Purch. Cr. Memo Hdr." extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(52600; "HMX Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
    }
}
