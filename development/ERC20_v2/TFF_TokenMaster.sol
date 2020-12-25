pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol';
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';

/**
 * @title TFF_Token > http://estudios-amazonia.com/TheFaustFlick_WP.pdf
 * @dev Leveraging openzeppelin-solidity v2.1.2 ERC20Pausable.sol
 * @dev ERC20Pausable allows disabling trading during voting periods,
 * @dev thus preventing double-voting per token.
 */

 contract TFF_Token is ERC20Pausable {

   using SafeERC20 for ERC20;
   address public creator;
   string public name;
   string public symbol;
   uint8 public decimals;
   uint256 public stage;
   uint256[4] private tokensToMint;

   constructor() public {

     creator = 0xbC57B9bb80DD02c882fcE8cf5700f8A2a003838E;
     name = "TheFaustFlick";
     symbol = "TFF";
     decimals = 3;
     stage = 0;
     tokensToMint[0] = 500000000;
     tokensToMint[1] = 3000000000;
     tokensToMint[2] = 3000000000;
     tokensToMint[3] = 3500000000;
   }

   function mintTFF() public onlyOwner returns (bool) {
     require (stage <=3);
     _mint(creator, tokensToMint[stage]);
     stage = stage.add(1);
     return true;
   }
 }
