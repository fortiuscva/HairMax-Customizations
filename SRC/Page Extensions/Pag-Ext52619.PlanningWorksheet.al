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
    actions
    {
        modify(CalculateRegenerativePlan)
        {
            trigger OnAfterAction()
            var
                ReqLine: Record "Requisition Line";
            begin
                ReqLine.Reset();
                ReqLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                ReqLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                ReqLine.SetRange(Type, ReqLine.Type::Item);

                if ReqLine.FindSet() then
                    repeat
                        if ReqLine."No." <> '' then begin
                            ReqLine.UpdateValues(ReqLine);
                            ReqLine.Modify();
                        end;
                    until ReqLine.Next() = 0;

                CurrPage.Update(false);
            end;
        }
    }
}
