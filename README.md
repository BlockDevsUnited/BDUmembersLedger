# BDUmembershipLedger

This code lets you start with a base contract, and deploy owner contracts on top each with unique functions, creating a chain of owned contracts commanded at the top by a user address. 

Add to the chain to add functionality
Remove from the top of the chain to remove functionality
Insert another chain at any level to change functionality. 

Step 1. Deploy BDUmembershipLedger contract

Step 2. Deploy Owner1 passing above contract address into constructor

Step 3. Deploy Owner2 passing Owner1 into constructor

Step 4. Change membership Owner to Owner1 by passing in (address Owner1, uint 0)

Step 5. Repeat Step 4 for Owner2

Step 6. To change ownership x levels under you, pass in (address newOwner, uint x) 

Step 7. Stack new contracts on the ownership chain as you see fit 

Step 8. Change ownerships anywhere down the line as you see fit

Step 9. Add a member from the top contract

Step 10. ?????????  

Step 11. Profit
