codeunit 5378 "VSCode Request Helper"
{
    trigger OnRun()
    begin
    end;

    [Scope('OnPrem')]
    procedure GetUrlToNavigatePageInVSCode(PageId: Integer; PageName: Text): Text
    var
        UriBuilder: Codeunit "Uri Builder";
        Uri: Codeunit Uri;
    begin
        UriBuilder.Init('vscode://ms-dynamics-smb.al/navigateTo');

        UriBuilder.AddQueryParameter('type', 'page');
        UriBuilder.AddQueryParameter('id', Format(PageId));
        UriBuilder.AddQueryParameter('name', PageName);
        UriBuilder.AddQueryParameter('appid', GetAppIdForPage(PageId));

        UriBuilder.GetUri(Uri);
        exit(Uri.GetAbsoluteUri());
    end;

    [Scope('OnPrem')]
    local procedure GetAppIdForPage(PageId: Integer): Text
    var
        AllObjWithCaption: Record AllObjWithCaption;
        NavAppInstalledApp: Record "NAV App Installed App";
    begin
        if AllObjWithCaption.ReadPermission() then begin
            AllObjWithCaption.Reset();
            AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Page);
            AllObjWithCaption.SetRange("Object ID", PageId);

            if AllObjWithCaption.FindFirst() then begin
                NavAppInstalledApp.Reset();
                NavAppInstalledApp.SetRange("Package ID", AllObjWithCaption."App Runtime Package ID");
                if NavAppInstalledApp.FindFirst() then
                    exit(NavAppInstalledApp."App ID");
            end;
        end;
    end;
}