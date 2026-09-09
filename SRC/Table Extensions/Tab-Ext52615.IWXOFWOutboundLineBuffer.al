namespace HairMaxCustomizations.HairMaxCustomizations;
using Microsoft.Warehouse.Structure;

tableextension 52615 "IWX OFW Outbound Line Buffer" extends "IWX OFW Outbound Line Buffer"
{
    fields
    {
        field(52600; "HMX Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
        }
    }
}
