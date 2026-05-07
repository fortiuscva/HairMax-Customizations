namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Inventory.Requisition;

pageextension 52619 "HMX Planning Worksheet" extends "Planning Worksheet"
{
    layout
    {
        addafter(Quantity)
        {
            field("HMX Forecast Quantity"; Rec."HMX Forecast Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Forecast Quantity field.', Comment = '%';
            }
            field("HMX On-hand Quantity"; Rec."HMX On-hand Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On-hand Quantity field.', Comment = '%';
            }
            field("HMX Recommended Supply"; Rec."HMX Recommended Supply")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Recommended Supply field.', Comment = '%';
            }
            field("HMX Quick Order Calc"; Rec."HMX Quick Order Calc")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quick Order Calc field.', Comment = '%';
            }
        }
        addlast(factboxes)
        {
            part("HMX Forecast FactBox"; "HMX Forecast FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalculateValues();
        CurrPage.Update(false);
    end;
}
