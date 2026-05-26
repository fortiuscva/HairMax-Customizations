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
                UpdateValues(Rec);
            end;
        }
    }

    procedure UpdateValues(var ReqLine: Record "Requisition Line")
    var
        Item: Record Item;
        ProdForecastEntry: Record "Production Forecast Entry";
        ForecastQty: Decimal;
        OnHandQty: Decimal;
        RecommendedSupply: Decimal;
        QuickOrderCalc: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        ForecastQty := 0;

        if Rec."Due Date" <> 0D then begin
            StartDate := DMY2Date(1, Date2DMY(Rec."Due Date", 2), Date2DMY(Rec."Due Date", 3));
            EndDate := CalcDate('<1M-1D>', StartDate);
        end;

        ProdForecastEntry.Reset();
        ProdForecastEntry.SetRange("Item No.", ReqLine."No.");
        ProdForecastEntry.SetRange("Forecast Date", StartDate, EndDate);
        if ProdForecastEntry.FindSet() then
            repeat
                ReqLine."HMX Forecast Quantity" += ProdForecastEntry."Forecast Quantity";
            until ProdForecastEntry.Next() = 0;

        if Item.Get(ReqLine."No.") then begin
            Item.CalcFields(Inventory, "Qty. on Purch. Order");
            OnHandQty := Item.Inventory;
            ReqLine."HMX On-hand Quantity" := OnHandQty;
            ReqLine."HMX Recommended Supply" := Item."Qty. on Purch. Order" + Rec."HMX Forecast Quantity";
        end;

        QuickOrderCalc := ReqLine."HMX Recommended Supply" - ReqLine."HMX On-hand Quantity";
        if QuickOrderCalc < 0 then
            QuickOrderCalc := 0;
        ReqLine."HMX Quick Order Calc" := QuickOrderCalc;
    end;
}
