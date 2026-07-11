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

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterCopyBuyFromVendorFieldsFromVendor, '', false, false)]
    local procedure "Purchase Header_OnAfterCopyBuyFromVendorFieldsFromVendor"(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."HMX Shipping Agent Code" := Vendor."Shipping Agent Code";
        PurchaseHeader.Modify();
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
        If OrderHeader."Phone No." = '' then
            SalesHeader.Validate("Sell-to Phone No.", '561-314-2430');
        If OrderHeader."Sell-to Country/Region Code" = '' then
            SalesHeader.Validate("Sell-to Country/Region Code", 'US');
        SalesHeader.Modify(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DSHIP Event Publisher", OnAfterGetLabel, '', false, false)]
    local procedure OnAfterGetLabel(docType: Enum "DSHIP Document Type"; docNo: Code[50])
    var
        IWXLPHeader: Record "IWX LP Header";
        SalesHeader: Record "Sales Header";
    begin
        IWXLPHeader.Reset();
        IWXLPHeader.SetRange("Source Document", IWXLPHeader."Source Document"::"Sales Order");
        IWXLPHeader.SetRange("Source No.", docNo);
        If IWXLPHeader.FindSet() then begin
            if IWXLPHeader.Count = 1 then
                if IWXLPHeader."Has Carrier Label" then begin
                    SalesHeader.SetRange("No.", docNo);
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"HMX Sales Order Packing Slip", true, true, SalesHeader);
                end;
        end;
    end;
}