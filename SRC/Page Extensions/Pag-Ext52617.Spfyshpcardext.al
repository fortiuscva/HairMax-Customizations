pageextension 52617 "HMX Spfyshpcardext" extends "Shpfy Shop Card"
{
    layout
    {
        addafter(CashRoundingsAccount)
        {
            field("HMX Order No. Series"; Rec."HMX Order No. Series")
            {
                ApplicationArea = All;
            }
            field("HMX Posted Invoice No series."; Rec."HMX Posted Invoice No series.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}