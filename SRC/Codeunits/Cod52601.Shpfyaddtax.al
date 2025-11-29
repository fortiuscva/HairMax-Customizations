namespace HairMaxCustomizations.HairMaxCustomizations;
using Microsoft.Integration.Shopify;
using Microsoft.Finance.SalesTax;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.Document;

codeunit 52601 "HMX Shpfyaddtax"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shpfy Order Events", 'OnAfterCreateShippingCostSalesLine', '', false, false)]
    local procedure AddTaxLineToSalesOrder(ShopifyOrderHeader: Record "Shpfy Order Header"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        SalesLineRec: Record "Sales Line";
        TaxSetup: Record "Tax Setup";
        GLAccount: Record "G/L Account";
    begin

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
}
