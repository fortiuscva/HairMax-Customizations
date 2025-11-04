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
                field(Number; Rec.Number)
                {
                    ApplicationArea = all;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = all;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = all;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = all;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = all;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Warranty Status"; Rec."Warranty Status")
                {
                    ApplicationArea = all;
                }
                field("Fault category"; Rec."Fault category")
                {
                    ApplicationArea = all;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = all;
                }

                field(Country; Rec.Country)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}