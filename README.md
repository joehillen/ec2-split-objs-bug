This repo is a reproduction case for a bug in ghc-8.0.1 that manifests when 
building amazonka-ec2-1.4.3 with `split-objs`.

The bug can appear as the following error message:
```
[189 of 207] Compiling Network.AWS.EC2.Waiters ( gen/Network/AWS/EC2/Waiters.hs, .stack-work/dist/x86_64-linux/Cabal-1.24.0.0/build/Network/AWS/EC2/Waiters.o )
[190 of 207] Compiling Network.AWS.EC2.DeleteVPNConnection ( gen/Network/AWS/EC2/DeleteVPNConnection.hs, .stack-work/dist/x86_64-linux/Cabal-1.24.0.0/build/Network/AWS/EC2/DeleteVPNConnection.o )
ghc: panic! (the 'impossible' happened)
  (GHC version 8.0.1 for x86_64-unknown-linux):
	tyThingTyCon Identifier ‘$fFoldableFirst_$cfold’

Please report this as a GHC bug:  http://www.haskell.org/ghc/reportabug
```

This repo produces the following error message:

```
[189 of 207] Compiling Network.AWS.EC2.Waiters ( gen/Network/AWS/EC2/Waiters.hs, .stack-work/dist/x86_64-linux/Cabal-1.24.0.0/build/Network/AWS/EC2/Waiters.o )
[190 of 207] Compiling Network.AWS.EC2.DeleteVPNConnection ( gen/Network/AWS/EC2/DeleteVPNConnection.hs, .stack-work/dist/x86_64-linux/Cabal-1.24.0.0/build/Network/AWS/EC2/DeleteVPNConnection.o )

/tmp/stack11/amazonka-ec2-1.4.3/gen/Network/AWS/EC2/DeleteVPNConnection.hs:51:25: error:
    • Couldn't match expected type ‘Either a0 a10’
                  with actual type ‘a1 -> ShowS’
    • Probable cause: ‘showsPrec’ is applied to too few arguments
      In the first argument of ‘GHC.Show.showList__’, namely
        ‘(showsPrec 0)’
      In the expression: GHC.Show.showList__ (showsPrec 0)
      In an equation for ‘showList’:
          showList = GHC.Show.showList__ (showsPrec 0)
      When typechecking the code for ‘showList’
        in a derived instance for ‘Show DeleteVPNConnection’:
        To see the code I am typechecking, use -ddump-deriv

/tmp/stack11/amazonka-ec2-1.4.3/gen/Network/AWS/EC2/DeleteVPNConnection.hs:104:23: error:
    • Couldn't match expected type ‘Either a2 a3’
                  with actual type ‘a4 -> ShowS’
    • Probable cause: ‘showsPrec’ is applied to too few arguments
      In the first argument of ‘GHC.Show.showList__’, namely
        ‘(showsPrec 0)’
      In the expression: GHC.Show.showList__ (showsPrec 0)
      In an equation for ‘showList’:
          showList = GHC.Show.showList__ (showsPrec 0)
      When typechecking the code for ‘showList’
        in a derived instance for ‘Show DeleteVPNConnectionResponse’:
        To see the code I am typechecking, use -ddump-deriv
```

To reproduce this error in this repo, Docker is required and just run `make`.

Check the `stack.yaml` for the related ghc build options.
