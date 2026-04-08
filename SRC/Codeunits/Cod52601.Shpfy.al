namespace HairMaxCustomizations.HairMaxCustomizations;
using Microsoft.Integration.Shopify;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.Address;
using Microsoft.Finance.SalesTax;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.Document;

codeunit 52601 "HMX Shpfy"

{
    SingleInstance = true;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shpfy Order Events", 'OnAfterCreateItemSalesLine', '', false, false)]
    local procedure AddTaxLineToSalesOrder(ShopifyOrderHeader: Record "Shpfy Order Header"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        SalesLineRec: Record "Sales Line";
        TaxSetup: Record "Tax Setup";
        GLAccount: Record "G/L Account";
    begin

        SalesLineRec.Reset();
        SalesLineRec.SetRange("Document No.", SalesHeader."No.");
        SalesLineRec.SetRange(Type, SalesLineRec.Type::"G/L Account");
        if TaxSetup.Get() then
            SalesLineRec.SetRange("No.", TaxSetup."Tax Account (Sales)");
        if SalesLineRec.FindFirst() then
            exit;

        if (TaxSetup.Get()) and (GLAccount.Get(TaxSetup."Tax Account (Sales)")) and (ShopifyOrderHeader."VAT Amount" <> 0) then begin
            SalesLineRec.Init();
            SalesLineRec.Validate("Document Type", SalesHeader."Document Type");
            SalesLineRec.Validate("Document No.", SalesHeader."No.");
            SalesLineRec.Validate("Line No.", SalesLine."Line No." + 10000);
            SalesLineRec.Validate(Type, SalesLine.Type::"G/L Account");
            SalesLineRec.Validate("No.", GLAccount."No.");
            SalesLineRec.Validate(Description, 'Shopify Sales Tax');
            SalesLineRec.Validate(Quantity, 1);
            SalesLineRec.Validate("Unit Price", ShopifyOrderHeader."VAT Amount");
            SalesLineRec.Validate(Amount, ShopifyOrderHeader."VAT Amount");
            SalesLineRec.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shpfy Order Events", 'OnAfterCreateSalesHeader', '', false, false)]
    local procedure OnAfterCreateSalesHeader(var SalesHeader: Record "Sales Header"; OrderHeader: Record "Shpfy Order Header")
    var
        ShopifyShop: Record "Shpfy Shop";
        NoSeriesMgt: Codeunit "No. Series - Batch";
        SalesreceivablesSetup: Record "Sales & Receivables Setup";
    begin
        ShopifyShop.Get(OrderHeader."Shop Code");
        if SalesHeader."Ship-to Phone No." = '' then
            SalesHeader.Validate("Ship-to Phone No.", SalesHeader."Sell-to Phone No.");
        //   SalesHeader.Validate(, NoSeriesMgt.GetNextNo(ShopifyShop."HMX Posted Invoice No series."));
        NoSeriesMgt.SaveState();
        SalesreceivablesSetup.LockTable();
        if SalesreceivablesSetup.Get() then begin

            SalesreceivablesSetup.Validate("Order Nos.", ShopifyShop."HMX Old No series");
            SalesreceivablesSetup.Modify();
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shpfy Order Events", OnBeforeCreateSalesHeader, '', false, false)]
    local procedure OnBeforeCreateSalesHeader(ShopifyOrderHeader: Record "Shpfy Order Header"; var SalesHeader: Record "Sales Header"; var Handled: Boolean)

    var
        ShopifyShop: Record "Shpfy Shop";
        NoSeriesMgt: Codeunit "No. Series - Batch";
        SalesreceivablesSetup: Record "Sales & Receivables Setup";


    begin
        SalesreceivablesSetup.LockTable();
        if SalesreceivablesSetup.Get() then begin
            ShopifyShop.Get(ShopifyOrderHeader."Shop Code");
            ShopifyShop."HMX Old No series" := SalesreceivablesSetup."Order Nos.";
            SalesreceivablesSetup.Validate("Order Nos.", ShopifyShop."HMX Order No. Series");
            SalesreceivablesSetup.Modify();
            ShopifyShop.Modify();
        end;


    end;






}
