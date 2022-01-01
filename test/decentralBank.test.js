const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");
const {assert}= require("chai")

require('chai')
    .use(require('chai-as-promised')).should();

contract('DecentralBank', ([owner, customer]) => {
    let tether, rwdToken, decentralBank;
    beforeEach(async () => {
        // load contracts
         tether =  await Tether.new();
         rwdToken =  await RWD.new();
        decentralBank = await DecentralBank.new(rwdToken.address, tether.address);

        // transfer tokens
        await rwdToken.transfer(decentralBank.address, '1000000000000000000000000');
        await tether.transfer(customer, '100000000000', {from: owner});
    })
describe('mock tether deployment', async ()=> {
    it('matches name successfully', async () => {
        const name = await tether.name();
        assert.equal(name, 'Tether');
    })
})

    describe('reward token deployment', async ()=> {
        it('matches name successfully', async () => {
            const name = await decentralBank.name();
            assert.equal(name, 'DecentralBank');
        })

        it('contract has tokens', async () => {
            let balance = await rwdToken.balanceOf(DecentralBank.address);
            assert.exists(balance, '100000000000')
        })
    })

    describe('DecentralBank Deployment', async ()=> {
        it('matches name successfully', async () => {
            const name = await rwdToken.name();
            assert.equal(name, 'Reward Token');
        })
    })

})