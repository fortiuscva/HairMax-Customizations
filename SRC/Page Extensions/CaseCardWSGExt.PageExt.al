pageextension 52600 CaseCardWSGExt extends "Case Card WSG"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("case Origin"; Rec."HMX case Origin")
            {
                ApplicationArea = all;

            }
            field("case Type"; Rec."HMX case Type")
            {
                ApplicationArea = all;

            }
            field("case Priority"; Rec."HMX case Priority")
            {
                ApplicationArea = all;

            }
            field("case Issue"; Rec."HMX case Issue")
            {
                ApplicationArea = all;

            }
            field(KMBSCaseStatus; Rec."HMX CaseStatus")
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
            field(Address; Rec."HMX Address")
            {
                ApplicationArea = all;
            }
            field("Address 2"; Rec."HMX Address 2")
            {
                ApplicationArea = all;
            }
            field(City; Rec."HMX City")
            {
                ApplicationArea = all;
            }
            field("Post Code"; Rec."HMX Post Code")
            {
                ApplicationArea = all;
            }
            field("Country/Region Code"; Rec."HMX Country/Region Code")
            {
                ApplicationArea = all;
            }
        }
        addlast(Content)
        {
            group(Qualityreview)
            {
                Caption = 'Quality Review';

                field(ReportableEvent; Rec."HMX ReportableEvent")
                {
                    ApplicationArea = all;
                }
                field(NonRequiredEvent; Rec."HMX NonRequiredEvent")
                {
                    ApplicationArea = all;
                }
                field(ComplaintInvestReq; Rec."HMX ComplaintInvestReq")
                {
                    ApplicationArea = all;
                }
                field(CorrectiveActionReq; Rec."HMX CorrectiveActionReq")
                {
                    ApplicationArea = all;
                }
                field(Complaintcategory; Rec."HMX Complaintcategory")
                {
                    ApplicationArea = all;
                }
                field(Justification; Rec."HMX Justification")
                {
                    ApplicationArea = all;
                }
                field(ExistingCaseTracking; Rec."HMX ExistingCaseTracking")
                {
                    ApplicationArea = all;
                }
                field(JustificationNoCAPA; Rec."HMX JustificationNoCAPA")
                {
                    ApplicationArea = all;
                }
                field(CorrectiveAction; Rec."HMX CorrectiveAction")
                {
                    ApplicationArea = all;
                }
            }
            group(Technicalreview)
            {
                Caption = 'Technical Review';
                field(FaultCategory; Rec."HMX FaultCategory")
                {
                    ApplicationArea = all;
                }
                field(Faultdescription; Rec."HMX Faultdescription")
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