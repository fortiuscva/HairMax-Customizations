table 52602 "HMX Complaint category"
{
    Caption = 'Complaint category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Complaint Category Code"; Text[250])
        {
            Caption = 'Complaint Category Code';
        }
        field(2; "Complaint category Discussion"; Text[250])
        {
            Caption = 'Complaint category Description';
        }
    }
    keys
    {
        key(PK; "Complaint Category Code")
        {
            Clustered = true;
        }
    }
}
