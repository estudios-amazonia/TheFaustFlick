pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-eth/contracts/ownership/Ownable.sol";

/**
 * @title ABC_Token
 * @dev ERC20 minting logic, leveraging secured ZeppelinOS EVM
 * @dev It also includes functions from ERC20Detailed
 */

contract ABC_Token is ERC20Mintable, Ownable {

  address private Owner = 0x8D0B109B01Dc44A249D7Fdf702f05eee5A1815d5;
  string private name;
  string private symbol;
  uint8 private decimals;
  uint8 private Mint[4];
  uint256 private ABC_Token[4];

  Initialize(Owner);

  function Initialize(address Owner) public initializer {
    name = "ABC_Token";
    symbol = "ABC";
    decimals = 3;
    MinterRole.initialize(Owner);
    Ownable.initialize(Owner);
    Mint[0] = 0;
    TFF_Token[0] = 500000000;
    TFF_Token[1] = 3000000000;
    TFF_Token[2] = 3000000000;
    TFF_Token[3] = 3500000000;
    Mint_ABC(0);
  }

  function Mint_ABC(uint8 _Stage) public onlyMinter returns (bool) {
    if (Mint._Stage == 0 || Mint._Stage != 1 && Mint._Stage.sub(1) == 1) {
      mint(Owner, TFF_Token._Stage);
      Mint[_Stage] = 1;
      return true;
    }
    else {
      throw;
    }
  }

  function name() public view returns (string memory) {
    return name;
  }

  function symbol() public view returns (string memory) {
    return symbol;
  }

  function decimals() public view returns (uint8) {
    return decimals;
  }

  uint256[50] private ______gap;

}
