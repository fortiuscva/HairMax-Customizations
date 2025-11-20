page 52603 "HMX JustoficationNoCAPA"
{
    ApplicationArea = All;
    Caption = 'Justification if No CAPA is Required';
    PageType = List;
    SourceTable = "HMX JustificationNoCAPA";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(JustificationNoCAPA; Rec.JustificationNoCAPA)
                {
                    ToolTip = 'Specifies the value of the Justification if No CAPA is Required field.', Comment = '%';
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
