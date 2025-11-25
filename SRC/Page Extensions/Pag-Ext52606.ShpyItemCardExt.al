namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Inventory.Item;
using Microsoft.Integration.Shopify;
using Microsoft.Inventory.Reports;
using Microsoft.Manufacturing.Reports;


pageextension 52606 "HMX ShpyItemCardExt" extends "Item Card"
{
    actions
    {
        modify("Show product in Shopify")
        {
            Visible = false;
        }
        modify(Shopify)
        {
            Visible = true;
        }
        addlast(Shopify)
        {

            action("HMX Open Product in Shopify")
            {

                ApplicationArea = All;
                ToolTip = 'Opens the product in Shopify.';
                Image = CoupledItem;
                Caption = 'Open Product in Shopify';

                trigger OnAction()
                var
                    ShopifyProduct: Record "Shpfy Product";
                    Report: Report "Planning Availability";

                begin
                    ShopifyProduct.Reset();
                    ShopifyProduct.SetRange("Item SystemId", Rec.SystemId);
                    if ShopifyProduct.FindFirst() then
                        HyperLink(ShopifyProduct."Preview URL");
                end;

            }

        }
        addlast(Category_Shopify)
        {
            actionref("Open product in Shopify_Promote"; "HMX Open Product in Shopify")
            {
            }
        }
    }
}
