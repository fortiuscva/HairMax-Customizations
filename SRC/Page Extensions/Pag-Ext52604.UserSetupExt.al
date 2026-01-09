pageextension 52604 "HMX UserSetupExt" extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {
            field("HMX CaseMangement"; Rec."HMX CaseMangement")
            {
                ApplicationArea = all;
                ToolTip = 'Enabled if the user need the access to the lists in Case management';
            }
            field("HMX Edit Cust. Post. Group"; Rec."HMX Edit Cust. Post. Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Edit Customer Posting Group field.', Comment = '%';
            }
        }
    }
}
