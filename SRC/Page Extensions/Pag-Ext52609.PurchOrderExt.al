pageextension 52609 "HMX PurchOrderExt" extends "Purchase Order"
{
    layout
    {
        addfirst(General)
        {
            field("HMX No."; Rec."No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}