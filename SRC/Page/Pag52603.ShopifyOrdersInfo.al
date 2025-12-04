page 52603 "HMX Shopify Orders Info"
{
    ApplicationArea = All;
    Caption = 'Shopify Orders Information';
    PageType = List;
    SourceTable = "HMX Shopify Order Info";
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Shopify Order No."; Rec."Shopify Order No.")
                {
                    ToolTip = 'Specifies the value of the Shopify Order No. field.', Comment = '%';
                }
                field("Sales Orders Count"; Rec."Sales Orders Count")
                {
                    ToolTip = 'Specifies the value of the Sales Orders Count field.', Comment = '%';
                }
                field("Sales Order Nos."; Rec."Sales Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Sales Order Nos. field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Log_Shopify_Orders_Info)
            {
                ApplicationArea = area;
                Caption = 'Log Shopify Orders Information';
                Image = Log;
                trigger OnAction()
                var
                    ShopifyOrderSummaryMgt: Codeunit "HMX Shopify Order Info Mgt";
                begin
                    ShopifyOrderSummaryMgt.LogShopifyOrderInfo(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }
}
