namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Forecast;
using Microsoft.Purchases.Document;

tableextension 52614 "HMX Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(52600; "HMX Forecast Quantity"; Decimal)
        {
            Caption = 'Forecast Quantity';
            Editable = false;
        }

        field(52601; "HMX On-hand Quantity"; Decimal)
        {
            Caption = 'On-hand Quantity';
            Editable = false;
        }

        field(52602; "HMX Recommended Supply"; Decimal)
        {
            Caption = 'Recommended Supply';
            Editable = false;
        }

        field(52603; "HMX Quick Order Calc"; Decimal)
        {
            Caption = 'Quick Order Calc';
            Editable = false;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            begin
                CalculateValues();
            end;
        }
    }
    procedure CalculateValues()
    var
        ProdForecastEntry: Record "Production Forecast Entry";
        ItemRec: Record Item;
        StartDate: Date;
        EndDate: Date;
    begin
        // Forecast Quantity

        if Rec."Due Date" <> 0D then begin
            StartDate := DMY2Date(1, Date2DMY(Rec."Due Date", 2), Date2DMY(Rec."Due Date", 3));
            EndDate := CalcDate('<1M-1D>', StartDate); // End of month
        end;

        Rec."HMX Forecast Quantity" := 0;
        ProdForecastEntry.Reset();
        ProdForecastEntry.SetRange("Item No.", Rec."No.");
        ProdForecastEntry.SetRange("Forecast Date", StartDate, EndDate);

        if ProdForecastEntry.FindSet() then
            repeat
                Rec."HMX Forecast Quantity" += ProdForecastEntry."Forecast Quantity";
            until ProdForecastEntry.Next() = 0;

        // On-hand Quantity
        ItemRec.Get(Rec."No.");
        ItemRec.CalcFields("Qty. on Purch. Order", Inventory);
        Rec."HMX On-hand Quantity" := ItemRec.Inventory;


        // Recommended Supply
        Rec."HMX Recommended Supply" := ItemRec."Qty. on Purch. Order" + Rec."HMX Forecast Quantity";

        // Quick Order
        Rec."HMX Quick Order Calc" := Rec."HMX Recommended Supply" - Rec."HMX On-hand Quantity";

        if Rec."HMX Quick Order Calc" < 0 then
            Rec."HMX Quick Order Calc" := 0;

    end;

}
