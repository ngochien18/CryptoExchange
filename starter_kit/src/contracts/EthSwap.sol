pragma solidity ^0.5.0;
// contract cho blockchain EthSwap

import "./Token.sol";

contract EthSwap {
   string public name= "EthSwap Exchange";
   Token public token; 
   uint public rate = 100;

   event TokenPurchased(
      address account,
      address token,
      uint amount,
      uint rate
   );

   constructor(Token _token) public {
      token = _token;
   }

   function buyTokens() public payable{
      // Redemption rate = so token moi ether doi duoc
      //Amount of Ether * Redemption rate

      uint tokenAmount = msg.value * rate;

      require(token.balanceOf(address(this))>=tokenAmount); //check so coin mua khong vuot qua so coin san co

      token.transfer(msg.sender,tokenAmount); // chuyen token nguoi mua

      //Emit an event
      emit TokenPurchased(msg.sender,address(token),tokenAmount,rate);
   }   
}

