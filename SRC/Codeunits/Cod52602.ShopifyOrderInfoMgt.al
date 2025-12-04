codeunit 52602 "HMX Shopify Order Info Mgt"
{
    procedure LogShopifyOrderInfo(var ShopifyOrdInfo: Record "HMX Shopify Order Info")
    var
        SalesHeader: Record "Sales Header";
        ShopifyOrderInfo: Record "HMX Shopify Order Info";
        ShopifyOrderNo: Code[50];
    begin
        ShopifyOrderInfo.DeleteAll(true);

        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter("Shpfy Order No.", '<>%1', ''); //Shopify Order No. should not be blank.
        if SalesHeader.FindSet() then begin
            repeat
                ShopifyOrderNo := SalesHeader."Shpfy Order No.";
                if not ShopifyOrderInfo.Get(ShopifyOrderNo) then begin
                    ShopifyOrderInfo.Init();
                    ShopifyOrderInfo."Shopify Order No." := ShopifyOrderNo;
                    ShopifyOrderInfo."Sales Orders Count" := 1;
                    ShopifyOrderInfo."Sales Order Nos." := SalesHeader."No.";
                    ShopifyOrderInfo.Insert(true);
                end else begin
                    ShopifyOrderInfo."Sales Orders Count" += 1;
                    ShopifyOrderInfo."Sales Order Nos." := ShopifyOrderInfo."Sales Order Nos." + '|' + SalesHeader."No.";
                    ShopifyOrderInfo.Modify(true);
                end;
            until SalesHeader.Next() = 0;
        end;
    end;
}
