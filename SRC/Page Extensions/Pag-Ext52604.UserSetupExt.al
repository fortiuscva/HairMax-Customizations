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
        }
    }
}
