pragma solidity ^0.5.0;
// contract cho blockchain EthSwap

import "./Token.sol";

contract EthSwap {
   string public name= "EthSwap Exchange";
   Token public token; 
   uint public rate = 100;

   event TokensPurchased(
      address account,
      address token,
      uint amount,
      uint rate
   );

   event TokensSold(
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

      token.transfer(msg.sender,tokenAmount); // chuyen token ben mua

      //Emit an event
      emit TokensPurchased(msg.sender,address(token),tokenAmount,rate);
   }   

   function sellTokens(uint _amount) public{

      require(token.balanceOf(msg.sender)>=_amount);// kiem tra nguoi mua co du coin de mua

      uint etherAmount = _amount/rate;

      require(address(this).balance >= etherAmount);// kiem tra etherSwap du coin de ban

      token.transferFrom(msg.sender,address(this),_amount);
      msg.sender.transfer(etherAmount);

      //Emit an event
      emit TokensSold(msg.sender,address(token),_amount,rate);

   }
}

