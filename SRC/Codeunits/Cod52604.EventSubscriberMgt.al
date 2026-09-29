codeunit 52604 "HMX Event Subscriber Mgt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader, '', false, false)]
    local procedure OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header")
    begin
        if SalesShptHeader."Posting Date" <> Today then
            SalesShptHeader."Posting Date" := Today;
    end;
}