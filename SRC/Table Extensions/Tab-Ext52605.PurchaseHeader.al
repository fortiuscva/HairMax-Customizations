namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.Shipping;

tableextension 52605 "HMX Purchase Header" extends "Purchase Header"
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
