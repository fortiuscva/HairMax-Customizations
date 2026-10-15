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
        modify("Sell-to Phone No.")
        {
            ShowMandatory = true;
        }
        modify("Sell-to Country/Region Code")
        {
            ShowMandatory = true;
        }
        modify("Salesperson Code")
        {
            ShowMandatory = true;
        }
        addlast(General)
        {
            field("HMX Customer Packing Comments"; Rec."HMX Customer Packing Comments")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}