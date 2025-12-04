codeunit 52602 "HMX Shopify Order Info Mgt"
{
    procedure LogShopifyOrderInfo(var TempShopifyOrdInfo: Record "HMX Shopify Order Info" temporary)
    var
        SalesHeader: Record "Sales Header";
        TempShopifyOrderInfo: Record "HMX Shopify Order Info" temporary;
        ShopifyOrderNo: Code[50];
    begin
        TempShopifyOrderInfo.DeleteAll(true);

        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter("Shpfy Order No.", '<>%1', ''); //Shopify Order No. should not be blank.
        if SalesHeader.FindSet() then begin
            repeat
                ShopifyOrderNo := SalesHeader."Shpfy Order No.";
                if not TempShopifyOrderInfo.Get(ShopifyOrderNo) then begin
                    TempShopifyOrderInfo.Init();
                    TempShopifyOrderInfo."Shopify Order No." := ShopifyOrderNo;
                    TempShopifyOrderInfo."Sales Orders Count" := 1;
                    TempShopifyOrderInfo."Sales Order Nos." := SalesHeader."No.";
                    TempShopifyOrderInfo.Insert(true);
                end else begin
                    TempShopifyOrderInfo."Sales Orders Count" += 1;
                    TempShopifyOrderInfo."Sales Order Nos." := TempShopifyOrderInfo."Sales Order Nos." + '|' + SalesHeader."No.";
                    TempShopifyOrderInfo.Modify(true);
                end;
            until SalesHeader.Next() = 0;
        end;
    end;
}
