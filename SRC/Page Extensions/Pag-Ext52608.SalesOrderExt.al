pageextension 52608 "HMX SalesOrderExt" extends "Sales Order"
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


}