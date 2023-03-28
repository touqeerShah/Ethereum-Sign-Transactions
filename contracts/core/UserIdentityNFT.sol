// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@openzeppelin/contracts/utils/Counters.sol";
import "./../interfaces/IUserIdentityNFT.sol";
import "./../libraries/UserIdentityNFT.sol";

contract UserIdentityNFT is ERC721URIStorage, ReentrancyGuard, EIP712, IUserIdentityNFT {
    using Counters for Counters.Counter;
    Counters.Counter private idCount;
    address private figureprintOracle;
    bytes32 public constant CLAME_USERID_VOUCHER =
        keccak256("createUserId(string uri,bytes userId,bytes fingerPrint)");

    // "NFTVoucher(uint256 tokenId,string uri,address currency,uint256 minPrice,bool isFixedPrice)"

    constructor(
        string memory name,
        string memory symbol,
        string memory signingDomain,
        string memory signatureVersion
    ) ERC721(name, symbol) EIP712(signingDomain, signatureVersion) {}

    // The functions below are overrides required by Solidity.
    function createSingleNFT(UserIdVoucher calldata voucher) public nonReentrant {
        address signer = verifySignature(voucher);
        idCount.increment();
        uint256 tokenId = idCount.current();
        _mint(signer, tokenId);
        _setTokenURI(tokenId, voucher.uri);
        emit MintNft(signer, tokenId);
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 firstTokenId,
        uint256 batchSize
    ) internal override(ERC721) {
        super._afterTokenTransfer(from, to, firstTokenId, batchSize);
    }

    /// @notice Redeems an NFTVoucher for an actual NFT, creating it in the process.

    function redeem(UserIdVoucher[] calldata voucher) public nonReentrant {
        for (uint32 i = 0; i < voucher.length; i++) {
            address signer = verifySignature(voucher[i]);
            idCount.increment();
            uint256 tokenId = idCount.current();
            _mint(msg.sender, tokenId);
            _setTokenURI(tokenId, voucher[i].uri);
            emit MintNft(signer, tokenId);
        }
        emit Redeem(msg.sender);
    }

    function _hash(UserIdVoucher calldata voucher) internal view returns (bytes32) {
        return
            _hashTypedDataV4(
                keccak256(
                    abi.encode(
                        CLAME_USERID_VOUCHER,
                        keccak256(bytes(voucher.uri)),
                        keccak256(voucher.userId),
                        keccak256(voucher.fingerPrint)
                    )
                )
            );
    }

    /// @notice Verifies the signature for a given NFTVoucher, returning the address of the signer.
    /// @dev Will revert if the signature is invalid. Does not verify that the signer is authorized to mint NFTs.
    /// @param voucher An NFTVoucher describing an unminted NFT.
    function verifySignature(UserIdVoucher calldata voucher) public view returns (address) {
        bytes32 digest = _hash(voucher);
        return ECDSA.recover(digest, voucher.signature);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function getIdCount() public view returns (uint256) {
        return idCount.current();
    }
}
