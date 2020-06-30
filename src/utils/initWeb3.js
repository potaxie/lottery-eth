//1.引入web3
let Web3 = require('web3') //1.0版本

//引入包
let HDWalletProvider = require('truffle-hdwallet-provider')


console.log('window web3_____',window.web3.version)//0.20版本


//2.new一个web3实例
let web3 = new Web3()


//3.设置网络，需要使用用户自己的provider来填充web3
//provider 需要使用用户自己的助记词
//metamask 会在chrome 里创建个web3

web3.setProvider(window.web3.currentProvider)

console.log('our web3____',web3.version)
module.exports= web3
