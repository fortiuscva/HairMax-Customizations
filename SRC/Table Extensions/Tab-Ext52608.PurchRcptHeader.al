namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Purchases.History;
using Microsoft.Foundation.Shipping;

tableextension 52608 "HMX Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
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
