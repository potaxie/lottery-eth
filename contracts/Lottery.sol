pragma solidity ^0.4.24;


contract Lottery {
    // 1.管理员： 负责开奖和退奖
    // 2.彩民池： address[] players
    // 3.当前期数：round ,每期结束后加一
    // 4.当前中奖者
    address public manager;
    address[] public players;
    uint256 public round;
    address winner;

    constructor() public {
        //设置合约的部署人为管理者
        manager = msg.sender;
    }

    //投注函数
    // 1.每个人可以投多次，但是每次只能投 1 ether
    function play() payable public {
        // 1.每个人可以投多次，但是每次只能投 1 ether
        require(msg.value == 1 ether);
        // 2.把参与者加入彩民池中
        players.push(msg.sender);
    }

    //开奖函数
    // 目标： 从彩民池（数组）中找到一个随机彩民（找一个随机数）
    // 找到一个特别大的数(随机) ,对我们彩民数组长度求余数
    // 用哈希数值来实现大的随机数。 v3
    // 哈希内容的随机：当前时间，区块的挖矿难度，彩民数量，作为输入
    // bytes memory v1 = abi.encodePacked(block.timestamp,block.difficulty,play.length
    // Bytes32 v2 = keccak256(v1)
    // uint256 v3 = uint256(v2)
    function kaiJiang() onlyManager public {
        bytes memory v1 = abi.encodePacked(block.timestamp, block.difficulty, players.length);
        bytes32 v2 = keccak256(v1);
        uint256 v3 = uint256(v2);

        //求余
        uint256 index = v3 % players.length;

        //设置中奖者
        winner = players[index];

        //拿到合约的金额 ，中奖者拿90% 10% 给管理者
        //
        uint256 monry = address(this).balance * 90 / 100;
        uint256 monry1 = address(this).balance - monry;
        //给中奖者和管理员转钱
        winner.transfer(monry);
        manager.transfer(monry1);
        //清理工作
        // 期数+1
        round++;
        //清空中奖者
        delete players;
    }

    // 退奖逻辑
    // 1.遍历player 数组，zu一退款1ether
    // 2.期数加一
    // 3.彩民池清0
    // 调用者花费手续费(管理员)
    function tuiJiang() onlyManager public {
        for (uint256 i = 0; i < players.length; i++) {
            players[i].transfer(1 ether);
        }
        round++;
        delete players;
    }

    // 设置只能管理员能开奖
    modifier onlyManager{
        require(msg.sender == manager);
        _;
    }

    //返回当前参与的人数
    function getPlayCount() public view returns (uint256){
        return players.length;
    }

    // 查看当前余额
    function getBalance() public view returns (uint256){
        return address(this).balance;
    }
    //返回所有的彩民和参考者
    function getPlayers() public view returns (address[]){
        return players;
    }

}