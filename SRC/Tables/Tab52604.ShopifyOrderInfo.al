table 52604 "HMX Shopify Order Info"
{
    Caption = 'Shopify Order Information';
    TableType = Temporary;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Shopify Order No."; Code[50])
        {
            Caption = 'Shopify Order No.';
            DataClassification = CustomerContent;
        }
        field(2; "Sales Orders Count"; Integer)
        {
            Caption = 'Sales Orders Count';
            DataClassification = CustomerContent;
        }
        field(3; "Sales Order Nos."; Text[2048])
        {
            Caption = 'Sales Order Nos.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Shopify Order No.")
        {
            Clustered = true;
        }
    }
}
