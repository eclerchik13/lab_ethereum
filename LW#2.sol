// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract RockPaperScissors {
    // камень 1, ножницы 2, бумага 3
    event Winner (address winner);
    address public playerA;
    address public playerB;

    uint private movePlayerA;
    uint private movePlayerB;

    function register() public payable  returns (uint){
        if (playerA == address(0x0)) {
            playerA = payable(msg.sender);
            return 1;    
        } 
        else if (playerB == address(0x0)) {
            playerB = payable(msg.sender);
            return 2;
        }
        return 0;
    }

    function play(uint move) public {
        require(msg.sender == playerA || msg.sender == playerB, "You are not a player");
        require(movePlayerA == 0 || movePlayerB == 0, "You have already made your choice");
        require(move >= 1 && move <= 3, "Invalid choice");

        if (msg.sender == playerA && movePlayerA == 0){
            movePlayerA = move;
        }
        else if (msg.sender == playerB && movePlayerB == 0){
            movePlayerB = move;
        }
    }

    function getWinner() public {
        require(movePlayerA != 0 && movePlayerB != 0, "You have not made your choice.");
        if (movePlayerA == movePlayerB){
            emit Winner(address(0x0)); // ничья 
            resetGame();
        }
        else if ((movePlayerA == 1 && movePlayerB == 2) || (movePlayerA == 2 && movePlayerB == 3) || (movePlayerA == 3 && movePlayerB == 1)) {
            emit Winner(playerA);
            resetGame();
        }
        else {
            emit Winner(playerB);
            resetGame();
        }
    }

    function resetGame() private {
        playerA = payable(address(0x0));
        playerB = payable(address(0x0));
        movePlayerA = 0;
        movePlayerB = 0;
    }

}
