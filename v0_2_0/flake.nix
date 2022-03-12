{
  description = ''A super-fast epoll-backed and parallel HTTP server.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-httpx-v0_2_0.flake = false;
  inputs.src-httpx-v0_2_0.owner = "xflywind";
  inputs.src-httpx-v0_2_0.ref   = "refs/tags/v0.2.0";
  inputs.src-httpx-v0_2_0.repo  = "httpx";
  inputs.src-httpx-v0_2_0.type  = "github";
  
  inputs."ioselectors".dir   = "nimpkgs/i/ioselectors";
  inputs."ioselectors".owner = "riinr";
  inputs."ioselectors".ref   = "flake-pinning";
  inputs."ioselectors".repo  = "flake-nimble";
  inputs."ioselectors".type  = "github";
  inputs."ioselectors".inputs.nixpkgs.follows = "nixpkgs";
  inputs."ioselectors".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-httpx-v0_2_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-httpx-v0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}