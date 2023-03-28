// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;
import "./../libraries/UserIdentityNFT.sol";

interface IUserIdentityNFT {
    //Events

    event MintNft(address userAddres, uint256 indexed tokenId);
    event Redeem(address userAddres);

    function createSingleNFT(UserIdVoucher calldata voucher) external;

    function redeem(UserIdVoucher[] calldata voucher) external;
}
