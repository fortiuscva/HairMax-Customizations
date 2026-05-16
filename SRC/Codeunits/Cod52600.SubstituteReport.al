codeunit 52600 "HMX SubstituteReport"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin

        //Sales Order Report Substitute
        if ReportId = Report::"Standard Sales - Order Conf." then
            NewReportId := Report::"HMX Sales Order";

        //Purchase Order Report Substitute
        if ReportId = Report::"Standard Purchase - Order" then
            NewReportId := Report::"HMX PurchaseOrder"
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeManualReleaseSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnBeforeManualReleaseSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SelltoContact: Record Contact;
    begin
        SalesHeader.TestField("Sell-to Country/Region Code");
        SalesHeader.ValidateSellToPhoneNo(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shpfy Order Events", OnAfterCreateSalesHeader, '', false, false)]
    local procedure "Shpfy Order Events_OnAfterCreateSalesHeader"(OrderHeader: Record "Shpfy Order Header"; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("Sell-to Phone No.", '561-314-2430');
        SalesHeader.Validate("Sell-to Country/Region Code", 'US');
        SalesHeader.Modify(true);
    end;
}