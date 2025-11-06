tableextension 52600 "HMX CaseWSGExt" extends "Case WSG"
{
    fields
    {
        field(50000; "HMX CaseStatus"; Enum "Case Statuses WSG")
        {
            ValuesAllowed = 1, 4, 5, 6, 7;
            Caption = 'Status';
            DataClassification = CustomerContent;
            trigger OnValidate()

            begin
                Rec.Status := Rec."HMX CaseStatus";
            end;
        }
        field(50001; "HMX case Origin"; Enum "HMX Case Origin")
        {
            Caption = 'Case Origin';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Case Origin Source';

        }
        field(50002; "HMX case Type"; Enum "HMX Case Type")
        {
            Caption = 'Case Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Case Type';
        }
        field(50003; "HMX case Priority"; Enum "HMX Case Priority")
        {
            Caption = 'Case Priority';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Case Priority';
        }
        field(50004; "HMX case Issue"; Enum "HMX Case Issue")
        {
            Caption = 'Case Issue';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Case Issue';
        }
        field(50005; "HMX Address"; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
        }
        field(50006; "HMX Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies additional address information.';
        }
        field(50007; "HMX City"; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            OptimizeForTextSearch = true;
            TableRelation = if ("HMX Country/Region Code" = const('')) "Post Code".City
            else
            if ("HMX Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("HMX Country/Region Code"));
            ValidateTableRelation = false;
            ToolTip = 'Specifies the customer''s city.';

            trigger OnLookup()
            var
                PostCode: Record "Post Code";
            begin
#pragma warning disable AA0139
                PostCode.LookupPostCode("HMX City", "HMX Post Code", "HMX County", "HMX Country/Region Code");
#pragma warning restore AA0139
            end;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.ValidateCity("HMX City", "HMX Post Code", "HMX County", "HMX Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50008; "HMX Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the country/region of the address.';

        }
        field(50009; "HMX Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            DataClassification = CustomerContent;
            TableRelation = if ("HMX Country/Region Code" = const('')) "Post Code"
            else
            if ("HMX Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("HMX Country/Region Code"));
            ValidateTableRelation = false;
            ToolTip = 'Specifies the post code.';

            trigger OnLookup()
            var
                PostCode: Record "Post Code";
            begin
#pragma warning disable AA0139
                PostCode.LookupPostCode("HMX City", "HMX Post Code", "HMX County", "HMX Country/Region Code");
#pragma warning restore AA0139
            end;
        }
        field(50010; "HMX County"; Text[30])
        {
            CaptionClass = '5,1,' + "HMX Country/Region Code";
            Caption = 'State';
            DataClassification = CustomerContent;
            OptimizeForTextSearch = true;
            ToolTip = 'Specifies the state, province or county as a part of the address.';
        }
        field(50011; "HMX ReportableEvent"; Boolean)
        {
            Caption = 'Reportable Event (MDR Required)';
            ToolTip = 'Specifies the Reportable Event';
            DataClassification = CustomerContent;
        }
        field(50012; "HMX NonRequiredEvent"; Boolean)
        {
            Caption = 'Non-Required Event (MDR is not required)';
            ToolTip = 'Specifies the Non required Event';
            DataClassification = CustomerContent;
        }
        field(50013; "HMX ComplaintInvestReq"; Boolean)
        {
            Caption = 'Complaint Investigation Required';
            ToolTip = 'Specifies if the complaint investigation is required';
            DataClassification = CustomerContent;
        }
        field(50014; "HMX CorrectiveActionReq"; Boolean)
        {
            Caption = 'Corrective Action Required';
            ToolTip = 'Specifies if the Corrective action is required';
            DataClassification = CustomerContent;
        }
        field(50015; "HMX Complaintcategory"; Enum "HMX Complaint Category")
        {
            Caption = 'Complaint Category';
            ToolTip = 'Specifies the complaint category';
            DataClassification = CustomerContent;
        }
        field(50016; "HMX Justification"; Text[250])
        {
            Caption = 'Justification if no investigation is required';
            ToolTip = 'Specifies the justification if no investigation is required';
            DataClassification = CustomerContent;
        }
        field(50017; "HMX ExistingCaseTracking"; Text[100])
        {
            Caption = 'Existing Case Tracking the Complaint';
            ToolTip = 'Specifies the exisiting case tracking of the complaint';
            DataClassification = CustomerContent;
            TableRelation = "HMX ExistingCaseTracking";
        }
        field(50018; "HMX JustificationNoCAPA"; Text[250])
        {
            Caption = 'Justification if No CAPA is Required';
            ToolTip = 'Specifies the Justification if No CAPA is Required';
            DataClassification = CustomerContent;
        }
        field(50019; "HMX CorrectiveAction"; Text[250])
        {
            Caption = 'Corrective Action #';
            ToolTip = 'Specifies the Corrective Action #';
            DataClassification = CustomerContent;
        }
        field(50020; "HMX FaultCategory"; Text[100])
        {
            Caption = 'Fault Category';
            ToolTip = 'Specifies the fault category';
            DataClassification = CustomerContent;
            TableRelation = "HMX Fault category";
        }
        field(50021; "HMX Faultdescription"; Text[250])
        {
            Caption = 'Fault Description';
            ToolTip = 'Specifies the fault decsription';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



}