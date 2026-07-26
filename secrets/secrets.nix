let
  myKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6WNm4YAQO85j0aNQkKSH7QnmhgzKA4hA2ggi6cDyKk tomasr@nixos";
in
{
  "my-secret.age".publicKeys = [
    myKey
  ];
}
