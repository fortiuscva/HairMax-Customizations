namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Assembly.Document;

reportextension 52601 "HMX Assembly Order" extends "Assembly Order"
{
    RDLCLayout = './SRC/ReportExtensions/Layouts/AssemblyOrder.rdlc';

    labels
    {
        PickInitialsCaption = 'Pick Initials';
        InspectInitialsCaption = 'Inspect Initials';
        QtyPickedCaption = 'Qty. Pick';
        QtyConsumedCaption = 'Qty. Cons.';
    }
}
