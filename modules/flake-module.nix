{ ... }: {
  phenix.overlays = [(final: prev: {
    phenix = (prev.phenix or {}) // {
      hello-pins = final.writeShellScriptBin "hello-pins" ''
        echo "hello from pins"
      '';
    };
  })];
}
