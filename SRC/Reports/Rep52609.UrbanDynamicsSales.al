report 52609 "HMX Urban Dynamics Sales"
{
    Caption = 'Urban Dynamics Sales Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './SRC/RDL/ShopifyMarketplaceSales.rdl';

    dataset
    {
        dataitem(SalesInvLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.") WHERE(Type = CONST(Item));

            column(Retailer; Retailer) { }
            column(DateOfSale; Format(DateOfSale)) { }
            column(ShipDate; Format(ShipDate)) { }
            column(SKU; "No.") { }
            column(ItemName; Description) { }
            column(Quantity; Quantity) { }
            column(Amount; Amount) { }

            column(ShopifyOrderId; OrderId) { }
            column(SalesOrderNo; SalesOrderNo) { }
            column(SalespersonCode; SalespersonCode) { }

            trigger OnAfterGetRecord()
            var
                SalesInvHeader: Record "Sales Invoice Header";
                OrderIdLocal: BigInteger;
            begin
                Clear(IsShopifyMatch);
                Clear(IsCustomerMatch);

                if not SalesInvHeader.Get("Document No.") then
                    CurrReport.Skip();

                // Customer-based retailer
                if SalesInvHeader."Sell-to Customer No." = CustomerFilter then begin

                    if Customer.Get(CustomerFilter) then
                        Retailer := Customer.Name;

                    DateOfSale := SalesInvHeader."Posting Date";

                    IsCustomerMatch := true;
                end;

                OrderIdLocal := SalesInvHeader."Shpfy Order Id";
                if OrderIdLocal <> 0 then begin
                    if (ShopifyOrderFilter <> 0) and (OrderIdLocal <> ShopifyOrderFilter) then
                        CurrReport.Skip();

                    if not ShopifyBuffer.Get(OrderIdLocal) then
                        CurrReport.Skip();

                    ShopifyTag := ShopifyBuffer."Tags";
                    DateOfSale := ShopifyBuffer."Created At";

                    Retailer := GetRetailer(ShopifyTag);
                    if Retailer = '' then
                        CurrReport.Skip();

                    if (DateFilterFrom <> 0D) and (DateOfSale < DateFilterFrom) then
                        CurrReport.Skip();

                    if (DateFilterTo <> 0D) and (DateOfSale > DateFilterTo) then
                        CurrReport.Skip();

                    case RetailerFilter of
                        RetailerFilter::SalonCentric:
                            if Retailer = 'SC' then
                                IsShopifyMatch := true;

                        RetailerFilter::ShopSimon:
                            if Retailer = 'SS' then
                                IsShopifyMatch := true;

                        RetailerFilter::Both:
                            if (Retailer = 'SC') and (Retailer = 'SS') then
                                IsShopifyMatch := true;
                        RetailerFilter::None:
                            if (Retailer = 'SC') or (Retailer = 'SS') then
                                IsShopifyMatch := false;
                    end;
                end;

                SalesOrderNo := SalesInvHeader."Order No.";
                SalespersonCode := SalesInvHeader."Salesperson Code";
                OrderId := OrderIdLocal;

                if SalesInvHeader."Order No." <> LastOrderNo then begin
                    LastOrderNo := SalesInvHeader."Order No.";
                    LastShipDate := GetLatestShipmentDate(
                        LastOrderNo,
                        SalesInvHeader."Posting Date");
                end;

                ShipDate := LastShipDate;

                if not (IsShopifyMatch or IsCustomerMatch) then
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(DateFilterFrom; DateFilterFrom)
                    {
                        Caption = 'From Date (Shopify)';
                        ApplicationArea = All;
                    }

                    field(DateFilterTo; DateFilterTo)
                    {
                        Caption = 'To Date (Shopify)';
                        ApplicationArea = All;
                    }

                    field(RetailerFilter; RetailerFilter)
                    {
                        Caption = 'Retailer';
                        ApplicationArea = All;
                    }
                    field(CustomerFilter; CustomerFilter)
                    {
                        Caption = 'Retailer Customer';
                        ApplicationArea = All;
                        TableRelation = Customer."No." WHERE("HMX New Retailer" = CONST(true));
                    }

                    field(ShopifyOrderFilter; ShopifyOrderFilter)
                    {
                        Caption = 'Shopify Order Id';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        ShpfyOrderHeader: Record "Shpfy Order Header";
        ShpfyTag: Record "Shpfy Tag";
        TagText: Text;
    begin
        if ShpfyOrderHeader.FindSet() then
            repeat
                Clear(TagText);

                ShpfyTag.SetRange("Parent Id", ShpfyOrderHeader."Shopify Order Id");

                if ShpfyTag.FindSet() then
                    repeat
                        if TagText <> '' then
                            TagText += ',';
                        TagText += ShpfyTag.Tag;
                    until ShpfyTag.Next() = 0;

                if (StrPos(TagText, 'SalonCentric') > 0) or
                   (StrPos(TagText, 'Simon SPO') > 0) then begin

                    ShopifyBuffer.Init();
                    ShopifyBuffer."Order Id" := ShpfyOrderHeader."Shopify Order Id";
                    ShopifyBuffer."Tags" := TagText;
                    ShopifyBuffer."Created At" :=
                        DT2Date(ShpfyOrderHeader."Created At");

                    if not ShopifyBuffer.Get(ShopifyBuffer."Order Id") then
                        ShopifyBuffer.Insert();
                end;

            until ShpfyOrderHeader.Next() = 0;
    end;

    var
        ShopifyBuffer: Record "HMX Shopify Order Buffer" temporary;

        ShopifyTag: Text;
        Retailer: Text;
        DateOfSale: Date;
        ShipDate: Date;

        DateFilterFrom: Date;
        DateFilterTo: Date;

        RetailerFilter: Option Both,SalonCentric,ShopSimon,None;
        CustomerFilter: Code[20];
        ShopifyOrderFilter: BigInteger;

        SalesOrderNo: Code[20];
        SalespersonCode: Code[20];
        OrderId: BigInteger;

        LastOrderNo: Code[20];
        LastShipDate: Date;
        IsShopifyMatch: Boolean;
        IsCustomerMatch: Boolean;
        Customer: Record Customer;

    local procedure GetRetailer(Tag: Text): Code[10]
    begin
        if StrPos(Tag, 'SalonCentric') > 0 then
            exit('SC');

        if StrPos(Tag, 'Simon SPO') > 0 then
            exit('SS');

        exit('');
    end;

    local procedure GetLatestShipmentDate(OrderNo: Code[20]; FallbackDate: Date): Date
    var
        SalesShptLine: Record "Sales Shipment Line";
        SalesShptHeader: Record "Sales Shipment Header";
        MaxDate: Date;
    begin
        MaxDate := 0D;

        SalesShptLine.SetRange("Order No.", OrderNo);

        if SalesShptLine.FindSet() then
            repeat
                if SalesShptHeader.Get(SalesShptLine."Document No.") then
                    if SalesShptHeader."Posting Date" > MaxDate then
                        MaxDate := SalesShptHeader."Posting Date";
            until SalesShptLine.Next() = 0;

        if MaxDate = 0D then
            exit(FallbackDate);

        exit(MaxDate);
    end;
}