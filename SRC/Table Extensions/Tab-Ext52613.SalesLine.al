namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;

tableextension 52613 "HMX Sales Line" extends "Sales Line"
{
    fields
    {

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
                DShipOptions: Record "DSHIP Package Options";
            begin
                if Rec.Type <> Rec.Type::Item then
                    exit;

                if not ItemRec.Get(Rec."No.") then
                    exit;

                DShipOptions.Reset();
                DShipOptions.SetRange("Entry Type", DShipOptions."Entry Type"::Document);
                DShipOptions.SetRange("Document Type", DShipOptions."Document Type"::"Sales Order");
                DShipOptions.SetRange("Document No.", Rec."Document No.");

                if DShipOptions.FindFirst() then begin
                    if DShipOptions."Delivery Confirmation" <> DShipOptions."Delivery Confirmation"::Signature then begin

                        DShipOptions."Delivery Confirmation" := DShipOptions."Delivery Confirmation"::Signature;

                        DShipOptions.Modify();
                    end else begin
                        DShipOptions."Delivery Confirmation" := DShipOptions."Delivery Confirmation"::" ";
                        DShipOptions.Modify();
                    end;
                end;
            end;
        }
    }
}
