namespace HairMaxCustomizations.HairMaxCustomizations;

pageextension 52620 "IWX OFW Order Worksheet Lines" extends "IWX OFW Order Worksheet Lines"
{
    layout
    {
        addafter(fldDescription)
        {
            field("HMX Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("HMX Bin Code"; Rec."HMX Bin Code")
            {
                ApplicationArea = All;
            }
        }
    }
}