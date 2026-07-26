let
  backupAgeKey = "age1y4lhpk7awhjyu42p46ulg5q2c49r2lnwu8tyyk4ejj6jztd64uksfhd670";
  laptopHostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJCsewl8ZXXMjRyO20cBIiuW2gA4mGoMkxQ0dcMyNidR root@nixos";
in
{
  "ntfy.age".publicKeys = [
    backupAgeKey
    laptopHostKey
  ];
}
