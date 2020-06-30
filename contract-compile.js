let solc = require('solc')
let fs = require('fs')

// 1.读取合约代码
let contractCode = fs.readFileSync('./contracts/Lottery.sol', 'utf-8')

// 2.编译合约代码
let output = solc.compile(contractCode, 1)
console.log(output)

// 3.执行导出操作
module.exports = output['contracts'][':Lottery']