pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721MetadataMintable.sol';
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';

/**
 * @title TFF_Token http://estudios-amazonia.com/TheFaustFlick_WP.pdf
 * @dev ERC721 metadata minting logic leveraging openzeppelin-solidity v2.1.2
 * @dev ERC721 facilitates preventing: a) double-voting per token and
 * b) disabling trading during voting periods.
 */

contract TFF_Token is ERC721Full, ERC721Mintable, Ownable {
  string private Name = "#TheFaustFlick";
  string private Symbol = "TFF";
  address private Owner;
  string private TokenURI;
  uint256 private Stage;
  uint256 private TokenId;
  uint256[4] private TokensToMint;

  // Constructor
  constructor() ERC721Full(Name, Symbol) public {
    // Kovan Address
    Owner = 0xBB4c5B7da9EBcce738da626B43942b9aA4998Dd0;
    TokenURI = "http://thefaustflick.com/images/TFF_Token.png";
    Stage = 0;
    TokenId = 1;
    TokensToMint[0] = 500000;
    TokensToMint[1] = 3000000;
    TokensToMint[2] = 3000000;
    TokensToMint[3] = 3500000;
  }

  function Mint_TFF() public onlyOwner returns (bool) {
    require (Stage <=3);
    uint256 tokensToMint = TokensToMint[Stage];
    for (uint256 counter = 1; counter <= tokensToMint; counter++) {
      mintWithTokenURI(Owner, TokenId, TokenURI);
      TokenId = TokenId.add(1);
    }
    Stage = Stage.add(1);
    return true;
  }

  function GetLastTokenId() public view returns (uint256) {
    return TokenId;
  }

  function GetTokenURI() public view returns (string memory) {
    return TokenURI;
  }
}
