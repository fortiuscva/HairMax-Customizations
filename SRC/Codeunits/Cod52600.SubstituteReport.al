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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", OnBeforeDeleteDocumentReservation, '', false, false)]
    local procedure "Reservation Management_OnBeforeDeleteDocumentReservation"(TableID: Integer; DocType: Option; DocNo: Code[20]; var HideValidationDialog: Boolean)
    begin
        if HairmaxSingleInstance.GetHideDeleteSOReservationConfirm() then
            HideValidationDialog := true;
    end;

    var
        HairmaxSingleInstance: Codeunit "HMX HairMax Single Instance";
}