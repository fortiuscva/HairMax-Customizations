query 52600 "HMX Shopify Sales Orders"
{
    Caption = 'Shopify Sales Orders';
    QueryType = Normal;

    elements
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(ShpfyOrderNo; "Shpfy Order No.")
            {
            }
            column(No; "No.")
            {
                // Method = Count;
            }
        }
    }
}
