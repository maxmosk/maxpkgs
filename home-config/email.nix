{
  programs.neomutt = {
    enable = true;
  };
  accounts.email.accounts =
    let
      realName = "Maxim Moskalets";
      neomutt = {
        enable = true;
        mailboxType = "imap";
      };

      mkCreds = id: "cat ~/.creds/${id}";
    in
    {
      "maximmosk4@gmail.com" = {
        address = "maximmosk4@gmail.com";
        userName = "maximmosk4@gmail.com";
        flavor = "gmail.com";
        passwordCommand = mkCreds "maximmosk4-gmail";
        inherit realName neomutt;

        primary = true;
      };
      "maxmoskm@yandex.ru" = {
        address = "maxmoskm@yandex.ru";
        userName = "maxmoskm@yandex.ru";
        flavor = "yandex.com";
        passwordCommand = mkCreds "maxmoskm-yandex";
        inherit realName neomutt;
      };
      "maxmosk@list.ru" = {
        address = "maxmosk@list.ru";
        userName = "maxmosk@list.ru";
        passwordCommand = mkCreds "maxmosk-list";
        inherit realName neomutt;

        imap = {
          host = "imap.mail.ru";
          port = 993;
          tls.enable = true;
        };
        smtp = {
          host = "smtp.mail.ru";
          port = 465;
          tls.enable = true;
        };
      };
      "moskalets@landau.one" = {
        address = "moskalets@landau.one";
        userName = "moskalets@landau.one";
        passwordCommand = mkCreds "moskalets-landau";
        inherit realName neomutt;

        imap = {
          host = "mail.rulkc.org";
          port = 993;
          tls.enable = true;
        };
        smtp = {
          host = "mail.rulkc.org";
          port = 465;
          tls.enable = true;
        };
      };
    };
}
