table 52603 "HMX JustificationNoCAPA"
{
    Caption = 'Justification if No CAPA is Required';
    DataClassification = CustomerContent;

    fields
    {
        field(1; JustificationNoCAPA; Text[250])
        {
            Caption = 'Justification if No CAPA is Required';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; JustificationNoCAPA)
        {
            Clustered = true;
        }
    }
}
