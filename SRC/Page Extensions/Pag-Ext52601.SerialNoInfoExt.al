pageextension 52601 "HMX SerialNoInfoExt" extends "Serial No. Information Card"
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
            field("HMX Reseller"; Rec."HMX Reseller")
            {
                ApplicationArea = all;
            }
            field("HMX Extended Protection"; Rec."HMX Extended Protection")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}