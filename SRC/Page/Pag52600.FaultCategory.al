page 52600 "HMX FaultCategory"
{
    ApplicationArea = All;
    Caption = 'FaultCategory';
    PageType = List;
    SourceTable = "HMX Fault category";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Faultcategory; Rec.Faultcategory)
                {
                    ToolTip = 'Specifies the value of the Fault Category field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
