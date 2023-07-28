pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    constructor(
        uint256 rate,    // rate in TKNbits
        address payable wallet, // sale beneficiary
        IERC20 token     // the Token itself
    ) public Crowdsale(rate, wallet, token) {
        // constructor can stay empty
    }
}

contract KaseiCoinCrowdsaleDeployer {

    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet  // this address will receive all Ether raised by the sale
    ) public {
        // create a new instance of the KaseiCoin contract
        KaseiCoin token = new KaseiCoin(name, symbol);
        kasei_token_address = address(token);

        // create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        kasei_crowdsale_address = address(kasei_crowdsale);

        // set the `KaseiCoinCrowdsale` contract as a minter
        token.addMinter(kasei_crowdsale_address);

        // have the `KaseiCoinCrowdsaleDeployer` renounce its minter role
        token.renounceMinter();
    }
}

*/