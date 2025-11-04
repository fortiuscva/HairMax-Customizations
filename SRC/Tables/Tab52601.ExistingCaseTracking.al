table 52601 "HMX ExistingCaseTracking"
{
    Caption = 'Existing Case Tracking';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Internal ID"; Text[100])
        {
            Caption = 'Internal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Internal ID for the exisiting case';
        }
        field(2; Number; Code[100])
        {
            Caption = 'Number';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Number for the exisiting case';
        }
        field(3; "Incident Date"; DateTime)
        {
            Caption = 'Incident Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Incident Date for the exisiting case';
        }
        field(4; Company; Text[250])
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the company for the exisiting case';
        }
        field(5; Subject; Text[250])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject for the exisiting case';
        }
        field(6; Item; Text[250])
        {
            Caption = 'Item';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the item for the exisiting case';
        }
        field(7; Priority; Text[100])
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the priority for the exisiting case';
        }
        field(8; Stage; Text[100])
        {
            Caption = 'Stage';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the stage for the exisiting case';
        }
        field(9; Status; Text[100])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the status for the exisiting case';
        }
        field(10; Type; Text[100])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the type for the exisiting case';
        }
        field(11; "Warranty Status"; Text[100])
        {
            Caption = 'Warranty Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the warranty status for the exisiting case';
        }
        field(12; "Fault category"; Text[100])
        {
            Caption = 'Fault category';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fault category for the exisiting case';
        }
        field(13; "Assigned To"; Text[250])
        {
            Caption = 'Assigned To';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the assigned to for the exisiting case';
        }
        field(14; Country; Text[100])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the country for the exisiting case';
        }
    }
    keys
    {
        key(PK; "Internal ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Internal ID", Number, "Incident Date", Company, Subject, Item, Priority, Stage, Status, Type, "Warranty Status", "Fault category", "Assigned To", Country)
        {

        }
    }
}