table 52605 "HMX Shopify Order Buffer"
{
    TableType = Temporary;

    fields
    {
        field(1; "Order Id"; BigInteger) { }
        field(2; "Tags"; Text[250]) { }
        field(3; "Created At"; Date) { }
    }

    keys
    {
        key(PK; "Order Id") { Clustered = true; }
    }
}