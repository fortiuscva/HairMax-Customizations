namespace HairMaxCustomizations.HairMaxCustomizations;

codeunit 52603 "HMX HairMax Single Instance"
{
    SingleInstance = true;
    procedure SetHideDeleteSOReservationConfirm(SuppressVar: Boolean)
    begin
        HideDeleteSOReservationConfirm := SuppressVar;
    end;

    procedure GetHideDeleteSOReservationConfirm(): Boolean
    begin
        exit(HideDeleteSOReservationConfirm);
    end;

    Var
        HideDeleteSOReservationConfirm: Boolean;
}
