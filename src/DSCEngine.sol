// SPDX-License-Identifier: MIT

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations // Mapping // Structs // Enums
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal // private
// internal & private view & pure functions
// external & public view & pure functions

pragma solidity ^0.8.18;


/**
 * @title DSCEngine
 * @author HansP
 *
 * The system is designed to be minimal as possible, and the tokens maintain a 1 token == 1$ peg.
 * This stablecoin has the properties:
 * - Exogenous Collateral
 * - Dollar Pegged
 * - Algorithmic Stability
 *
 * It is similar to DAI if DAI had no governance, no fees, and was only backed by WETH and WBTC.
 * 
 * Our DSC system should always be over-collateralized. At no point, should the value of all collateral <= the $ backed value of all the DSC.
 *
 * @notice This contract is the core of the Decentralized Stablecoin protocol. It handles all the logic for mining and redeeming DSC, as well as depending & withdrawing collateral. 
 * @notice This is contract is VERY loosely based on the MakerDAO DSS (DAI) system.
 * 
 */

contract DSCEngine {
    //////////////////////// 
    // Errors //
    ////////////////////////
    error DSCEngine__MustBeMoreThanZero();
    error DSCEngine__NotAllowedToken();
    error DSCEngine__TokenAddressesAndPriceFeedAddressesLengthsMustBeTheSame();
     //////////////////////// 
    // State Variables //
    ////////////////////////
    mapping(address token  => address priceFeed) private s_priceFeeds;
    //////////////////////// 
    // Modifiers //
    ////////////////////////
    modifier moreThanZero(uint256 amount) {
        if (amount <= 0) {
            revert DSCEngine__MustBeMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address tokenCollateralAddress) {
        if (tokenCollateralAddress != ) {
            revert DSCEngine__NotAllowedToken();
        }
        _;
    }

    //////////////////////// 
    // Functions //
    ////////////////////////
    constructor(address[] memory tokenAddresses, address[] memory priceFeedAddresses, address dscAddress ){
        // USD Price Feeds
        if(tokenAddresses.length != priceFeedAddresses.length) {
            revert DSCEngine__TokenAddressesAndPriceFeedAddressesLengthsMustBeTheSame();
        }
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }

    }

    //////////////////////// 
    // External Functions //
    ////////////////////////
    function depositCollateralAndMintDSC() external {}

    /*
    * @param tokenCollateralAddress the address of the token deposit as collateral
    * @param amountCollateral the amount of collateral to deposit   
    * 
    */

    function depositCollateral(address tokenCollateralAddress, uint256 amountCollateral) external moreThanZero(amountCollateral) isAllowedToken(tokenCollateralAddress) {}

    function redeemCollateralForDSC() external {}    

    function redeemCollateral() external {}

    function mintDSC() external {}

    function burnDsc() external {}

    function liquidate() external {}

    function getHealthFactor() external view {}
}

