namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;
using Microsoft.CRM.Contact;

tableextension 52605 "HMX Sales Header" extends "Sales Header"
{

    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                HairmaxFunctionCU: Codeunit "HMX Hairmax Functions";
            begin
                if "Sell-to Country/Region Code" = '' then
                    "Sell-to Country/Region Code" := 'US';
                if "Shpfy Order No." <> '' then
                    if "Salesperson Code" = '' then
                        "Salesperson Code" := 'SHOPIFY';
                case Rec."Document Type" of
                    Rec."Document Type"::Quote,
                    Rec."Document Type"::"Credit Memo",
                    Rec."Document Type"::Invoice,
                    Rec."Document Type"::"Return Order":
                        begin
                            if Rec."Sell-to Contact No." <> '' then begin
                                HairmaxFunctionCU.UpdateSelltoPhoneNo(Rec."Sell-to Contact No.");
                            end;
                        end;
                    else if Rec."Sell-to Phone No." = '' then
                        Rec."Sell-to Phone No." := '561-314-2430';
                end;
                Rec.Modify(true);
            end;
        }
    }

    procedure ValidateSellToPhoneNo(var SalesHeader: Record "Sales Header")
    var
        SelltoContact: Record Contact;
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote,
            SalesHeader."Document Type"::"Credit Memo",
            SalesHeader."Document Type"::Invoice,
            SalesHeader."Document Type"::"Return Order":
                begin
                    if SalesHeader."Sell-to Contact No." <> '' then begin
                        SelltoContact.Get(SalesHeader."Sell-to Contact No.");
                        SelltoContact.TestField("Phone No.");
                    end else
                        SalesHeader.TestField("Sell-to Contact No.");
                end;
            else
                SalesHeader.TestField("Sell-to Phone No.");
        end;
    end;
}
