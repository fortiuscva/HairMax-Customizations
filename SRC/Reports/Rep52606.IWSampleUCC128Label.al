/// ************************
/// Copyright Notice
///
/// This objects content is copyright (2010) of Insight Works.  All rights reserved.
/// Reproduction, modification, or distribution of part or all of the contents in any form is prohibited
/// without express written consent of Insight Works
///
///
/// www.dmsiworks.com
/// ************************

///<summary>
/// Use this report as an example or as a base to build additional SSCC reports or layouts.
///
/// Use the procedures at the bottom of the file to set the data on the report appropriately:
///   SetDocumentDetails(), SetPackageDetails(), SetItemDetails()
///
/// Add any additional required fields to the dataset and report layout.
/// </summary>
report 52606 "HMX IW Sample UCC128 Label"
{
    ApplicationArea = All;
    Caption = 'Sample UCC-128 Shipping Label';
    DefaultRenderingLayout = IWSampleUCC128;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(LPHeaderINIT; "IWX LP Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                CurrReport.Break();
            end;
        }

        dataitem(recSalesHeader; "Sales Header")
        {
            column(SalesOrderNumber; recSalesHeader."No.") { }
            column(ShipToName; recSalesHeader."Ship-to Name") { }
            column(ShipToName2; recSalesHeader."Ship-to Name 2") { }
            column(ShipToAddress; recSalesHeader."Ship-to Address") { }
            column(ShipToAddress2; recSalesHeader."Ship-to Address 2") { }
            column(ShipToCity; recSalesHeader."Ship-to City") { }
            column(ShipToCountry; recSalesHeader."Ship-to Country/Region Code") { }
            column(ShipToContact; recSalesHeader."Ship-to Contact") { }
            column(ShipToPostCode; recSalesHeader."Ship-to Post Code") { }
            column(ShipToCounty; recSalesHeader."Ship-to County") { }
            column(BillToCustomerNumber; recSalesHeader."Bill-to Customer No.") { }
            column(BillToName; recSalesHeader."Bill-to Name") { }
            column(BillToName2; recSalesHeader."Bill-to Name 2") { }
            column(BillToAddress; recSalesHeader."Bill-to Address") { }
            column(BillToAddress2; recSalesHeader."Bill-to Address 2") { }
            column(BillToCity; recSalesHeader."Bill-to City") { }
            column(BillToContact; recSalesHeader."Bill-to Contact") { }
            column(BillToPostCode; recSalesHeader."Bill-to Post Code") { }
            column(BillToCountry; recSalesHeader."Bill-to Country/Region Code") { }
            column(BillToCounty; recSalesHeader."Bill-to County") { }
            column(CarrierName; txtCarrierName) { }
            column(CarrierService; txtCarrierService) { }
            column(SSCCNo; codSSCCNum) { }
            column(PRONo; codPRONum) { }
            column(PONum; txtPurchOrderNum) { }
            column(ShipToPostTXT; txtShipToPost) { }
            column(ShipToPostBarcode; txtShipToPostBarCode) { }
            column(DeptNum; txtDeptNum) { }
            column(DeptName; txtDeptName) { }
            column(DistNum; txtDistNum) { }
            column(DistName; txtDistName) { }
            column(FinalDestination; txtFinalDestStr) { }
            column(FDBarcode; txtFinalDestBarcode) { }
            column(ReiEventCode; txtReiEventCode) { }
            column(FromLbl; lblFromTok) { }
            column(ToLbl; lblToTok) { }
            column(CarrierLbl; lblCarrierTok) { }
            column(StoreLbl; lblStoreTok) { }
            column(PalletLbl; lblPalletTok) { }
            column(CartonLbl; lblCartonTok) { }
            column(SSCCLbl; lblSSCCTok) { }
            column(BOLLbl; lblBolTok) { }
            column(ExtTrackLbl; lblExtTrackTok) { }
            column(POLbl; lblPOTok) { }
            column(ShipToPostLbl; lblShipToPostTok) { }
            column(PROLbl; lblPROTok) { }
            column(FORLbl; lblFORTok) { }
            column(DistNoLbl; lblDistNoTok) { }
            column(DistNameLbl; lblDistNameTok) { }
            column(DeptNoLbl; lblDeptNoTok) { }
            column(DeptNameLbl; lblDeptNameTok) { }
            column(UPCLbl; lblUPCTok) { }

            dataitem(location; Location)
            {
                DataItemLink = Code = field("Location Code");

                column(LocationCode; location.Code) { }
                column(LocationName; location.Name) { }
                column(LocationAddress; location.Address) { }
                column(LocationAddress2; location."Address 2") { }
                column(LocationCity; location.City) { }
                column(LocationPhone; location."Phone No.") { }
                column(LocationContact; location.Contact) { }
                column(LocationPostCode; location."Post Code") { }
                column(LocationCountry; location."Country/Region Code") { }
                column(LocationCounty; location.County) { }

                dataitem(lpHeader; "IWX LP Header")
                {
                    column(LicensePlateNo; lpHeader."No.") { }
                    column(LicensePlateDescription; lpHeader.Description) { }
                    column(LicensePlateInsurance; lpHeader."Insurance Amount") { }
                    column(ShipmentLength; lpHeader."Shipment Length") { }
                    column(ShipmentWidth; lpHeader."Shipment Width") { }
                    column(ShipmentHeight; lpHeader."Shipment Height") { }
                    column(ShipmentWeight; lpHeader."Shipment Gross Weight") { }
                    column(WeightUOM; lpHeader."Weight Unit of Measure") { }
                    column(DimensionUOM; lpHeader."Shpt. Dim. Unit of Measure") { }
                    column(ReiVendCaseMark; txtReiVendorCaseMark) { }
                    column(BOLNo; codBOLNum) { }
                    column(Pallet; iPallet) { }
                    column(SSCCBarCode; txtSSCCBarCode) { }

                    // line/item fields
                    column(ItemNum; iItemCount) { }
                    column(ItemDesc; txtItemDesc) { }
                    column(SKUQtyNum; '1') { } //lpLine."Qty. per Unit of Measure") { }
                    column(ItemStyle; txtItemStyle) { }
                    column(ItemSize; txtItemSize) { }
                    column(ItemColour; txtItemColour) { }
                    column(CaseQty; txtTotalCaseQty) { }
                    column(Carton; iCarton) { }
                    column(ItemUPC; codItemUPC) { }
                    column(ReiSKU; codReiSKU) { }
                    // end line/item fields

                    trigger OnPreDataItem()
                    begin
                        if (optSourceDocument = optSourceDocument::Shipment) then begin
                            lpHeader.SetRange("Source Document", lpHeader."Source Document"::Shipment);
                            lpHeader.SetRange("Source No.", codSourceNo);
                        end else begin
                            if (optSourceDocument = optSourceDocument::"Sales Order") then begin
                                lpHeader.SetRange("Source Document", lpHeader."Source Document"::"Sales Order");
                                lpHeader.SetRange("Source No.", codSourceNo);
                            end;
                        end;
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        SetPackageDetails();
                    end;
                }
            }

            trigger OnPreDataItem()
            var
                lrecWarehouseShipmentLine: Record "Warehouse Shipment Line";
            begin
                optSourceDocument := LPHeaderINIT."Source Document";
                codSourceNo := LPHeaderINIT."Source No.";

                if optSourceDocument = optSourceDocument::" " then begin
                    Dialog.Message('No useable data Found.');
                    CurrReport.Break();
                end;

                case optSourceDocument of
                    optSourceDocument::"Sales Order":
                        begin
                            recSalesHeader.Reset();
                            if recSalesHeader.Get(recSalesHeader."Document Type"::Order, LPHeaderINIT."Source No.") then
                                recSalesHeader.SetRecFilter()
                            else begin
                                Dialog.Message(lblNoSalesTok);
                                CurrReport.Break();
                            end;
                        end;
                    optSourceDocument::Shipment:
                        begin
                            lrecWarehouseShipmentLine.SetRange("No.", codSourceNo);
                            if (lrecWarehouseShipmentLine.FindFirst()) then begin
                                if (lrecWarehouseShipmentLine."Source Document" = lrecWarehouseShipmentLine."Source Document"::"Sales Order") then begin
                                    if recSalesHeader.Get(recSalesHeader."Document Type"::Order, lrecWarehouseShipmentLine."Source No.") then
                                        recSalesHeader.SetRecFilter()
                                    else begin
                                        Dialog.Message(lblNoSalesTok);
                                        CurrReport.Break();
                                    end;
                                end else
                                    if (lrecWarehouseShipmentLine."Source Document" = lrecWarehouseShipmentLine."Source Document"::"Outbound Transfer") then begin
                                        Dialog.Message(lblNoTransferTok);
                                        CurrReport.Break();
                                    end;
                            end;
                        end;
                    optSourceDocument::"Outbound Transfer":
                        begin
                            Dialog.Message(lblNoTransferTok);
                            CurrReport.Break();
                        end;
                end;
            end;

            trigger OnAfterGetRecord()
            var
                lrecShipmentHeader: Record "Warehouse Shipment Header";
            begin
                if (optSourceDocument = optSourceDocument::Shipment) then begin
                    if (lrecShipmentHeader.Get(codSourceNo)) then begin
                        txtCarrierName := GetShippingAgent(lrecShipmentHeader."Shipping Agent Code");
                        txtCarrierService := lrecShipmentHeader."Shipping Agent Service Code";
                    end;
                end else
                    if (optSourceDocument = optSourceDocument::"Sales Order") then begin
                        txtCarrierName := GetShippingAgent(recSalesHeader."Shipping Agent Code");
                        txtCarrierService := recSalesHeader."Shipping Agent Service Code";
                    end;

                SetDocumentDetails();
            end;
        }
    }
    rendering
    {
        layout(IWSampleUCC128)
        {
            Caption = 'Sample UCC128 Label';
            LayoutFile = './SRC/RDL/UCC128Label.rdl';
            Summary = 'A simple sample UCC128 label.';
            Type = RDLC;
        }
    }

    /// <summary>
    /// SetDocumentDetails.
    /// Use this function to set the values that show on the label for document and partner information
    /// </summary>
    local procedure SetDocumentDetails()
    var
        lrecLPHeader: Record "IWX LP Header";
        ltxtTempFDStoreNum: Text;
    begin
        //set label variables
        txtShipToPost := '(999)' + recSalesHeader."Ship-to Post Code";
        txtShipToPostBarCode := CreateBarcode(txtShipToPost);

        // set the PRO number
        lrecLPHeader.SetRange("Source No.", codSourceNo);
        lrecLPHeader.SetRange("Source Document", optSourceDocument);
        if lrecLPHeader.FindFirst() then
            codPRONum := lrecLPHeader."No."; //the first lp number that exists

        // set Purchase Order No.
        txtPurchOrderNum := recSalesHeader."External Document No.";

        txtReiEventCode := 'UNKNOWN';

        // set store number/name
        txtDeptNum := recSalesHeader."Ship-to Code";
        txtDeptName := recSalesHeader."Ship-to Code";
        txtDistNum := '1';
        txtPartnerIDStr := '77';
        ltxtTempFDStoreNum := txtDistNum.PadLeft(5, '0');
        txtFinalDestStr := StrSubstNo('(%1)%2', txtPartnerIDStr, ltxtTempFDStoreNum);
        txtFinalDestBarcode := CreateBarcode(StrSubstNo('%1%2', txtPartnerIDStr, ltxtTempFDStoreNum));
    end;

    /// <summary>
    /// SetPackageDetails.
    /// Use this function to set the values that show on the label for the specific package, including SSCC
    /// This function assumes the SSCC already exists on the License Plate Header. If the SSCC does not already exist,
    /// see this article for how to generate the SSCC: https://kb.dmsiworks.com/knowledge-base/generate-serial-shipping-container-code/
    /// </summary>
    local procedure SetPackageDetails()
    begin
        codBOLNum := lpHeader."Source No.";
        codSSCCNum := lpHeader.SSCC;
        txtSSCCBarCode := CreateBarcode(codSSCCNum);

        if StrLen(codSSCCNum) > 19 then begin
            codSSCCNum := '(' + CopyStr(codSSCCNum, 1, 2) + ')' + CopyStr(codSSCCNum, 3, 1) + CopyStr(codSSCCNum, 4, 7) + CopyStr(codSSCCNum, 11, 9) + CopyStr(codSSCCNum, 20, 1);
        end;

        txtReiVendorCaseMark := 'Unknown';
        iCarton += 1;

        SetItemDetails();
    end;

    /// <summary>
    /// SetItemDetails.
    /// Use this function to set the values that show on the label for items and attributes
    /// </summary>
    local procedure SetItemDetails()
    var
        lrecItem: Record Item;
        lrecLPLine: Record "IWX LP Line";
        lcodGTIN: Code[50];
        llblMixedTok: Label 'Mixed';
    begin
        iItemCount := 0;
        txtItemStyle := '';
        txtItemColour := '';
        txtItemSize := '';

        lrecLPLine.SetRange("License Plate No.", lpHeader."No.");
        lrecLPLine.SetRange(Type, lrecLPLine.Type::Item);

        if lrecLPLine.FindSet() then begin
            repeat
                iItemCount += 1;
                if lrecItem.Get(lrecLPLine."No.") then
                    lcodGTIN := lrecItem.GTIN;
                if lcodGTIN = '' then
                    lcodGTIN := lrecItem."No.";

                if codItemUPC <> lcodGTIN then begin
                    codItemUPC := lcodGTIN;

                    lrecLPLine.CalcFields(Description);
                    txtItemDesc := lrecLPLine.Description;
                    txtTotalCaseQty := Format(lrecLPLine.Quantity);

                    if iItemCount > 1 then begin
                        txtItemStyle := llblMixedTok;
                        txtItemColour := llblMixedTok;
                        txtItemSize := llblMixedTok;
                        codItemUPC := llblMixedTok;
                        txtItemDesc := llblMixedTok;
                        txtTotalCaseQty := llblMixedTok;
                    end;
                end;
            until lrecLPLine.Next() = 0;
        end;
    end;

    /// <summary>
    /// CreateBarcode: creates barcode data for use with IDAutomation fonts
    ///
    /// Alternatively, use Barcode Generator for additional fonts/formats
    /// See this article for more information on generating barcodes: https://kb.dmsiworks.com/knowledge-base/advanced-barcode-generation/
    /// </summary>
    /// <param name="ptxtBarcode">Text of the barcode to produce</param>
    /// <returns>BarcodeOutput: barcode data to use with IDAutomation fonts</returns>
    local procedure CreateBarcode(ptxtBarcode: Text) BarcodeOutput: Text
    var
        lifBarcodeFontProvider: Interface "Barcode Font Provider";
        leBarcodeSymbology: Enum "Barcode Symbology";
    begin
        lifBarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
        leBarcodeSymbology := Enum::"Barcode Symbology"::Code128;

        lifBarcodeFontProvider.ValidateInput(ptxtBarcode, leBarcodeSymbology);
        BarcodeOutput := lifBarcodeFontProvider.EncodeFont(ptxtBarcode, leBarcodeSymbology);
    end;

    local procedure GetShippingAgent(pcodShippingAgent: Code[20]): Text
    var
        lrecShippingAgent: Record "Shipping Agent";
    begin
        if (lrecShippingAgent.Get(pcodShippingAgent)) then begin
            exit(lrecShippingAgent.Name);
        end;
    end;

    var
        txtDeptName: Text;
        txtDeptNum: Text;
        txtDistName: Text;
        txtDistNum: Text;
        txtPartnerIDStr: Text;
        txtFinalDestBarcode: Text;
        txtFinalDestStr: Text;
        txtItemColour: Text;
        txtItemDesc: Text;
        txtItemSize: Text;
        txtItemStyle: Text;
        txtPurchOrderNum: Text;
        txtReiEventCode: Text;
        txtReiVendorCaseMark: Text;
        txtTotalCaseQty: Text;
        txtCarrierName: Text;
        txtCarrierService: Text;
        txtShipToPost: Text;
        txtShipToPostBarCode: Text;
        txtSSCCBarCode: Text;
        codReiSKU: Code[10];
        codSourceNo: Code[20];
        codBOLNum: Code[50];
        codItemUPC: Code[50];
        codPRONum: Code[50];
        codSSCCNum: Code[50];
        optSourceDocument: Option " ","Purchase Order","Sales Order","Inbound Transfer","Outbound Transfer","Prod. Order","Put-away",Pick,Movement,"Invt. Put-away","Invt. Pick",Receipt,Shipment,Reclass,"Purchase Return Order","Assembly","Invt. Movement","Misc. Shipment";
        iCarton: Integer;
        iPallet: Integer;
        iItemCount: Integer;
        lblBolTok: Label 'BOL:';
        lblCarrierTok: Label 'CARRIER';
        lblCartonTok: Label 'No. of Cartons';
        lblDeptNameTok: Label 'Dept Name:';
        lblDeptNoTok: Label 'Dept#';
        lblDistNameTok: Label 'Store Name';
        lblDistNoTok: Label 'Store Number';
        lblExtTrackTok: Label 'Package Tracking #';
        lblFORTok: Label 'FOR';
        lblFromTok: Label 'FROM';
        lblPalletTok: Label 'PALLET NO.';
        lblPOTok: Label 'PO:';
        lblPROTok: Label 'PRO:';
        lblShipToPostTok: Label 'SHIP TO POSTAL CODE';
        lblSSCCTok: Label 'SERIAL SHIPPING CONTAINER';
        lblStoreTok: Label 'STORE #';
        lblToTok: Label 'TO';
        lblUPCTok: Label 'UPC:';
        lblNoTransferTok: Label 'This report does not work with Transfers.';
        lblNoSalesTok: Label 'No Sales Header Found.';
}
