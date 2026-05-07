namespace HairMaxCustomizations.HairMaxCustomizations;
using Microsoft.Manufacturing.Forecast;

page 52604 "HMX Forecast FactBox"
{
    ApplicationArea = All;
    Caption = 'Forecast FactBox';
    PageType = ListPart;
    SourceTable = "Production Forecast Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the item identification number of the entry.';
                }
                field("Forecast Date"; Rec."Forecast Date")
                {
                    ToolTip = 'Specifies the date of the demand forecast to which the entry belongs.';
                }
                field("Forecast Quantity"; Rec."Forecast Quantity")
                {
                    ToolTip = 'Specifies the quantities you have entered in the demand forecast within the selected time interval.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location that is linked to the entry.';
                }
            }
        }
    }
}
