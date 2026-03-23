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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeManualReleaseSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnBeforeManualReleaseSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SelltoContact: Record Contact;
    begin
        SalesHeader.TestField("Salesperson Code");
        SalesHeader.TestField("Sell-to Country/Region Code");
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote,
            SalesHeader."Document Type"::"Credit Memo",
             SalesHeader."Document Type"::Invoice,
            SalesHeader."Document Type"::"Return Order":
                begin
                    if SalesHeader."Sell-to Contact No." <> '' then begin
                        SelltoContact.Get(SalesHeader."Sell-to Contact No.");
                        SelltoContact.TestField("Phone No.");
                    end else
                        SalesHeader.TestField("Sell-to Contact No.");
                end
            else
                SalesHeader.TestField("Sell-to Phone No.");
        end;
    end;
}