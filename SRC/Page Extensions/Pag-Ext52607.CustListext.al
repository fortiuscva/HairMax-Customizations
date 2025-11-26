pageextension 52607 "HMX CustListext" extends "Customer List"
{
    layout
    {
        addafter("Phone No.")
        {
            field("HMX E-Mail"; Rec."E-Mail")
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