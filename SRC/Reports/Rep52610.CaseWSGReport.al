namespace HairMaxCustomizations.HairMaxCustomizations;
using Microsoft.Foundation.Company;
using System.Environment.Configuration;

report 52610 "HMX Case WSG Report"
{
    ApplicationArea = All;
    Caption = 'Case WSG Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './SRC/RDL/CaseReportWSG.rdl';
    dataset
    {
        dataitem("RS Case"; "Case WSG")
        {
            CalcFields = "Reason Description", "Resolution Description";
            RequestFilterFields = "No.", "Entity Type", "Entity No.";
            column(AssignedTo; "RS Case"."Assigned User ID")
            {
                IncludeCaption = true;
            }
            column(CaseID; "RS Case"."No.")
            {
                IncludeCaption = true;
            }
            column(CompaintNotes; "RS Case"."Reason Notes")
            {
                IncludeCaption = true;
            }
            column(CompaintReason; "RS Case"."Reason Description")
            {
                IncludeCaption = true;
            }
            column(CompaintResolution; "RS Case"."Resolution Description")
            {
                IncludeCaption = true;
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(ContactName; "RS Case"."Contact Name")
            {
                IncludeCaption = true;
            }
            column(ContactPhone; "RS Case"."Contact Phone")
            {
                IncludeCaption = true;
            }
            column(CreatedBy; "RS Case"."Created By")
            {
                IncludeCaption = true;
            }
            column(CreatedOnDateTime; "RS Case"."Created On DateTime")
            {
                IncludeCaption = true;
            }
            column(LotNo; "RS Case"."No. of Lots")
            {
                IncludeCaption = true;
            }
            column(ModifiedBy; "RS Case"."Modified By")
            {
                IncludeCaption = true;
            }
            column(ModifiedOnDateTime; "RS Case"."Modified On DateTime")
            {
                IncludeCaption = true;
            }
            column(Name; "RS Case"."Entity Name")
            {
                IncludeCaption = true;
            }
            column(No; "RS Case"."Entity No.")
            {
                IncludeCaption = true;
            }
            column(ReasonNo; "RS Case"."Reason Code")
            {
                IncludeCaption = true;
            }
            column(ResolutionNo; "RS Case"."Resolution Code")
            {
                IncludeCaption = true;
            }
            column(ResolutionNotes; "RS Case"."Resolution Notes")
            {
                IncludeCaption = true;
            }
            column(ReturnMaterialPCCount; "RS Case"."Return Material PC Count")
            {
                IncludeCaption = true;
            }
            column(Status; "RS Case".Status)
            {
                IncludeCaption = true;
            }
            column(Type; "RS Case"."Entity Type")
            {
                IncludeCaption = true;
            }
            column(HMXcaseOrigin; "HMX case Origin")
            {
            }
            column(HMXcaseType; "HMX case Type")
            {
            }
            column(HMXcaseIssue; "HMX case Issue")
            {
            }
            //Contact Info

            column(HMXAddress; "HMX Address")
            {
            }
            column(HMXAddress2; "HMX Address 2")
            {
            }
            column(HMXCity; "HMX City")
            {
            }
            column(HMXCountryRegionCode; "HMX Country/Region Code")
            {
            }
            column(HMXState; "HMX County")
            {
            }
            column(HMXZipCode; "HMX Post Code")
            {
            }
            //Evaluation
            column(HMXIssueDetails; "Reason Notes")
            {
            }
            column(HMXSourceDocument; "Source Page Name")
            {
            }
            column(HMXSourceNo; "Source No.")
            {
            }
            column(HMXCaseIssue_AsEvaluated; "HMX Complaintcategory")
            {
            }
            column(HMXQualityEvaluation; HMXJustificationTxt)
            { }
            column(HMXAssociatedComplaints; "HMX ExistingCaseTracking")
            {
            }
            //Risk Assesment
            column(HMXComplaintInvestRequired; "HMX ComplaintInvestReq")
            {
            }
            column(HMXContainmentActionRequired; "HMX CorrectiveActionReq")
            {
            }
            column(HMXJustificationNoCAPA_RSCase; "HMX JustificationNoCAPA")
            {
            }
            column(HMXCAPAEscalationRequired; "HMX ReportableEvent")
            {
            }
            column(HMXAssociatedCAPA; "HMX CorrectiveAction")
            {
            }
            column(HMXFaultCategory; "HMX FaultCategory")
            {
            }
            column(HMXFaultdescription; "HMX Faultdescription")
            {
            }
            column(HMXReasonCode; "Reason Code")
            {
            }
            column(HMXResolutionCode; "Resolution Code")
            {
            }
            column(HMXResolutionDocument; "Resolution Page Name")
            {
            }
            column(HMXResolutionNo; "Resolution No.")
            {
            }
            column(HMXRelatedRecordCount; "Related Record Count")
            {
            }
            column(HMXCaseNotes; CaseNotesVar.ToText())
            { }
            dataitem(RelatedRecord; "Related Record WSG")
            {
                DataItemLink = "Case No." = field("No.");

                column(CaseRelation_RelatedRecord; "Case Relation")
                {
                }
                column(DocumentNo_RelatedRecord; "Document No.")
                {
                }
                column(DocumentPage_RelatedRecord; "Document Page")
                {
                }
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                IsCaseProcessed := false
            end;

            trigger OnAfterGetRecord()
            var
                RecordLink: Record "Record Link";
                NoteText: BigText;
                RecRef: RecordRef;
                FirstText: Text;
                FirstChar: Char;
                Stream: InStream;
                InStr: Instream;
            begin
                Clear(HMXJustificationTxt);
                HMXJustificationTxt := "RS Case".GetJustification();
                CaseNotesVar.Clear();
                RecRef.GetTable("RS Case");
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", RecRef.RecordId());
                RecordLink.SetRange(Type, RecordLink.Type::Note);

                RecordLink.Ascending(false);
                if RecordLink.FindFirst() then
                    repeat
                        RecordLink.CalcFields(Note);
                        if RecordLink.Note.HasValue() then begin
                            Clear(NoteText);
                            RecordLink.Note.CreateInStream(Stream);
                            NoteText.Read(Stream);
                            repeat
                                NoteText.GetSubText(FirstText, 1, 1);
                                if FirstText = '' then break;
                                FirstChar := FirstText[1];
                                if (FirstChar < 32) or (FirstChar > 126) then
                                    NoteText.GetSubText(NoteText, 2)
                                else
                                    break;
                            until false;
                            CaseNotesVar.AppendLine(Format(NoteText));

                        end;
                    until RecordLink.Next() = 0;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        ReportTitle = 'Case Report';
        PageLabel = 'Page';
        SubHeading1 = 'Contact Information';
        SubHeading2 = 'Case Details';
        RelatedDocHeading = 'Related Documents';
        RelatedRecLbl = ' Related Records ';
        CaseRelationLbl = 'Case Relation';
        DocumentPageLbl = 'Document Page';
        DocumentNoLbl = 'Document No.';

        EvaluationCaption = 'Evaluation';
        RiskAssessmentCaption = 'Risk Assessment';

        CaseOriginCaption = 'Case Origin';
        CaseTypeCaption = 'Case Type';
        CaseIssueCaption = 'Case Issue / As Reported';


        AddressCaption = 'Address';
        Address2Caption = 'Address 2';
        CityCaption = 'City';
        StateCaption = 'State';
        PostCodeCaption = 'Zip Code';
        CountryCaption = 'Country/Region Code';


        IssueDetailsCaption = 'Issue Details';
        SourceDocumentCaption = 'Source Document';
        SourceNoCaption = 'Source No.';
        EvaluatedIssueCaption = 'Case Issue / As Evaluated';
        QualityEvaluationCaption = 'Quality Evaluation';
        AssociatedComplaintCaption = 'Associated Complaint(s)';


        ComplaintInvestigationCaption = 'Complaint Investigation Required';
        ContainmentActionReqCaption = 'Containment Action Required';
        ContainmentActionCaption = 'Containment Action';
        JustificationNoCAPACaption = 'Justification (No CAPA)';
        CAPAEscalationCaption = 'CAPA Escalation Required';
        AssociatedCAPACaption = 'Associated CAPA';
        FaultCategoryCaption = 'Fault Category';
        FaultDescriptionCaption = 'Fault Description';


        ReasonCodeCaption = 'Reason Code';
        ResolutionCodeCaption = 'Resolution Code';
        ResolutionDocCaption = 'Resolution Document';
        HMXResolutionNoCaption = 'Resoution No';
        RelatedRecordCountCaption = 'Related Record Count';
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
    end;

    var
        CompanyInformation: Record "Company Information";
        CaseNotesVar: TextBuilder;
        HMXJustificationTxt: Text;
        IsCaseProcessed: Boolean;
}