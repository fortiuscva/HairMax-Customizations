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

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterCopyBuyFromVendorFieldsFromVendor, '', false, false)]
    local procedure "Purchase Header_OnAfterCopyBuyFromVendorFieldsFromVendor"(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."HMX Shipping Agent Code" := Vendor."Shipping Agent Code";
        PurchaseHeader.Modify();
    end;
}