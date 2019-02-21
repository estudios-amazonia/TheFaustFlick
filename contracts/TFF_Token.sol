pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/token/ERC721/ERC721Metadata.sol";
import "openzeppelin-eth/contracts/access/roles/MinterRole.sol";
import "openzeppelin-eth/contracts/ownership/Ownable.sol";
import "zos-lib/contracts/Initializable.sol";

/**
 * @title TFF_Token
 * @dev ERC721 minting logic with metadata, leveraging ZeppelinOS EVM
 * @dev ERC721 facilitates preventing: a) double-voting per token and
 * b) disabling trading during voting periods.
 */

contract TFF_Token is Initializable, ERC721, ERC721Metadata, MinterRole, Ownable {

  string private Name;
  string private Symbol;
  string private TokenURI;
  uint256 private TokenId;
  uint8[4] private MintStage;
  uint256[4] private TokensToMint;

  function initialize(address Owner) public initializer {
    require(ERC721._hasBeenInitialized());
    require(ERC721Metadata._hasBeenInitialized());
    Name = "TFF_Token";
    Symbol = "TFF";
    ERC721.initialize();
    ERC721Metadata.initialize(Name, Symbol);
    MinterRole.initialize(Owner);
    Ownable.initialize(Owner);
    TokenURI = "http://thefaustflick.com/images/TFF_Token.png";
    TokenId = 1;
    MintStage[0] = 0;
    TokensToMint[0] = 500000;
    TokensToMint[1] = 3000000;
    TokensToMint[2] = 3000000;
    TokensToMint[3] = 3500000;
    Mint_TFF(0);
  }

  function Mint_TFF(uint8 _Stage) public onlyMinter returns (bool) {
    if (MintStage[_Stage] == 0 || MintStage[_Stage] != 1 && MintStage[_Stage.sub(1)] == 1) {
      for (uint256 counter = 1; counter <= TokensToMint[_Stage]; counter++) {
        _mint(Owner, TokenId);
        _setTokenURI(TokenId, TokenURI);
        TokenId = TokenId.add(1);
      }
      MintStage[_Stage] = 1;
      return true;
    }
    else {
      throw;
    }
  }

  function LastTokenId() public view returns (uint256) {
      return TokenId;
  }

  function GetTokenURI() public view returns (uint256) {
      return TokenURI;
  }

  uint256[50] private ______gap;
}
