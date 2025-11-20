page 52602 "HMX ComplaintCategoryList"
{
    ApplicationArea = All;
    Caption = 'Complaint Category List';
    PageType = List;
    SourceTable = "HMX Complaint category";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Complaint Category Code"; Rec."Complaint Category Code")
                {
                    ToolTip = 'Specifies the value of the Complaint Category Code field.', Comment = '%';
                }
                field("Complaint category Discussion"; Rec."Complaint category Discussion")
                {
                    ToolTip = 'Specifies the value of the Complaint category Discussion field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetuprec: Record "User Setup";
    begin
        if (UserSetuprec.Get(UserId()) and (not UserSetuprec.CaseMangement)) then
            Error('You do not have permission to open this page.');
    end;

}
