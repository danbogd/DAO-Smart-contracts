const Reverter = require('./helpers/reverter');
const Asserts = require('./helpers/asserts');
const Loan = artifacts.require('./Loan.sol');

contract('Loan', function(accounts) {
const reverter = new Reverter(web3);
afterEach('revert', reverter.revert);
 
const asserts = Asserts(assert);
const OWNER = accounts[0];
let loans;

  before('setup', () => {
  return Loan.deployed()
  .then(instance => loan = instance)
  .then(reverter.snapshot);
 });
   it('should allow to repay', () => {
    const loaner = accounts[3];
    const value = 1000;
    return Promise.resolve()
    .then(() => loan.take(value, {from: loaner}))
    .then(() => loan.refunds(loaner, value, {from: OWNER}))
    .then(() => loan.loans(loaner))
    .then(asserts.equal(0));
  });

    
    
  it('should fail on overflow when borrowing', () => {
    const loaner = accounts[3];
    const value = '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';
    return Promise.resolve()
    .then(() => loan.take(value, {from: loaner}))
    .then(() => asserts.throws(loan.take(1, {from: loaner})));
  });
    
   

  it('should emit Borrowed event on borrow', () => {
    const loaner = accounts[3];
    const value = 1000;
    return Promise.resolve()
    .then(() => loan.take(value, {from: loaner}))
    .then(result => {
      assert.equal(result.logs.length, 1);
      assert.equal(result.logs[0].event, 'Taken');
      assert.equal(result.logs[0].args.loaner, loaner);
      assert.equal(result.logs[0].args.value.valueOf(), value);
    });
      
     });  
  
  it ('should emit Repayed event on repay', () => {
    const loaner = accounts[3];
    const value = 100;
    return Promise.resolve()
    .then(() => loan.take(value, {from: loaner}))
    .then(() => loan.refunds(loaner,value, {from: OWNER}))
    .then(result => {
      assert.equal(result.logs.length, 1);
      assert.equal(result.logs[0].event, 'Refund');
      assert.equal(result.logs[0].args.loaner, loaner);
      assert.equal(result.logs[0].args.value.valueOf(), value);
});

  }); 
 
   it('should allow to borrow',() =>{
   const loaner = accounts[3];
    const value = 1000;
    return Promise.resolve()
    .then(() => loan.take(value, {from: loaner}))
    .then(() => loan.loans(loaner))
    .then(asserts.equal(1000));
 });      
  
 it('should not allow owner to borrow',()=>{
     const loaner = accounts[3];
    const value = 1000;
    return Promise.resolve()
    .then(() => loan.take(value, {from: OWNER})) 
     .then(() => loan.loans(loaner))
    .then(asserts.equal(0));
 }); 

   it('should not allow not owner to repay',()=>{
   const loaner = accounts[4];
    const value = 1000;
    return Promise.resolve()
   .then(() => loan.refunds(loaner, value, {from: loaner}))
    .then(() => loan.loans(loaner))
    .then(asserts.equal(0));
 }); 
        
    


 it('should direct you for inventing more tests');
});

    

    
    
  
 
    