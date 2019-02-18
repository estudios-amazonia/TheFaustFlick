pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-eth/contracts/ownership/Ownable.sol";

/**
 * @title ABC_Token
 * @dev ERC20 minting logic, leveraging secured and upgradeable ZeppelinOS EVM
 * @dev It also includes functions from ERC20Detailed
 */

contract ABC_Token is ERC20Mintable, Ownable {

    address private Owner = 0x8D0B109B01Dc44A249D7Fdf702f05eee5A1815d5;
    string private name = "ABC_Token";
    string private symbol = "ABC";
    uint8 private decimals = 3;
    uint8 private Mint[4];
    uint256 private Stage[4];
    Stage[0] = 500000000;
    Stage[1] = 3000000000;
    Stage[2] = 3000000000;
    Stage[3] = 3500000000;

    InitializeOwner(Owner);

    function InitializeOwner(Owner) public initializer {
      initialize(Owner);
      mint(Owner, Stage.0);
      Mint[0] = 1;
    }

    function Mint_ABC(uint8 _Stage) public {
      if (_Stage == 0){
        throw;
      }
      else{
        if (Mint._Stage != 1){
          mint(Owner, Stage._Stage);
          Mint[_Stage] = 1;
        }
        else{
          throw;
        }
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
