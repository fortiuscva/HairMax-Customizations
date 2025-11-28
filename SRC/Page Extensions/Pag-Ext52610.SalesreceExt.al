pageextension 52610 "HMX SalesreceExt" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("HMX Price List Nos."; Rec."Price List Nos.")
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