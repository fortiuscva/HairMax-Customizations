report 52601 "HMX PurchaseOrder"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Hairmax Purchase Order Report';
    RDLCLayout = './SRC/RDL/HairmaxPurchaseOrder.rdl';

    dataset
    {
        dataitem(purchaseHeader; "Purchase Header")
        {

            RequestFilterFields = "No.";

            column(CompanyInfo_Picture; CompanyInfo_Grec.Picture)
            {
            }
            column(CompanyInfo_Name; this.CompanyInfo_Grec.Name)
            {
            }
            column(CompanyInfo_Address; this.CompanyInfo_Grec.Address)
            {
            }
            column(CompanyInfo_Address2; this.CompanyInfo_Grec."Address 2")
            {
            }
            column(CompanyInfo_City; this.CompanyInfo_Grec.City)
            {
            }
            column(CompanyInfo_State; this.CompanyInfo_Grec.County)
            {
            }
            column(CompanyInfo_ZipCode; this.CompanyInfo_Grec."Post Code")
            {
            }
            column(LocalCurrencySymbol; this.GenLedSetup_GRec."Local Currency Symbol")
            {

            }
            column(No_; "No.")
            {
            }
            column(Order_Date; "Posting Date")
            {
            }
            column(Requested_Receipt_Date; "Requested Receipt Date")
            {
            }
            column(Payment_Terms_Code; paymentTermsDesc)
            {
            }
            column(Vendor_Order_No_; "Vendor Order No.")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Buy_from_Address; "Buy-from Address")
            {
            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {
            }
            column(Buy_from_City; "Buy-from City")
            {
            }
            column(Buy_from_County; "Buy-from County")
            {
            }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code")
            {
            }
            column(buy_from_Post_Code; "Buy-from Post Code")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {
            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {
            }

            column(EncodeTextCode39; this.EncodeTextCode39)
            {

            }
            column(Requistioner; requistioner)
            {

            }
            column(RequistionerContact; requistionerContact)
            {

            }

            column(Expected_Receipt_Date; "Expected Receipt Date")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }
            column(Payment_Method_Code; "Payment Method Code")
            {

            }
            column(commentarray; commentarray_Grec)
            {

            }
            column(PaymentMethodCode; paymentMethodDesc)
            {

            }
            column(Agent_Code; "Purchaser Code")
            {
            }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = purchaseHeader;
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = where(Type = const(Type::Item));
                column(ItemNo; "No.")
                {

                }

                column(Quantity; Quantity)
                {

                }
                column(Description; Description)
                {

                }

                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Serial_LotNo_GRec; this.Serial_LotNo_GRec)
                {

                }
                column(Total; Total)
                {

                }
                column(Line_Expected_Receipt_Date; "Expected Receipt Date")
                {

                }
                trigger OnPreDataItem()

                begin
                    Clear(Total);
                end;

                trigger OnAfterGetRecord()

                begin

                    Clear(this.Serial_LotNo_GRec);
                    this.ReservationEntry_GRec.Reset();
                    this.ReservationEntry_GRec.SetRange("Source Type", 39);
                    this.ReservationEntry_GRec.SetRange("Source Subtype", 1);
                    this.ReservationEntry_GRec.SetRange("Source ID", "Purchase Line"."Document No.");
                    this.ReservationEntry_GRec.SetRange("Source Ref. No.", "Purchase Line"."Line No.");
                    if this.ReservationEntry_GRec.FindSet() then
                        repeat
                            if this.ReservationEntry_GRec."Serial No." <> '' then
                                if Serial_LotNo_GRec <> '' then
                                    Serial_LotNo_GRec := Serial_LotNo_GRec + ', ' + this.ReservationEntry_GRec."Serial No."
                                else
                                    this.Serial_LotNo_GRec += this.ReservationEntry_GRec."Serial No."
                            else
                                this.Serial_LotNo_GRec := this.ReservationEntry_GRec."Lot No.";
                        until this.ReservationEntry_GRec.Next() = 0;
                    Total += "Purchase Line".Amount;
                end;

                trigger OnPostDataItem()

                begin

                end;


            }



            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";

            begin
                Clear(Requistioner);
                Clear(requistionerContact);
                Clear(paymentTermsDesc);
                Clear(paymentMethodDesc);
                Clear(commentarray_Grec);
                if PurcharserCode_Grec.Get(purchaseHeader."Purchaser Code") then begin
                    Requistioner := PurcharserCode_Grec.Name;
                    requistionerContact := PurcharserCode_Grec."Phone No.";
                end;
                if this.PaymentMethod_Grec.Get(purchaseHeader."Payment Method Code") then
                    paymentMethodDesc := this.PaymentMethod_Grec.Description;
                if this.PaymentTerms_Grec.Get(purchaseHeader."Payment Terms Code") then
                    paymentTermsDesc := this.PaymentTerms_Grec.Description;
                //Get the comments
                PurchOrderComments_GRec.Reset();
                PurchOrderComments_GRec.SetRange("Document Type", purchaseHeader."Document Type");
                PurchOrderComments_GRec.SetRange("No.", purchaseHeader."No.");
                if PurchOrderComments_GRec.FindSet() then
                    repeat
                        if commentarray_Grec = '' then
                            commentarray_Grec := PurchOrderComments_GRec.Comment
                        else
                            commentarray_Grec += ' ,' + PurchOrderComments_GRec.Comment;
                    until PurchOrderComments_GRec.Next() = 0;

                //Print barcode
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                BarcodeString := "No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                this.EncodeTextCode39 := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;


        }





    }
    requestpage

    {
        SaveValues = true;
    }

    labels
    {
        PurchaseOrderLbl = 'Purchase Order';
        DateLbl = 'Date';
        POLbl = 'PO#';
        ReceiveByLbl = 'Receive By:';
        VendorLbl = 'Vendor';
        ShiptoLbl = 'Ship To';
        RequisitionerLbl = 'Requisitioner';
        RequisitionerContactLbl = 'Requistioner Contact';
        ExpectedShipDateLbl = 'Expected Ship Date';
        ShippingTermLbl = 'Shipping Terms';
        PaymentTermLbl = 'Payment Method';
        ShippingMethodLbl = 'Shipping Method';
        ItemLbl = 'Item';
        QuantityLbl = 'Quantity';
        DescriptionLbl = 'Description';
        UnitCostLbl = 'Units';
        AmountLbl = 'Amount';
        SerialLotNoLbl = 'Serial / Lot Numbers';
        rateLbl = 'Rate';
        TotalLbl = 'Total';
        NotesLbl = 'Notes';
        SignatureofApprovalLbl = 'Signature of Approval';
        DateofApprovalLbl = 'Date of Approval';



    }
    trigger OnPreReport()
    begin
        if this.CompanyInfo_Grec.Get() then
            this.CompanyInfo_Grec.CalcFields(Picture);
        if this.GenLedSetup_GRec.Get() then;
    end;

    trigger OnInitReport()

    begin
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
    end;



    var
        CompanyInfo_Grec: Record "Company Information";
        PaymentMethod_Grec: Record "Payment Method";
        PaymentTerms_Grec: Record "Payment Terms";
        ReservationEntry_GRec: Record "Reservation Entry";
        GenLedSetup_GRec: Record "General Ledger Setup";
        PurchOrderComments_GRec: Record "Purch. Comment Line";
        PurcharserCode_Grec: Record "Salesperson/Purchaser";
        WorkDescriptionLine_Grec: Text;
        Serial_LotNo_GRec: Text;
        EncodeTextCode39: Text;
        BarcodeSymbology: Enum "Barcode Symbology";
        commentarray_Grec: Text;
        Total: Decimal;
        Requistioner: Text;
        requistionerContact: Text;
        paymentTermsDesc: Text;
        paymentMethodDesc: Text;


}