pageextension 52604 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {
            field(CaseMangement; Rec.CaseMangement)
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
