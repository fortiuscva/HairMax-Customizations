namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.Archive;
using Microsoft.Foundation.Shipping;

tableextension 52606 "HMX Purchase Header Archive" extends "Purchase Header Archive"
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
