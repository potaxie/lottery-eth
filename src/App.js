import React, {Component} from 'react';
import {CardContent} from "semantic-ui-react";

let web3 = require('./utils/initWeb3')
let lotteryInstance = require('./eth/lotteryInstance')


//react 语法
//浏览器-》public-》index.html-》index.js-》App.js

class App extends Component {

    constructor() {
        super();

        this.state = {
            manager: '',
            round: '',
            winner: '',
            palyerCount: 0,
            balance: 0,
            palyers: [],

        }
    }

    //内置钩子函数，在页面渲染之前调用
    componentDidMount() {

    }

    //内置钩子函数，在页面渲染之前调用
    async componentWillMount() {
        let manager = await lotteryInstance.methods.manager().call()
        let round = await lotteryInstance.methods.round().call()
        let winner = await lotteryInstance.methods.winner().call()
        let palyerCounts = await lotteryInstance.methods.getPlayersCount().call()
        let balance = await lotteryInstance.methods.getBalance().call()
        let players = await lotteryInstance.methods.getPlayers().call()

        this.setState({
            manager,
            round,
            winner,
            palyerCounts,
            balance,
            players,
        })
    }

    //卸载钩子函数
    //componentDidMount


    render() {
        let a = 'HelloWorld'
        return (
            <div>

                <CardContent
                    helloworld:{a}
                    manger:{this.state.manager}
                    round:{this.state.round}
                    winner:{this.state.winner}
                    balance:{this.state.balance}
                    palyers:{this.state.palyers}
                    palyerCounts:{this.state.palyerCounts}
                    play={this.play()} //在ui.js button 里面添加函数

                />
            </div>
        );
    }

}

export default App;
