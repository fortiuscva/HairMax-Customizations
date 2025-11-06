report 52600 "HMX Sales Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Hairmax Sales Order Report';
    RDLCLayout = './SRC/RDL/HairmaxSalesOrder.rdl';

    dataset
    {
        dataitem("Sales_Header"; "Sales Header")
        {
            CalcFields = "Work Description";
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
            column(Order_Date; "Order Date")
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {
            }
            column(Bill_to_City; "Bill-to City")
            {
            }
            column(Bill_to_County; "Bill-to County")
            {
            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {
            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
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
            column(WorkDescriptionLine_Grec; this.WorkDescriptionLine_Grec)
            {

            }
            column(EncodeTextCode39; this.EncodeTextCode39)
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales_Header";
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                column(Quantity; Quantity)
                {

                }
                column(Description; Description)
                {

                }
                column(Amount_GRec; this.Amount_GRec)
                {

                }
                column(Rate_GRec; this.Rate_GRec)
                {

                }
                column(ShippingAmount_GRec; this.ShippingAmount_GRec)
                {

                }
                column(SubTotalAmount_GRec; this.SubTotalAmount_GRec)
                {

                }
                column(TotalAmount_Grec; this.TotalAmount_Grec)
                {

                }
                column(PaymentMethodCode; this.PaymentMethod_Grec.Description)
                {

                }
                column(Package_Tracking_No_; "Package Tracking No.")
                {

                }
                column(Serial_LotNo_GRec; this.Serial_LotNo_GRec)
                {

                }
                column(PrintLine; this.PrintLine)
                {

                }
                trigger OnPreDataItem()

                begin

                    Clear(this.ShippingAmount_GRec);
                    Clear(this.TotalAmount_Grec);
                    Clear(this.SubTotalAmount_GRec);

                end;

                trigger OnAfterGetRecord()

                begin
                    Clear(this.Rate_GRec);
                    Clear(this.Amount_GRec);
                    Clear(this.Serial_LotNo_GRec);
                    Clear(this.PrintLine);
                    if "Sales Line".Type = "Sales Line".Type::Item then begin
                        this.Rate_GRec := ("Sales Line"."Unit Price" - ("Sales Line"."Unit Price" * "Sales Line"."Line Discount %") / 100);
                        this.Amount_GRec := this.Rate_GRec * "Sales Line".Quantity;
                        this.SubTotalAmount_GRec += this.Amount_GRec;
                        this.PrintLine := 1;
                        this.ReservationEntry_GRec.Reset();
                        this.ReservationEntry_GRec.SetRange("Source Type", 37);
                        this.ReservationEntry_GRec.SetRange("Source Subtype", 1);
                        this.ReservationEntry_GRec.SetRange("Source ID", "Sales Line"."Document No.");
                        this.ReservationEntry_GRec.SetRange("Source Ref. No.", "Sales Line"."Line No.");
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
                    end;
                    if ("Sales Line".Type = "Sales Line".Type::"G/L Account") and ("Sales Line"."No." = '40391') then
                        this.ShippingAmount_GRec += "Sales Line".Amount;

                    this.TotalAmount_Grec := this.SubTotalAmount_GRec + this.ShippingAmount_GRec;



                end;

                trigger OnPostDataItem()

                begin

                end;


            }
            trigger OnPreDataItem()

            begin
                Clear(this.WorkDescriptionInstream_GRec);
                Clear(this.WorkDescriptionLine_Grec);

            end;

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                //print work description
                Sales_Header.CalcFields("Work Description");
                Sales_Header."Work Description".CreateInStream(this.WorkDescriptionInstream_GRec, TextEncoding::UTF8);
                this.WorkDescriptionInstream_GRec.ReadText(this.WorkDescriptionLine_Grec);

                if this.PaymentMethod_Grec.Get(Sales_Header."Payment Method Code") then;


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
        SalesOrderLbl = 'Sales Order';
        DateLbl = 'Date';
        OrderLbl = 'Order #';
        AnticipatedShipdateLbl = 'Anticipated Ship Date';
        PaymentTermsLbl = 'Terms';
        PoLbl = 'PO #';
        BillToLbl = 'Bill To';
        ShipToLbl = 'Ship To';
        NotestoShipperLbl = 'Notes to Shipper';
        QuantityLbl = 'Quantity';
        DescriptionLbl = 'Description';
        SerialLotLbl = 'Serial/Lot Numbers';
        RateLbl = 'Rate';
        AmountLbl = 'Amount';
        SubtotalLbl = 'Subtotal';
        ShippingCostLbl = 'Shipping Cost (Other)';
        TotalLbl = 'Total';
        CustomerShpSpecLbl = 'Customer Shipping Specifications';
        PaymentMtdLbl = 'Payment Method';
        CreditCardNoLbl = 'Credit Card #';
        TrackingLbl = 'Tracking #';
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
        ReservationEntry_GRec: Record "Reservation Entry";
        GenLedSetup_GRec: Record "General Ledger Setup";
        WorkDescriptionLine_Grec: Text;
        Serial_LotNo_GRec: Text;
        EncodeTextCode39: Text;
        WorkDescriptionInstream_GRec: InStream;
        Rate_GRec: Decimal;
        Amount_GRec: Decimal;
        ShippingAmount_GRec: Decimal;
        TotalAmount_Grec: Decimal;
        SubTotalAmount_GRec: Decimal;
        PrintLine: Decimal;
        BarcodeSymbology: Enum "Barcode Symbology";



}