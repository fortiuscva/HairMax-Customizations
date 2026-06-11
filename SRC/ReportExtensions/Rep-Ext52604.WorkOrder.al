namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;

reportextension 52604 "HMX Work Order" extends "Work Order"
{
    RDLCLayout = './SRC/ReportExtensions/Layouts/WorkOrder.rdl';
    labels
    {
        WorkOrderReportHeaderCaption = 'Sales Order';
    }
}
