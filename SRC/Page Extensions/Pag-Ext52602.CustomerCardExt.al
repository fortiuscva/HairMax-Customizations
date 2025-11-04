pageextension 52602 "HMX CustomerCardExt" extends "Customer Card"
{
    layout
    {
        addlast(content)
        {
            group("HMX CreateInteraction")
            {
                Caption = 'Create Interaction';
                field("HMX Interaction Template Code"; Rec."HMX Interaction Template Code")
                {
                    ApplicationArea = all;
                }
                field("HMX Description"; Rec."HMX Description")
                {
                    ApplicationArea = all;
                }
                field("HMX Salesperson"; Rec."HMX Salesperson")
                {
                    ApplicationArea = all;
                }
                field("HMX Interaction Language Code"; Rec."HMX Interaction Language Code")
                {
                    ApplicationArea = all;
                }
                field("HMX Date of Interaction"; Rec."HMX Date of Interaction")
                {
                    ApplicationArea = all;
                }
                field("HMX Time of Interaction"; Rec."HMX Time of Interaction")
                {
                    ApplicationArea = all;
                }
                field("HMX Correspondence Type"; Rec."HMX Correspondence Type")
                {
                    ApplicationArea = all;
                }
                field("HMX Information Flow"; Rec."HMX Information Flow")
                {
                    ApplicationArea = all;
                }
                field("HMX Initiated By"; Rec."HMX Initiated By")
                {
                    ApplicationArea = all;
                }
                field("HMX Comments"; Rec."HMX Comments")
                {
                    ApplicationArea = all;
                    LookupPageId = "Inter. Log Entry Comment Sheet";
                }
                label("What was the result of the interaction?")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("HMX Evaluation"; Rec."HMX Evaluation")
                {
                    ApplicationArea = all;
                }
                field("HMX Was Successful"; Rec."HMX Was Successful")
                {
                    ApplicationArea = all;
                }
                field("HMX Cost"; Rec."HMX Cost")
                {
                    ApplicationArea = all;
                }
                field("HMX Duration"; Rec."HMX Duration")
                {
                    ApplicationArea = all;
                }
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }


    trigger OnQueryClosePage(closeAction: Action): Boolean
    begin
        Rec.InitSegmentLine();
        Rec.ClearIntercationDetails();
    end;

}