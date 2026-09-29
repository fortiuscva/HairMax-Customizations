namespace HairMaxCustomizations.HairMaxCustomizations;

page 52606 "HMX Customer Packing Groups"
{
    ApplicationArea = All;
    Caption = 'HMX Customer Packing Groups';
    PageType = List;
    SourceTable = "HMX Customer Packing Group";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Packing Comments"; Rec."Packing Comments")
                {
                    ToolTip = 'Specifies the value of the Packing Comments field.', Comment = '%';
                }
                field("Labeling Comments"; Rec."Labeling Comments")
                {
                    ToolTip = 'Specifies the value of the Labeling Comments field.', Comment = '%';
                }
                field("Fulfillment Comments"; Rec."Fulfillment Comments")
                {
                    ToolTip = 'Specifies the value of the Fulfillment Comments field.', Comment = '%';
                }
            }
        }
    }
}
