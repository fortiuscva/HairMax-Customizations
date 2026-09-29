table 52607 "HMX Customer Packing Group"
{
    Caption = 'Customer Packing Group';
    DataClassification = CustomerContent;
    DrillDownPageId = "HMX Customer Packing Groups";
    LookupPageId = "HMX Customer Packing Groups";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Packing Comments"; Text[2048])
        {
            Caption = 'Packing Comments';
        }
        field(3; "Labeling Comments"; Text[2048])
        {
            Caption = 'Labeling Comments';
        }
        field(4; "Fulfillment Comments"; Text[2048])
        {
            Caption = 'Fulfillment Comments';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
