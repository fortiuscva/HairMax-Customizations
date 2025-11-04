pageextension 52602 "HMX CustomerCardExt" extends "Customer Card"
{
    layout
    {
        addlast(content)
        {
            group("HMX CreateInteraction")
            {
                Caption = 'Create Interaction';
                field("HMX Interaction Template Code"; Rec."Interaction Template Code")
                {
                    ApplicationArea = all;
                }
                field("HMX Description"; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("HMX Salesperson"; Rec.Salesperson)
                {
                    ApplicationArea = all;
                }
                field("HMX Interaction Language Code"; Rec."Interaction Language Code")
                {
                    ApplicationArea = all;
                }
                field("HMX Date of Interaction"; Rec."Date of Interaction")
                {
                    ApplicationArea = all;
                }
                field("HMX Time of Interaction"; Rec."Time of Interaction")
                {
                    ApplicationArea = all;
                }
                field("HMX Correspondence Type"; Rec."Correspondence Type")
                {
                    ApplicationArea = all;
                }
                field("HMX Information Flow"; Rec."Information Flow")
                {
                    ApplicationArea = all;
                }
                field("HMX Initiated By"; Rec."Initiated By")
                {
                    ApplicationArea = all;
                }
                field("HMX Comments"; Rec.Comments)
                {
                    ApplicationArea = all;
                    LookupPageId = "Inter. Log Entry Comment Sheet";
                }
                label("What was the result of the interaction?")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("HMX Evaluation"; Rec.Evaluation)
                {
                    ApplicationArea = all;
                }
                field("HMX Was Successful"; Rec."Was Successful")
                {
                    ApplicationArea = all;
                }
                field("HMX Cost"; Rec.Cost)
                {
                    ApplicationArea = all;
                }
                field("HMX Duration"; Rec.Duration)
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


}