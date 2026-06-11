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
        addlast(Control1)
        {
            field("HMX New Retailer"; Rec."HMX New Retailer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the New Retailer field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}