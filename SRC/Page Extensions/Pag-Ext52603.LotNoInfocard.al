pageextension 52603 "HMX Lot No Info card" extends "Lot No. Information Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("HMX Customer No."; Rec."HMX Customer No.")
            {
                ApplicationArea = all;
            }
            field("HMX CustomerName"; Rec."HMX CustomerName")
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