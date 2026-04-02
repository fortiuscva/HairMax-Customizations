tableextension 52611 "HMX ShopifyShopext" extends "Shpfy Shop"
{
    fields
    {
        field(52600; "HMX Order No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Order No. Series';
        }
        field(52601; "HMX Posted Invoice No series."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Posted Invoice No series';
        }

        field(52602; "HMX Old No series"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
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