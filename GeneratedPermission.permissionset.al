namespace hairmaxCustomePerm;

permissionset 52600 GeneratedPermission
{
    Assignable = true;
    Permissions = tabledata "HMX Complaint category"=RIMD,
        tabledata "HMX ExistingCaseTracking"=RIMD,
        tabledata "HMX Fault category"=RIMD,
        tabledata "HMX JustificationNoCAPA"=RIMD,
        table "HMX Complaint category"=X,
        table "HMX ExistingCaseTracking"=X,
        table "HMX Fault category"=X,
        table "HMX JustificationNoCAPA"=X,
        report "HMX Packing Slip"=X,
        report "HMX PurchaseOrder"=X,
        report "HMX Sales Credit memo"=X,
        report "HMX Sales Invoice"=X,
        report "HMX Sales Order"=X,
        codeunit "HMX SubstituteReport"=X,
        page "HMX ComplaintCategoryList"=X,
        page "HMX ExistingCaseTrackingList"=X,
        page "HMX FaultCategory"=X;
}