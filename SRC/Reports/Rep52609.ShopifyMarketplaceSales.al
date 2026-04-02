report 52609 "HMX Shopify Marketplace Sales"
{
    Caption = 'Shopify Marketplace Sales';
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

            trigger OnAfterGetRecord()
            var
                SalesInvHeader: Record "Sales Invoice Header";
                OrderId: BigInteger;
            begin
                if not SalesInvHeader.Get("Document No.") then
                    CurrReport.Skip();

                OrderId := SalesInvHeader."Shpfy Order Id";
                if OrderId = 0 then
                    CurrReport.Skip();

                if not ShopifyBuffer.Get(OrderId) then
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
                        if Retailer <> 'SC' then
                            CurrReport.Skip();

                    RetailerFilter::ShopSimon:
                        if Retailer <> 'SS' then
                            CurrReport.Skip();

                    RetailerFilter::Both:
                        if (Retailer <> 'SC') and (Retailer <> 'SS') then
                            CurrReport.Skip();
                end;

                if SalesInvHeader."Order No." <> LastOrderNo then begin
                    LastOrderNo := SalesInvHeader."Order No.";
                    LastShipDate := GetLatestShipmentDate(
                        LastOrderNo,
                        SalesInvHeader."Posting Date");
                end;

                ShipDate := LastShipDate;
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
        Retailer: Code[10]; // SC / SS
        DateOfSale: Date;
        ShipDate: Date;

        DateFilterFrom: Date;
        DateFilterTo: Date;
        RetailerFilter: Option Both,SalonCentric,ShopSimon;

        LastOrderNo: Code[20];
        LastShipDate: Date;

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