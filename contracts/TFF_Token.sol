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

contract TFF_Token is ERC721Full, ERC721MetadataMintable, Ownable {

  address private Owner = 0x36Fe25e27F640a8635Ba8f0F10F3eadFDf5bC04a;
  string private Name = "TFF_Token";
  string private Symbol = "TFF";
  string private TokenURI = "http://thefaustflick.com/images/TFF_Token.png";
  uint256 private TokenId;
  uint8[4] private MintStage;
  uint256[4] private TokensToMint;

  // Constructor
  constructor() ERC721Full(Name, Symbol) public {
    TokenId = 1;
    for (uint8 counter = 0; counter <= 3; counter++) { MintStage[counter] = 0; }
    TokensToMint[0] = 500000;
    TokensToMint[1] = 3000000;
    TokensToMint[2] = 3000000;
    TokensToMint[3] = 3500000;
    Mint_TFF(0);
  }

  /**
   * @dev TFF Minter function * Warning * Review White Paper * Get last
   * TokenId to figure out next logically correct Mint_TFF(_Stage) value
   */
  function Mint_TFF(uint8 _Stage) public onlyOwner returns (bool) {
    if (MintStage[_Stage] == 0) {
      uint256 tokensToMint = TokensToMint[_Stage];
      for (uint256 counter = 1; counter <= tokensToMint; counter++) {
        mintWithTokenURI(Owner, TokenId, string memory TokenURI)
        TokenId = TokenId.add(1);
      }
      MintStage[_Stage] = 1;
      return true;
    }
  }

  /**
   * @dev Gets Last TokenId function * Useful to determine how many TFF Tokens
   * have been minted. Helps figure the next logically correct Mint_TFF() Value
   */
  function GetLastTokenId() public view returns (uint256) {
      return TokenId;
  }

  function GetTokenURI() public view returns (string memory) {
      return TokenURI;
  }
}
