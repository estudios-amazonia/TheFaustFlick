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

  address private Owner = 0x8D0B109B01Dc44A249D7Fdf702f05eee5A1815d5;
  string private Name;
  string private Symbol;
  string private TokenURI;
  uint256 private TokenId;
  uint8 private Mint[4];
  uint256 private TFF_Token[4];

  initialize(Owner);

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
    Mint[0] = 0;
    TFF_Token[0] = 500000;
    TFF_Token[1] = 3000000;
    TFF_Token[2] = 3000000;
    TFF_Token[3] = 3500000;
    Mint_TFF(0);
  }

  function Mint_TFF(uint8 _Stage) public onlyMinter returns (bool) {
    if (Mint._Stage == 0 || Mint._Stage != 1 && Mint._Stage.sub(1) == 1) {
      for (uint256 counter = 1; counter <= TFF_Token._Stage; counter.add(1)) {
        _mint(Owner, TokenId);
        _setTokenURI(TokenId, TokenURI);
        TokenId = TokenId.add(1);
      }
      Mint[_Stage] = 1;
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
