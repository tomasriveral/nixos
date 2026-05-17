{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    texlab
    ltex-ls-plus
    biber
    (pkgs.texliveMedium.withPackages (
      ps:
        with ps; [
          # these few pkgs are used in the CV template
          titlesec # allows creating custom \section
          marvosym # some symboles
          ebgaramond # Use the EB Garamond font
          microtype # To enable letterspacing
          fontaxes
          # these few pkgs were used for my TM
          svg
          catchfile
          caption
          transparent
          cfr-lm
          svn-prov
          nfssext-cfr
          hyphenat
          csquotes
          enumitem
          chngcntr
          tcolorbox
          pdfcol
          wrapfig
          tocloft
          lastpage
          biblatex
          biblatex-iso690
          libertine
          minted
          upquote
          lipsum
          footmisc
          #(setq org-latex-compiler "lualatex")
          #(setq org-preview-latex-default-process 'dvisvgm)
        ]
    ))
  ];
}
