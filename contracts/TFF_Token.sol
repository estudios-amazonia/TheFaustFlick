pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/token/ERC721/ERC721MetadataMintable.sol";
import "zos-lib/contracts/Initializable.sol";

/**
 * @title TFF_Token http://estudios-amazonia.com/TheFaustFlick_WP.pdf
 * @dev ERC721 minting logic with metadata, leveraging ZeppelinOS EVM
 * @dev ERC721 facilitates preventing: a) double-voting per token and
 * b) disabling trading during voting periods.
 */

contract TFF_Token is Initializable, ERC721MetadataMintable {

  address private Owner;
  string private Name;
  string private Symbol;
  string private TokenURI;
  uint256 private TokenId;
  uint8[4] private MintStage;
  uint256[4] private TokensToMint;

  function initialize(address sender) public initializer {
    Owner = sender;
    Symbol = "TFF";
    Name = "TFF_Token";
    ERC721.initialize();
    ERC721Metadata.initialize(Name, Symbol);
    ERC721MetadataMintable.initialize(Owner);
    TokenId = 1;
    TokenURI = "http://thefaustflick.com/images/TFF_Token.png";
    for (uint8 counter = 0; counter <= 3; counter++) { MintStage[counter] = 0; }
    TokensToMint[0] = 500000;
    TokensToMint[1] = 3000000;
    TokensToMint[2] = 3000000;
    TokensToMint[3] = 3500000;
    Mint_TFF(0);
  }

  /**
   * @dev TFF Minter function * Warning * Review White Paper and get last
   * TokenId to figure out next logically correct Mint_TFF(_Stage) value
   */
  function Mint_TFF(uint8 _Stage) public onlyMinter returns (bool) {
    if (MintStage[_Stage] == 0) {
      uint256 tokensToMint = TokensToMint[_Stage];
      for (uint256 counter = 1; counter <= tokensToMint; counter++) {
        mintWithTokenURI(Owner, TokenId, TokenURI);
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
