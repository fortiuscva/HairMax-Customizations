namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Assembly.Document;

reportextension 52601 "HMX Assembly Order" extends "Assembly Order"
{
    RDLCLayout = './SRC/ReportExtensions/Layouts/AssemblyOrder.rdlc';

    labels
    {
        QtyReturntoStockCaption = 'Qty Return to Stock';
        InitialsCaption = 'Initials';
        QtyPickedCaption = 'Qty. Pick';
        QtyConsumedCaption = 'Qty. Cons.';
    }
}
