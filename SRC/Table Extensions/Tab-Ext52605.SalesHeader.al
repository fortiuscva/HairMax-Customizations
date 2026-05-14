namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;
using Microsoft.CRM.Contact;

tableextension 52605 "HMX Sales Header" extends "Sales Header"
{
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
