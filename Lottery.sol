pragma solidity ^0.4.24;


contract Lottery{

// 1.管理员：负责开奖和退奖
// 2.彩民池：address[] player
// 3.当前期数：round，每期结束后+1


address public manager;
address[] public players;
uint256 public round;
address public winner;

constructor() public{
    manager = msg.sender;
}


//1.每个人可以投多次，但是每次只能投1eth
function play() payable public{
    require(msg.value == 1 ether);
    //2.把参与者加入彩民池
    players.push(msg.sender);
}


// 目标：
// * 从彩民池中找到一个随机彩民（以太坊中没有随机数）
// * 找一个特别大的数，保证随机，对我们的彩民数组长度求余数
// * 用hash来实现大的随机数

// 哈希内容随机：
// * 当前时间
// * 挖矿难度
// * 彩民数量


// 转账：
// * 9成给中奖者
// * 1成给管理员

// 清理：
// * 期数加一
// * 清理彩民池

function kaijiang() public{
    bytes memory v1 =abi.encodePacked(block.timestamp,block.difficulty,players.length);
    bytes32 v2 = keccak256(v1);
    uint256 v3 =uint256(v2);

    uint256 index = v3 % players.length;

    winner =players[index];

    uint256 money = address(this).balance * 90/100 ;
    uint256 money1 = address(this).balance-money;

    winner.transfer(money);

    manager.transfer(money1);

    round++;

    delete players;
}


function getBalance() public view returns(uint256){
    return address(this).balance;
}

function getPlayers() public view returns(address[]){
    return players;
}

}


