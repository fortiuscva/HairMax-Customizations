namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;

reportextension 52600 "HMX Return Authorization" extends "Return Authorization"
{
    dataset
    {
        add(SalesLine)
        {
            column(HMXQtyReturnedCaption; QtyReturnedCaptionLbl)
            {
            }
            column(HMXInitialsCaption; InitialsCaptionLbl)
            {
            }
        }
    }

    rendering
    {
        layout(HMXReturnAuthorization)
        {
            Caption = 'HMX Return Authroization';
            LayoutFile = './SRC/ReportExtensions/Layouts/HMXReturnAuthorization.rdl';
            Summary = 'HMX Return Authroization';
            Type = RDLC;
        }
    }
    var
        QtyReturnedCaptionLbl: Label 'Quantity Returned';
        InitialsCaptionLbl: Label 'Initials';
}
