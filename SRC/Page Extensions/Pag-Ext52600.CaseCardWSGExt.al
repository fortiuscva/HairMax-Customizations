pageextension 52600 "HMX CaseCardWSGExt" extends "Case Card WSG"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("HMX case Origin"; Rec."HMX case Origin")
            {
                ApplicationArea = all;

            }
            field("HMX case Type"; Rec."HMX case Type")
            {
                ApplicationArea = all;

            }
            field("HMX case Priority"; Rec."HMX case Priority")
            {
                ApplicationArea = all;

            }
            field("HMX case Issue"; Rec."HMX case Issue")
            {
                ApplicationArea = all;

            }
            field("HMX KMBSCaseStatus"; Rec."HMX CaseStatus")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Case status';
            }
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Reason Notes")
        {
            Caption = 'Issue Details';
        }
        addlast(Reason)
        {
            field("HMX Address"; Rec."HMX Address")
            {
                ApplicationArea = all;
            }
            field("HMX Address 2"; Rec."HMX Address 2")
            {
                ApplicationArea = all;
            }
            field("HMX City"; Rec."HMX City")
            {
                ApplicationArea = all;
            }
            field("HMX County"; Rec."HMX County")
            {
                ApplicationArea = all;
            }
            field("HMX Post Code"; Rec."HMX Post Code")
            {
                ApplicationArea = all;
            }
            field("HMX Country/Region Code"; Rec."HMX Country/Region Code")
            {
                ApplicationArea = all;
            }
        }
        addlast(Content)
        {
            group("HMX Qualityreview")
            {
                Caption = 'Quality Review';
                field("HMX Complaintcategory"; Rec."HMX Complaintcategory")
                {
                    ApplicationArea = all;
                }

                field("HMX Justification"; Justification)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Caption = 'Quality Evaluation';
                    trigger OnValidate()

                    begin
                        Rec.SetJustofication(Justification);
                    end;
                }
                field("HMX ExistingCaseTracking"; Rec."HMX ExistingCaseTracking")
                {
                    ApplicationArea = all;
                }
                label("Risk Assessment1")
                {
                    ApplicationArea = all;
                    Caption = '';
                    Style = Strong;
                }
                label("Risk Assessment2")
                {
                    ApplicationArea = all;
                    Caption = '';
                    Style = Strong;
                }
                label("Risk Assessment3")
                {
                    ApplicationArea = all;
                    Caption = '';
                    Style = Strong;
                }
                label("Risk Assessment")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }


                field("HMX ComplaintInvestReq"; Rec."HMX ComplaintInvestReq")
                {
                    ApplicationArea = all;
                }
                field("HMX CorrectiveActionReq"; Rec."HMX CorrectiveActionReq")
                {
                    ApplicationArea = all;
                }
                field("HMX JustificationNoCAPA"; Rec."HMX JustificationNoCAPA")
                {
                    ApplicationArea = all;
                }


                field("HMX ReportableEvent"; Rec."HMX ReportableEvent")
                {
                    ApplicationArea = all;
                }
                field("HMX CorrectiveAction"; Rec."HMX CorrectiveAction")
                {
                    ApplicationArea = all;
                }
            }
            group("HMX Technicalreview")
            {
                Caption = 'Technical Review';
                field("HMX FaultCategory"; Rec."HMX FaultCategory")
                {
                    ApplicationArea = all;
                }
                field("HMX Faultdescription"; Rec."HMX Faultdescription")
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
    var
        Justification: Text;

    trigger OnAfterGetRecord()
    var
        Salesheader: Record "Sales Header";
    begin
        Justification := '';
        if Rec."HMX Justification".HasValue then
            Justification := Rec.GetJustification();
    end;

}