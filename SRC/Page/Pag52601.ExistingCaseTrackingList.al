page 52601 "HMX ExistingCaseTrackingList"
{
    ApplicationArea = All;
    Caption = 'ExistingCaseTrackingList';
    PageType = List;
    SourceTable = "HMX ExistingCaseTracking";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Internal ID"; Rec."Internal ID")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
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